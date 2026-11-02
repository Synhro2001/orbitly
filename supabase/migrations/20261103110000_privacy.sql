-- Privacy settings enforced on the server: who can find me by handle, who
-- can send me a friend request, who sees my mood. Plus invite codes: a link
-- or QR code from me lets its holder send a request whatever my settings
-- say, so a new user with no friends can still be added by the people they
-- invite.

-- Friends now see each other only through server functions, which apply
-- the settings. Read straight from the table, a friend's mood (and anything
-- else added later) would bypass them.
drop policy "Profiles: me and my friends" on public.profiles;
create policy "Profiles: only your own"
  on public.profiles for select to authenticated
  using (id = (select auth.uid()));

-- ---------------------------------------------------------------------------
-- Relations
-- ---------------------------------------------------------------------------

-- Not friends, but with at least one friend in common.
create function private.are_friends_of_friends(a uuid, b uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.friendships f1
    join public.friendships f2
      on (case when f1.user_a = a then f1.user_b else f1.user_a end)
       = (case when f2.user_a = b then f2.user_b else f2.user_a end)
    where f1.status = 'accepted' and a in (f1.user_a, f1.user_b)
      and f2.status = 'accepted' and b in (f2.user_a, f2.user_b)
  );
$$;

-- Close orbit: a friend with closeness 70 or more.
create function private.in_close_orbit(a uuid, b uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select coalesce((
    select cl.score >= 70 from public.closeness cl
    where cl.user_a = least(a, b) and cl.user_b = greatest(a, b)
  ), false);
$$;

-- Can p_viewer find p_target by handle?
create function private.can_find(p_viewer uuid, p_target uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select case (private.settings_of(p_target)).search_visibility
    when 'everyone' then true
    when 'friendsOfFriends' then private.are_friends_of_friends(p_viewer, p_target)
    else false
  end;
$$;

-- Can p_sender send p_target a friend request without an invite?
create function private.can_request(p_sender uuid, p_target uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select case (private.settings_of(p_target)).request_policy
    when 'everyone' then true
    when 'friendsOfFriends' then private.are_friends_of_friends(p_sender, p_target)
    else false
  end;
$$;

-- Can p_viewer (a friend) see p_owner's mood?
create function private.can_see_mood(p_viewer uuid, p_owner uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select case (private.settings_of(p_owner)).mood_audience
    when 'friends' then true
    when 'closeOrbit' then private.in_close_orbit(p_viewer, p_owner)
    else false
  end;
$$;

-- ---------------------------------------------------------------------------
-- Search and requests
-- ---------------------------------------------------------------------------

create or replace function public.search_profiles(p_query text)
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
      and private.can_find(me, p.id)
    order by p.handle
    limit 20;
end;
$$;

-- p_via_invite: the target's own invite was used, which overrides the
-- request policy.
create function private.request_friendship(me uuid, p_user uuid, p_via_invite boolean)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  existing public.friendships;
begin
  if p_user = me or not exists (select 1 from public.profiles where id = p_user) then
    raise exception 'Unknown user' using errcode = '22023';
  end if;

  select * into existing
    from public.friendships
    where user_a = least(me, p_user) and user_b = greatest(me, p_user);

  if found and existing.status = 'pending' and existing.requested_by = p_user then
    -- A request the other way already exists, so both want to be friends.
    perform public.respond_friend_request(p_user, true);
    return;
  end if;
  if found then
    return;
  end if;
  if not p_via_invite and not private.can_request(me, p_user) then
    raise exception 'Requests are closed' using errcode = '42501';
  end if;
  insert into public.friendships (user_a, user_b, status, requested_by)
  values (least(me, p_user), greatest(me, p_user), 'pending', me);
end;
$$;

create or replace function public.send_friend_request(p_user uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  perform private.request_friendship(private.require_user(), p_user, false);
end;
$$;

-- ---------------------------------------------------------------------------
-- Invites
-- ---------------------------------------------------------------------------

-- One code per user. Not readable by clients: only through the functions.
create table public.invites (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  code text not null unique,
  created_at timestamptz not null default now()
);
alter table public.invites enable row level security;
revoke all on public.invites from anon, authenticated;

-- 16 hex characters, 64 random bits: not guessable.
create function private.new_invite_code()
returns text
language sql
volatile
set search_path = ''
as $$
  select substr(replace(gen_random_uuid()::text, '-', ''), 1, 16);
$$;

create function public.get_my_invite_code()
returns text
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  v_code text;
begin
  select code into v_code from public.invites where user_id = me;
  if v_code is null then
    insert into public.invites (user_id, code)
    values (me, private.new_invite_code())
    returning code into v_code;
  end if;
  return v_code;
end;
$$;

-- A new code; links and QR codes with the old one stop working.
create function public.rotate_invite_code()
returns text
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  v_code text := private.new_invite_code();
begin
  insert into public.invites (user_id, code) values (me, v_code)
  on conflict (user_id) do update set code = excluded.code, created_at = now();
  return v_code;
end;
$$;

-- Who invites me: shown before sending the request.
create function public.get_invite(p_code text)
returns table (id uuid, handle text, display_name text, appearance jsonb)
language sql
stable
security definer
set search_path = ''
as $$
  select p.id, p.handle, p.display_name, p.appearance
  from public.invites i
  join public.profiles p on p.id = i.user_id
  where i.code = p_code and (select auth.uid()) is not null;
$$;

create function public.send_friend_request_by_invite(p_code text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  v_owner uuid;
begin
  select user_id into v_owner from public.invites where code = p_code;
  if v_owner is null then
    raise exception 'Unknown invite' using errcode = 'P0002';
  end if;
  perform private.request_friendship(me, v_owner, true);
end;
$$;

-- ---------------------------------------------------------------------------
-- Mood in the friend list
-- ---------------------------------------------------------------------------

create or replace function public.get_my_friends()
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
    -- Hidden (null) when the friend does not share it with me.
    case when private.can_see_mood((select auth.uid()), p.id) then p.mood end,
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

-- ---------------------------------------------------------------------------
-- Privileges
-- ---------------------------------------------------------------------------

revoke execute on function
  private.are_friends_of_friends(uuid, uuid),
  private.in_close_orbit(uuid, uuid),
  private.can_find(uuid, uuid),
  private.can_request(uuid, uuid),
  private.can_see_mood(uuid, uuid),
  private.request_friendship(uuid, uuid, boolean),
  private.new_invite_code()
  from public, anon, authenticated;
revoke execute on function
  public.get_my_invite_code(),
  public.rotate_invite_code(),
  public.get_invite(text),
  public.send_friend_request_by_invite(text)
  from public, anon;
grant execute on function
  public.get_my_invite_code(),
  public.rotate_invite_code(),
  public.get_invite(text),
  public.send_friend_request_by_invite(text)
  to authenticated;
