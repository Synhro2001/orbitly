-- Safety: block, quiet orbit (mute) and reports.
--
-- Blocking hides two people from each other everywhere: it ends the
-- friendship (and so the chat, the orbit and the friend list, which all
-- require friendship), removes pending requests, and stops search, new
-- requests and invites in both directions.
--
-- Quiet orbit mutes a friend for me only: no notifications and no glow on
-- their planet. The friend is not told.
--
-- Reports are kept for moderation (DSA: a clear way to report). Clients can
-- only file them; nobody reads them through the API.

create table public.blocks (
  blocker uuid not null references public.profiles (id) on delete cascade,
  blocked uuid not null references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (blocker, blocked),
  check (blocker <> blocked)
);
create index blocks_blocked_idx on public.blocks (blocked);

create table public.mutes (
  user_id uuid not null references public.profiles (id) on delete cascade,
  muted uuid not null references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, muted),
  check (user_id <> muted)
);

create table public.reports (
  id uuid primary key default gen_random_uuid(),
  reporter uuid references public.profiles (id) on delete set null,
  target uuid references public.profiles (id) on delete set null,
  reason text not null check (reason in (
    'spam', 'harassment', 'inappropriate', 'impersonation', 'underage', 'other')),
  details text check (char_length(details) <= 1000),
  status text not null default 'open' check (status in ('open', 'reviewed', 'closed')),
  created_at timestamptz not null default now()
);
create index reports_reporter_created_idx on public.reports (reporter, created_at);

alter table public.blocks enable row level security;
alter table public.mutes enable row level security;
alter table public.reports enable row level security;
revoke all on public.blocks, public.mutes, public.reports from anon, authenticated;

-- Either of the two has blocked the other.
create function private.is_blocked(a uuid, b uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.blocks
    where (blocker = a and blocked = b) or (blocker = b and blocked = a)
  );
$$;

-- ---------------------------------------------------------------------------
-- Block
-- ---------------------------------------------------------------------------

create function public.block_user(p_user uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  if p_user = me or not exists (select 1 from public.profiles where id = p_user) then
    raise exception 'Unknown user' using errcode = '22023';
  end if;
  insert into public.blocks (blocker, blocked) values (me, p_user)
  on conflict do nothing;
  -- Friendship or pending request, and the pair's closeness.
  delete from public.friendships
    where user_a = least(me, p_user) and user_b = greatest(me, p_user);
  delete from public.closeness
    where user_a = least(me, p_user) and user_b = greatest(me, p_user);
  delete from public.mutes where user_id = me and muted = p_user;
end;
$$;

-- Unblocking does not bring the friendship back: a new request is needed.
create function public.unblock_user(p_user uuid)
returns void
language sql
security definer
set search_path = ''
as $$
  delete from public.blocks
  where blocker = private.require_user() and blocked = p_user;
$$;

create function public.get_blocked()
returns table (id uuid, handle text, display_name text, appearance jsonb, blocked_at timestamptz)
language sql
stable
security definer
set search_path = ''
as $$
  select p.id, p.handle, p.display_name, p.appearance, b.created_at
  from public.blocks b
  join public.profiles p on p.id = b.blocked
  where b.blocker = (select auth.uid())
  order by b.created_at desc;
$$;

-- ---------------------------------------------------------------------------
-- Quiet orbit
-- ---------------------------------------------------------------------------

create function public.mute_friend(p_friend uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  if not private.are_friends(me, p_friend) then
    raise exception 'Not friends' using errcode = '42501';
  end if;
  insert into public.mutes (user_id, muted) values (me, p_friend)
  on conflict do nothing;
end;
$$;

create function public.unmute_friend(p_friend uuid)
returns void
language sql
security definer
set search_path = ''
as $$
  delete from public.mutes
  where user_id = private.require_user() and muted = p_friend;
$$;

create function public.get_muted()
returns table (id uuid, handle text, display_name text, appearance jsonb)
language sql
stable
security definer
set search_path = ''
as $$
  select p.id, p.handle, p.display_name, p.appearance
  from public.mutes m
  join public.profiles p on p.id = m.muted
  where m.user_id = (select auth.uid())
    and private.are_friends(m.user_id, m.muted)
  order by p.display_name;
$$;

-- ---------------------------------------------------------------------------
-- Reports
-- ---------------------------------------------------------------------------

create function public.report_user(p_user uuid, p_reason text, p_details text default null)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  if p_user = me or not exists (select 1 from public.profiles where id = p_user) then
    raise exception 'Unknown user' using errcode = '22023';
  end if;
  -- Twenty a day is plenty for a person and stops a flood.
  if (select count(*) from public.reports
      where reporter = me and created_at > now() - interval '1 day') >= 20 then
    raise exception 'Too many reports' using errcode = '54000';
  end if;
  insert into public.reports (reporter, target, reason, details)
  values (me, p_user, p_reason, nullif(btrim(p_details), ''));
end;
$$;

-- ---------------------------------------------------------------------------
-- Blocks in search, requests and invites
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
      and not private.is_blocked(me, p.id)
      and private.can_find(me, p.id)
    order by p.handle
    limit 20;
end;
$$;

create or replace function private.request_friendship(me uuid, p_user uuid, p_via_invite boolean)
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
  -- Not even an invite gets past a block.
  if private.is_blocked(me, p_user) then
    raise exception 'Requests are closed' using errcode = '42501';
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

create or replace function public.get_invite(p_code text)
returns table (id uuid, handle text, display_name text, appearance jsonb)
language sql
stable
security definer
set search_path = ''
as $$
  select p.id, p.handle, p.display_name, p.appearance
  from public.invites i
  join public.profiles p on p.id = i.user_id
  where i.code = p_code
    and (select auth.uid()) is not null
    and not private.is_blocked((select auth.uid()), p.id);
$$;

-- ---------------------------------------------------------------------------
-- Muted friends in the friend list: the app skips their glow
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
  has_unread_snaps boolean,
  muted boolean
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
    ),
    exists (
      select 1 from public.mutes mu
      where mu.user_id = (select auth.uid()) and mu.muted = p.id
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

revoke execute on function private.is_blocked(uuid, uuid) from public, anon, authenticated;
revoke execute on function
  public.block_user(uuid), public.unblock_user(uuid), public.get_blocked(),
  public.mute_friend(uuid), public.unmute_friend(uuid), public.get_muted(),
  public.report_user(uuid, text, text), public.get_my_friends()
  from public, anon;
grant execute on function
  public.block_user(uuid), public.unblock_user(uuid), public.get_blocked(),
  public.mute_friend(uuid), public.unmute_friend(uuid), public.get_muted(),
  public.report_user(uuid, text, text), public.get_my_friends()
  to authenticated;
