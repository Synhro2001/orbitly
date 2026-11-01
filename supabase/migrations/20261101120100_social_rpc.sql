-- Действия клиента, которые нельзя доверить прямой записи в таблицы:
-- создание профиля, заявки в друзья, тень. Всё — security definer с пустым
-- search_path и явной проверкой, кто вызывает.

-- Функции, создаваемые в public, по умолчанию может вызвать кто угодно.
-- Отбираем это право и выдаём точечно.
alter default privileges in schema public revoke execute on functions from public;
alter default privileges in schema private revoke execute on functions from public;

create function private.require_user()
returns uuid
language plpgsql
stable
set search_path = ''
as $$
declare
  me uuid := auth.uid();
begin
  if me is null then
    raise exception 'Not authenticated' using errcode = '42501';
  end if;
  return me;
end;
$$;

-- ---------------------------------------------------------------------------
-- Онбординг: создать свою планету. Ник генерируется из email.
-- ---------------------------------------------------------------------------

create function public.complete_onboarding(
  p_display_name text,
  p_planet_name text,
  p_appearance jsonb
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  base text;
  candidate text;
  n int := 0;
begin
  if exists (select 1 from public.profiles where id = me) then
    raise exception 'Profile already exists' using errcode = '23505';
  end if;

  select left(regexp_replace(lower(split_part(u.email, '@', 1)), '[^a-z0-9._]', '', 'g'), 26)
    into base
    from auth.users u
    where u.id = me;
  if base is null or char_length(base) < 3 then
    base := 'planet';
  end if;

  candidate := base;
  while exists (select 1 from public.profiles where handle = candidate) loop
    n := n + 1;
    candidate := base || n::text;
  end loop;

  -- Из присланного вида берём только базовые поля; остальное проверит
  -- ограничение таблицы.
  insert into public.profiles (id, handle, display_name, planet_name, appearance)
  values (
    me,
    candidate,
    btrim(p_display_name),
    btrim(p_planet_name),
    jsonb_build_object(
      'type', p_appearance -> 'type',
      'seed', p_appearance -> 'seed',
      'hue', p_appearance -> 'hue'
    )
  );
end;
$$;

-- ---------------------------------------------------------------------------
-- Друзья
-- ---------------------------------------------------------------------------

-- Поиск по нику. Чужие профили закрыты RLS, поэтому отдаём только то, что
-- нужно для карточки, и не больше 20 записей.
create function public.search_profiles(p_query text)
returns table (
  id uuid,
  handle text,
  display_name text,
  appearance jsonb
)
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  q text := lower(btrim(ltrim(btrim(p_query), '@')));
begin
  if char_length(q) = 0 or char_length(q) > 32 then
    return;
  end if;
  return query
    select p.id, p.handle, p.display_name, p.appearance
    from public.profiles p
    where p.id <> me
      and position(q in p.handle) > 0
      and not private.are_friends(me, p.id)
    order by p.handle
    limit 20;
end;
$$;

create function public.send_friend_request(p_user uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  existing public.friendships;
begin
  if p_user = me or not exists (select 1 from public.profiles where id = p_user) then
    raise exception 'Unknown user' using errcode = '22023';
  end if;

  select * into existing
    from public.friendships
    where user_a = least(me, p_user) and user_b = greatest(me, p_user);

  if not found then
    insert into public.friendships (user_a, user_b, status, requested_by)
    values (least(me, p_user), greatest(me, p_user), 'pending', me);
  elsif existing.status = 'pending' and existing.requested_by = p_user then
    -- Встречная заявка — значит, оба хотят дружить.
    perform public.respond_friend_request(p_user, true);
  end if;
end;
$$;

create function public.respond_friend_request(p_user uuid, p_accept boolean)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  if p_accept then
    update public.friendships
      set status = 'accepted', accepted_at = now()
      where user_a = least(me, p_user)
        and user_b = greatest(me, p_user)
        and status = 'pending'
        and requested_by = p_user;
    -- Запись о близости и первые достижения создаёт триггер на friendships.
  else
    delete from public.friendships
      where user_a = least(me, p_user)
        and user_b = greatest(me, p_user)
        and status = 'pending'
        and requested_by = p_user;
  end if;
end;
$$;

create function public.get_incoming_requests()
returns table (
  user_id uuid,
  handle text,
  display_name text,
  appearance jsonb,
  created_at timestamptz
)
language sql
stable
security definer
set search_path = ''
as $$
  select p.id, p.handle, p.display_name, p.appearance, f.created_at
  from public.friendships f
  join public.profiles p on p.id = f.requested_by
  where f.status = 'pending'
    and (select auth.uid()) in (f.user_a, f.user_b)
    and f.requested_by <> (select auth.uid())
  order by f.created_at desc;
$$;

-- ---------------------------------------------------------------------------
-- Тень: те же правила, что ShadowPolicy в приложении.
-- ---------------------------------------------------------------------------

create function public.set_shadow(p_days int)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  if p_days not between 1 and 7 then
    raise exception 'Shadow must last 1 to 7 days' using errcode = '22023';
  end if;
  -- Новую тень нельзя поставить поверх текущей: иначе её можно продлевать
  -- бесконечно.
  if exists (
    select 1 from public.profiles
    where id = me and shadow_from <= now() and now() < shadow_until
  ) then
    raise exception 'Already in shadow' using errcode = '22023';
  end if;
  update public.profiles
    set shadow_from = now(), shadow_until = now() + make_interval(days => p_days)
    where id = me;
end;
$$;

-- Досрочный выход: тень заканчивается сейчас, а не стирается, чтобы серии,
-- которые она держала, получили свежие сутки.
create function public.leave_shadow()
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  update public.profiles
    set shadow_until = now()
    where id = me and shadow_from <= now() and now() < shadow_until;
end;
$$;

revoke execute on all functions in schema public from public, anon;
revoke execute on all functions in schema private from public, anon, authenticated;
-- Нужны ролям клиента напрямую: в политиках RLS и в проверке колонки
-- appearance при обновлении профиля.
grant execute on function
  private.are_friends(uuid, uuid),
  private.is_valid_base_appearance(jsonb)
  to authenticated;
grant execute on function
  public.complete_onboarding(text, text, jsonb),
  public.search_profiles(text),
  public.send_friend_request(uuid),
  public.respond_friend_request(uuid, boolean),
  public.get_incoming_requests(),
  public.set_shadow(int),
  public.leave_shadow()
  to authenticated;
