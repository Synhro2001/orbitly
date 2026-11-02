-- Profile: changing the handle. At most once in 30 days; the old handle
-- stays reserved for 14 days, so nobody can take it over and pretend to be
-- the person their friends know. Name and planet name are changed directly
-- (column grants and length checks from the core migration).

alter table public.profiles add column handle_changed_at timestamptz;

create table public.released_handles (
  handle text primary key,
  user_id uuid not null references public.profiles (id) on delete cascade,
  released_at timestamptz not null default now()
);
alter table public.released_handles enable row level security;
revoke all on public.released_handles from anon, authenticated;

-- Used by someone else, or recently released by someone else.
create function private.handle_taken(p_handle text, p_me uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (select 1 from public.profiles where handle = p_handle and id <> p_me)
    or exists (
      select 1 from public.released_handles
      where handle = p_handle and user_id <> p_me
        and released_at > now() - interval '14 days'
    );
$$;

-- For the live check while typing: ok, invalid, taken or mine.
create function public.check_handle(p_handle text)
returns text
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  h text := lower(btrim(ltrim(btrim(p_handle), '@')));
begin
  if h !~ '^[a-z0-9._]{3,32}$' then
    return 'invalid';
  end if;
  if exists (select 1 from public.profiles where id = me and handle = h) then
    return 'mine';
  end if;
  if private.handle_taken(h, me) then
    return 'taken';
  end if;
  return 'ok';
end;
$$;

create function public.change_handle(p_handle text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  h text := lower(btrim(ltrim(btrim(p_handle), '@')));
  current_profile public.profiles;
begin
  select * into current_profile from public.profiles where id = me for update;
  if current_profile.handle = h then
    return;
  end if;
  if current_profile.handle_changed_at > now() - interval '30 days' then
    raise exception 'Handle changed less than 30 days ago' using errcode = '55000';
  end if;
  if h !~ '^[a-z0-9._]{3,32}$' then
    raise exception 'Invalid handle' using errcode = '22023';
  end if;
  if private.handle_taken(h, me) then
    raise exception 'Handle taken' using errcode = '23505';
  end if;

  insert into public.released_handles (handle, user_id)
  values (current_profile.handle, me)
  on conflict (handle) do update
    set user_id = excluded.user_id, released_at = now();
  -- Taking back my own old handle ends its reservation.
  delete from public.released_handles where handle = h;
  update public.profiles
    set handle = h, handle_changed_at = now()
    where id = me;
end;
$$;

-- New planets do not get a reserved handle either.
create or replace function public.complete_onboarding(
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
  while private.handle_taken(candidate, me) loop
    n := n + 1;
    candidate := base || n::text;
  end loop;

  -- Take only the base fields from the given look; the table constraint
  -- checks the rest.
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

revoke execute on function private.handle_taken(text, uuid) from public, anon, authenticated;
revoke execute on function public.check_handle(text), public.change_handle(text)
  from public, anon;
grant execute on function public.check_handle(text), public.change_handle(text)
  to authenticated;
