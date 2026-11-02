-- Account and data: deleting the account (with 7 days to change one's mind)
-- and downloading one's data (GDPR art. 17 and 20).
--
-- Deletion:
--   1. request_account_deletion() — only right after signing in again with a
--      code from email (the session must be at most 10 minutes old). The
--      account is hidden from everyone at once: friendships are paused,
--      pending requests removed, search, requests and invites closed.
--   2. Signing in within 7 days and calling cancel_account_deletion() brings
--      everything back.
--   3. A daily job deletes the user from auth.users after 7 days; the
--      profile, planet, achievements, messages, friendships and settings go
--      with it (on delete cascade). A friend keeps the achievements they
--      unlocked together (their own user_achievements rows).
-- It runs inside the database, so no service role key is needed anywhere.

alter table public.profiles add column deletion_requested_at timestamptz;

alter table public.friendships drop constraint friendships_status_check;
alter table public.friendships add constraint friendships_status_check
  check (status in ('pending', 'accepted', 'paused'));

-- Hidden while waiting for deletion.
create function private.is_leaving(p_user uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select coalesce(
    (select deletion_requested_at is not null from public.profiles where id = p_user),
    false);
$$;

-- Only a fresh sign-in with a code from email: the newest such entry in the
-- session's authentication methods is at most 10 minutes old.
create function private.recently_verified()
returns boolean
language sql
stable
set search_path = ''
as $$
  select coalesce((
    select max((x ->> 'timestamp')::bigint) > extract(epoch from now()) - 600
    from jsonb_array_elements(coalesce(auth.jwt() -> 'amr', '[]'::jsonb)) x
    where x ->> 'method' in ('otp', 'magiclink')
  ), false);
$$;

-- A re-accepted (unpaused) friendship keeps its chat rule.
create or replace function private.on_friendship_accepted()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.status = 'accepted' and (tg_op = 'INSERT' or old.status = 'pending') then
    new.message_retention := coalesce(private.stricter_retention(
      (private.settings_of(new.user_a)).message_retention,
      (private.settings_of(new.user_b)).message_retention
    ), 'day');
  end if;
  return new;
end;
$$;

create function public.request_account_deletion()
returns timestamptz
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  if not private.recently_verified() then
    raise exception 'Confirm with a code from email first' using errcode = '42501';
  end if;
  update public.profiles
    set deletion_requested_at = coalesce(deletion_requested_at, now())
    where id = me;
  update public.friendships set status = 'paused'
    where status = 'accepted' and me in (user_a, user_b);
  delete from public.friendships
    where status = 'pending' and me in (user_a, user_b);
  return (select deletion_requested_at + interval '7 days'
          from public.profiles where id = me);
end;
$$;

-- True if a deletion was waiting and is now cancelled.
create function public.cancel_account_deletion()
returns boolean
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  update public.profiles set deletion_requested_at = null
    where id = me and deletion_requested_at is not null;
  if not found then
    return false;
  end if;
  -- Friendships come back, unless the friend is leaving too.
  update public.friendships f set status = 'accepted'
    where f.status = 'paused' and me in (f.user_a, f.user_b)
      and not private.is_leaving(case when f.user_a = me then f.user_b else f.user_a end);
  return true;
end;
$$;

create function private.purge_deleted_accounts()
returns int
language sql
security definer
set search_path = ''
as $$
  with gone as (
    delete from auth.users u
    using public.profiles p
    where p.id = u.id
      and p.deletion_requested_at < now() - interval '7 days'
    returning 1
  )
  select count(*)::int from gone;
$$;

select cron.schedule('purge-deleted-accounts', '17 3 * * *',
  'select private.purge_deleted_accounts()');

-- ---------------------------------------------------------------------------
-- A leaving account is hidden: search, requests and invites
-- ---------------------------------------------------------------------------

create or replace function private.can_find(p_viewer uuid, p_target uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select not private.is_leaving(p_target) and case (private.settings_of(p_target)).search_visibility
    when 'everyone' then true
    when 'friendsOfFriends' then private.are_friends_of_friends(p_viewer, p_target)
    else false
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
  if p_user = me or not exists (select 1 from public.profiles where id = p_user)
      or private.is_leaving(p_user) then
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
    and p.deletion_requested_at is null
    and not private.is_blocked((select auth.uid()), p.id);
$$;

-- ---------------------------------------------------------------------------
-- My data
-- ---------------------------------------------------------------------------

-- Everything the app keeps about me, as one JSON document. Only my own
-- account: the function takes no user id.
create function public.export_my_data()
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  with me as (select private.require_user() as id)
  select jsonb_build_object(
    'exported_at', now(),
    'account', (
      select jsonb_build_object('id', u.id, 'email', u.email, 'created_at', u.created_at)
      from auth.users u, me where u.id = me.id),
    'profile', (
      select to_jsonb(p) - 'deletion_requested_at'
      from public.profiles p, me where p.id = me.id),
    'settings', (
      select to_jsonb(s) - 'user_id'
      from public.user_settings s, me where s.user_id = me.id),
    'friends', coalesce((
      select jsonb_agg(jsonb_build_object(
        'handle', p.handle, 'name', p.display_name,
        'status', f.status, 'since', coalesce(f.accepted_at, f.created_at)))
      from public.friendships f, me, public.profiles p
      where me.id in (f.user_a, f.user_b)
        and p.id = case when f.user_a = me.id then f.user_b else f.user_a end), '[]'),
    'achievements', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', ua.achievement_id, 'progress', ua.progress, 'unlocked_at', ua.unlocked_at))
      from public.user_achievements ua, me where ua.user_id = me.id), '[]'),
    'cosmetics', coalesce((
      select jsonb_agg(jsonb_build_object('id', uc.cosmetic_id, 'equipped', uc.equipped))
      from public.user_cosmetics uc, me where uc.user_id = me.id), '[]'),
    'messages_sent', coalesce((
      select jsonb_agg(jsonb_build_object(
        'to', p.handle, 'kind', m.kind, 'text', m.body,
        'opens_at', m.opens_at, 'sent_at', m.created_at) order by m.created_at)
      from public.messages m, me, public.profiles p
      where m.from_user = me.id and p.id = m.to_user), '[]'),
    'blocked', coalesce((
      select jsonb_agg(p.handle)
      from public.blocks b, me, public.profiles p
      where b.blocker = me.id and p.id = b.blocked), '[]'),
    'quiet_orbit', coalesce((
      select jsonb_agg(p.handle)
      from public.mutes mu, me, public.profiles p
      where mu.user_id = me.id and p.id = mu.muted), '[]'),
    'reports_filed', coalesce((
      select jsonb_agg(jsonb_build_object('reason', r.reason, 'details', r.details,
        'created_at', r.created_at))
      from public.reports r, me where r.reporter = me.id), '[]')
  );
$$;

-- ---------------------------------------------------------------------------
-- Privileges
-- ---------------------------------------------------------------------------

revoke execute on function
  private.is_leaving(uuid),
  private.recently_verified(),
  private.purge_deleted_accounts()
  from public, anon, authenticated;
revoke execute on function
  public.request_account_deletion(),
  public.cancel_account_deletion(),
  public.export_my_data()
  from public, anon;
grant execute on function
  public.request_account_deletion(),
  public.cancel_account_deletion(),
  public.export_my_data()
  to authenticated;
