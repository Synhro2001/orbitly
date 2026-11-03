-- Rate limits on search and friend requests: against spam requests and
-- against walking through handles one by one. Messages already have their
-- own limit (30 a minute, check_send_rate).
--   search:  120 a hour per user (the app waits for a pause in typing);
--   request:  30 a hour per user (direct and through invites).
-- Over the limit: errcode 54000, as for messages.

create table private.rate_events (
  user_id uuid not null,
  action text not null,
  created_at timestamptz not null default now()
);
create index rate_events_user_action_idx
  on private.rate_events (user_id, action, created_at);

-- Counts one more action, or refuses it if the limit for the window is
-- already reached.
create function private.take_rate(p_user uuid, p_action text, p_limit int, p_window interval)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  if (select count(*) from private.rate_events
      where user_id = p_user and action = p_action
        and created_at > now() - p_window) >= p_limit then
    raise exception 'Too many % actions', p_action using errcode = '54000';
  end if;
  insert into private.rate_events (user_id, action) values (p_user, p_action);
end;
$$;

-- Search writes a rate event, so it is no longer "stable".
create or replace function public.search_profiles(p_query text)
returns table (
  id uuid,
  handle text,
  display_name text,
  appearance jsonb
)
language plpgsql
volatile
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
  perform private.take_rate(me, 'search', 120, interval '1 hour');
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
  perform private.take_rate(me, 'request', 30, interval '1 hour');
  insert into public.friendships (user_a, user_b, status, requested_by)
  values (least(me, p_user), greatest(me, p_user), 'pending', me);
end;
$$;

-- Old events are not needed after the longest window.
select cron.schedule('purge-rate-events', '23 * * * *',
  $$delete from private.rate_events where created_at < now() - interval '1 day'$$);

revoke all on private.rate_events from public, anon, authenticated;
revoke execute on function private.take_rate(uuid, text, int, interval)
  from public, anon, authenticated;
