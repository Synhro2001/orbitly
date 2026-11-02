-- Чат: текст и капсулы времени через серверные функции.
--
-- Клиент не читает таблицу messages напрямую — ни select, ни Realtime.
-- Так текст чужой капсулы физически не уходит с сервера до срока.
-- О новых сообщениях приложение узнаёт по Realtime из interactions:
-- там только «кто, кому, когда», без текста.
--
-- Снапы пока не отправляются (нужно хранилище медиа), но полученный снап
-- можно открыть, и он подсвечивается как непрочитанный.

-- View из первой миграции требовал права на саму таблицу — а с ними текст
-- капсулы можно было бы прочитать в обход view. Заменён функциями ниже.
drop view public.messages_visible;

-- Сообщение глазами пользователя p_me: чужая капсула до срока — без текста.
create function private.message_for(m public.messages, p_me uuid)
returns table (
  id uuid,
  kind text,
  is_mine boolean,
  sent_at timestamptz,
  text text,
  opens_at timestamptz,
  opened boolean
)
language sql
stable
set search_path = ''
as $$
  select
    m.id,
    m.kind,
    m.from_user = p_me,
    m.created_at,
    case
      when m.kind = 'capsule' and m.from_user <> p_me and m.opens_at > now()
      then null
      else m.body
    end,
    m.opens_at,
    m.opened_at is not null;
$$;

-- Защита от спама и случайных циклов в клиенте: не больше 30 сообщений
-- в минуту от одного пользователя.
create function private.check_send_rate(p_user uuid)
returns void
language plpgsql
stable
set search_path = ''
as $$
begin
  if (select count(*) from public.messages
      where from_user = p_user
        and created_at > clock_timestamp() - interval '1 minute') >= 30
  then
    raise exception 'Too many messages' using errcode = '54000';
  end if;
end;
$$;

-- Общие проверки отправки: друзья, длина текста, частота.
create function private.prepare_send(p_to uuid, p_text text)
returns text
language plpgsql
stable
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  v_text text := btrim(p_text);
begin
  if not private.are_friends(me, p_to) then
    raise exception 'Messages are allowed only between friends'
      using errcode = '42501';
  end if;
  if v_text is null or char_length(v_text) not between 1 and 1000 then
    raise exception 'Message must be 1..1000 characters' using errcode = '22023';
  end if;
  perform private.check_send_rate(me);
  return v_text;
end;
$$;

-- ---------------------------------------------------------------------------
-- Отправка
-- ---------------------------------------------------------------------------

create function public.send_message(p_to uuid, p_text text)
returns table (
  id uuid, kind text, is_mine boolean, sent_at timestamptz,
  text text, opens_at timestamptz, opened boolean
)
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  v_text text := private.prepare_send(p_to, p_text);
  v_msg public.messages;
begin
  -- clock_timestamp, а не now(): порядок сохраняется и внутри одной транзакции.
  insert into public.messages (from_user, to_user, kind, body, created_at)
    values (me, p_to, 'text', v_text, clock_timestamp())
    returning * into v_msg;
  -- Журнал событий: близость, серия, достижения и сигнал для Realtime.
  insert into public.interactions (from_user, to_user, kind)
    values (me, p_to, 'text');
  return query select * from private.message_for(v_msg, me);
end;
$$;

create function public.send_capsule(p_to uuid, p_text text, p_opens_at timestamptz)
returns table (
  id uuid, kind text, is_mine boolean, sent_at timestamptz,
  text text, opens_at timestamptz, opened boolean
)
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  v_text text := private.prepare_send(p_to, p_text);
  v_msg public.messages;
begin
  if p_opens_at is null
    or p_opens_at <= now()
    or p_opens_at > now() + interval '366 days'
  then
    raise exception 'Capsule must open within a year' using errcode = '22023';
  end if;
  insert into public.messages (from_user, to_user, kind, body, opens_at, created_at)
    values (me, p_to, 'capsule', v_text, p_opens_at, clock_timestamp())
    returning * into v_msg;
  insert into public.interactions (from_user, to_user, kind)
    values (me, p_to, 'capsule_sent');
  return query select * from private.message_for(v_msg, me);
end;
$$;

-- ---------------------------------------------------------------------------
-- Чтение
-- ---------------------------------------------------------------------------

-- Переписка с другом, последние p_limit сообщений по порядку.
-- Попутно открывает капсулы, срок которых наступил: получатель их увидел —
-- это событие capsule_opened (достижение «Хранитель времени»).
create function public.get_thread(p_friend uuid, p_limit int default 200)
returns table (
  id uuid, kind text, is_mine boolean, sent_at timestamptz,
  text text, opens_at timestamptz, opened boolean
)
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  v_opened int;
begin
  if not private.are_friends(me, p_friend) then
    raise exception 'Not friends' using errcode = '42501';
  end if;

  with opened as (
    update public.messages m
      set opened_at = now()
      where m.from_user = p_friend and m.to_user = me
        and m.kind = 'capsule' and m.opened_at is null
        and m.opens_at <= now()
      returning m.id
  )
  select count(*) into v_opened from opened;

  for i in 1..v_opened loop
    insert into public.interactions (from_user, to_user, kind)
      values (me, p_friend, 'capsule_opened');
  end loop;

  return query
    select x.*
    from (
      select m as msg
      from public.messages m
      where (m.from_user = me and m.to_user = p_friend)
         or (m.from_user = p_friend and m.to_user = me)
      order by m.created_at desc
      limit least(greatest(p_limit, 1), 500)
    ) recent
    cross join lateral private.message_for(recent.msg, me) x
    order by x.sent_at;
end;
$$;

-- Последнее сообщение с каждым другом — для списка чатов.
create function public.get_chat_previews()
returns table (
  friend_id uuid,
  id uuid, kind text, is_mine boolean, sent_at timestamptz,
  text text, opens_at timestamptz, opened boolean
)
language sql
stable
security definer
set search_path = ''
as $$
  select last.friend_id, x.*
  from (
    select distinct on (friend_id) m as msg,
      case when m.from_user = (select auth.uid()) then m.to_user else m.from_user end
        as friend_id
    from public.messages m
    where (select auth.uid()) in (m.from_user, m.to_user)
    order by friend_id, m.created_at desc
  ) last
  cross join lateral private.message_for(last.msg, (select auth.uid())) x
  where private.are_friends((select auth.uid()), last.friend_id);
$$;

-- Открыть полученный снап (смотреть можно один раз).
create function public.open_snap(p_message uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  update public.messages
    set opened_at = now()
    where id = p_message and to_user = me and kind = 'snap'
      and opened_at is null;
  if not found then
    raise exception 'Snap not found or already opened' using errcode = 'P0002';
  end if;
end;
$$;

-- ---------------------------------------------------------------------------
-- Друзья: добавляем «есть непросмотренные снапы» (свечение на карте).
-- ---------------------------------------------------------------------------

drop function public.get_my_friends();

create function public.get_my_friends()
returns table (
  id uuid,
  handle text,
  display_name text,
  planet_name text,
  appearance jsonb,
  equipped jsonb,
  mood text,
  closeness int,
  streak_days int,
  last_exchange_at timestamptz,
  shadow_from timestamptz,
  shadow_until timestamptz,
  trophies jsonb,
  has_unread_snaps boolean
)
language sql
stable
security definer
set search_path = ''
as $$
  select
    p.id,
    p.handle,
    p.display_name,
    p.planet_name,
    p.appearance,
    coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', c.id, 'title', c.title, 'kind', c.kind,
        'rarity', c.rarity, 'params', c.params))
      from public.user_cosmetics uc
      join public.cosmetics c on c.id = uc.cosmetic_id
      where uc.user_id = p.id and uc.equipped
    ), '[]'::jsonb),
    p.mood,
    coalesce(cl.score, 0),
    coalesce(cl.streak_days, 0),
    cl.last_exchange_at,
    p.shadow_from,
    p.shadow_until,
    coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', a.id, 'title', a.title, 'icon', a.icon,
        'rarity', a.rarity, 'earned_at', pt.earned_at) order by pt.earned_at)
      from public.pair_trophies pt
      join public.achievements a on a.id = pt.achievement_id
      where pt.user_a = f.user_a and pt.user_b = f.user_b
    ), '[]'::jsonb),
    exists (
      select 1 from public.messages m
      where m.from_user = p.id and m.to_user = (select auth.uid())
        and m.kind = 'snap' and m.opened_at is null
    )
  from public.friendships f
  join public.profiles p
    on p.id = case when f.user_a = (select auth.uid()) then f.user_b else f.user_a end
  left join public.closeness cl
    on cl.user_a = f.user_a and cl.user_b = f.user_b
  where f.status = 'accepted'
    and (select auth.uid()) in (f.user_a, f.user_b)
  order by cl.score desc nulls last;
$$;

create index messages_to_created_idx on public.messages (to_user, created_at);

-- ---------------------------------------------------------------------------
-- Права и Realtime
-- ---------------------------------------------------------------------------

revoke execute on all functions in schema public from public, anon;
revoke execute on all functions in schema private from public, anon, authenticated;
grant execute on function
  private.are_friends(uuid, uuid),
  private.is_valid_base_appearance(jsonb)
  to authenticated;
grant execute on function
  public.send_message(uuid, text),
  public.send_capsule(uuid, text, timestamptz),
  public.get_thread(uuid, int),
  public.get_chat_previews(),
  public.open_snap(uuid),
  public.get_my_friends()
  to authenticated;

-- Сигнал о новом сообщении: строка журнала без текста (RLS: только свои).
alter publication supabase_realtime add table public.interactions;
