-- Disappearing messages. Each pair of friends has a rule:
--   afterSeen — a message is gone an hour after the friend has opened it;
--   day       — gone 24 hours after sending;
--   keep      — kept.
-- A new friendship takes the stricter of the two people's defaults
-- (user_settings.message_retention); either friend can change it later, and
-- the change applies to new messages. Capsules count from the day they open,
-- so they never vanish unread.
--
-- Expired messages are not served the moment they expire (get_thread,
-- get_chat_previews, get_my_friends) and are deleted by an hourly job.
-- Streaks and achievements are counted from interactions, not messages, so
-- deleting messages does not affect them.

alter table public.friendships
  add column message_retention text not null default 'day'
    check (message_retention in ('afterSeen', 'day', 'keep'));
-- Chats that already exist keep their history: the rule is for new chats.
update public.friendships set message_retention = 'keep';

alter table public.messages
  add column retention text not null default 'keep'
    check (retention in ('afterSeen', 'day', 'keep')),
  add column seen_at timestamptz,
  add column expires_at timestamptz;
create index messages_expires_idx on public.messages (expires_at)
  where expires_at is not null;

-- The stricter of two rules.
create function private.stricter_retention(a text, b text)
returns text
language sql
immutable
set search_path = ''
as $$
  select case
    when 'afterSeen' in (a, b) then 'afterSeen'
    when 'day' in (a, b) then 'day'
    else 'keep'
  end;
$$;

create function private.on_friendship_accepted()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.status = 'accepted' and (tg_op = 'INSERT' or old.status <> 'accepted') then
    new.message_retention := coalesce(private.stricter_retention(
      (private.settings_of(new.user_a)).message_retention,
      (private.settings_of(new.user_b)).message_retention
    ), 'day');
  end if;
  return new;
end;
$$;

create trigger friendships_retention
  before insert or update of status on public.friendships
  for each row execute function private.on_friendship_accepted();

-- A new message takes the pair's rule and, for "day", its deadline.
create function private.on_message_inserted()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  select f.message_retention into new.retention
    from public.friendships f
    where f.user_a = least(new.from_user, new.to_user)
      and f.user_b = greatest(new.from_user, new.to_user);
  new.retention := coalesce(new.retention, 'keep');
  if new.retention = 'day' then
    new.expires_at := coalesce(new.opens_at, new.created_at) + interval '24 hours';
  end if;
  return new;
end;
$$;

create trigger messages_retention
  before insert on public.messages
  for each row execute function private.on_message_inserted();

create function private.is_live(m public.messages)
returns boolean
language sql
stable
set search_path = ''
as $$
  select m.expires_at is null or m.expires_at > now();
$$;

-- ---------------------------------------------------------------------------
-- The chat: mark what I have seen, serve only live messages
-- ---------------------------------------------------------------------------

create or replace function public.get_thread(p_friend uuid, p_limit int default 200)
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

  -- Opening the chat is "seeing" the friend's messages. A capsule counts
  -- only once it has opened; a snap only when viewed (open_snap).
  update public.messages m
    set seen_at = now(),
        expires_at = case when m.retention = 'afterSeen'
          then now() + interval '1 hour' else m.expires_at end
    where m.from_user = p_friend and m.to_user = me
      and m.seen_at is null
      and m.kind <> 'snap'
      and (m.kind <> 'capsule' or m.opens_at <= now());

  return query
    select x.*
    from (
      select m as msg
      from public.messages m
      where ((m.from_user = me and m.to_user = p_friend)
          or (m.from_user = p_friend and m.to_user = me))
        and private.is_live(m)
      order by m.created_at desc
      limit least(greatest(p_limit, 1), 500)
    ) recent
    cross join lateral private.message_for(recent.msg, me) x
    order by x.sent_at;
end;
$$;

-- A viewed snap starts its "after seen" hour too.
create or replace function public.open_snap(p_message uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  update public.messages m
    set opened_at = now(),
        seen_at = now(),
        expires_at = case when m.retention = 'afterSeen'
          then now() + interval '1 hour' else m.expires_at end
    where m.id = p_message and m.to_user = me
      and m.kind = 'snap' and m.opened_at is null
      and private.is_live(m);
  if not found then
    raise exception 'Snap not found or already viewed' using errcode = 'P0002';
  end if;
end;
$$;

create or replace function public.get_chat_previews()
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
  with me as (select (select auth.uid()) as id),
  friends as (
    select case when f.user_a = me.id then f.user_b else f.user_a end as friend_id
    from public.friendships f, me
    where f.status = 'accepted' and me.id in (f.user_a, f.user_b)
  )
  select fr.friend_id, x.*
  from friends fr
  cross join me
  cross join lateral (
    select both_ways.msg
    from (
      (select m as msg from public.messages m
        where m.from_user = me.id and m.to_user = fr.friend_id
          and private.is_live(m)
        order by m.created_at desc limit 1)
      union all
      (select m as msg from public.messages m
        where m.from_user = fr.friend_id and m.to_user = me.id
          and private.is_live(m)
        order by m.created_at desc limit 1)
    ) both_ways
    order by (both_ways.msg).created_at desc
    limit 1
  ) last
  cross join lateral private.message_for(last.msg, me.id) x;
$$;

-- Either friend can change the rule; it applies to new messages.
create function public.set_chat_retention(p_friend uuid, p_retention text)
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
  update public.friendships
    set message_retention = p_retention
    where user_a = least(me, p_friend) and user_b = greatest(me, p_friend);
end;
$$;

-- ---------------------------------------------------------------------------
-- Friend list: the chat rule, and no glow for an expired snap
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
  muted boolean,
  message_retention text
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
        and private.is_live(m)
    ),
    exists (
      select 1 from public.mutes mu
      where mu.user_id = (select auth.uid()) and mu.muted = p.id
    ),
    f.message_retention
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
-- Hourly clean-up
-- ---------------------------------------------------------------------------

create function private.purge_expired_messages()
returns int
language sql
security definer
set search_path = ''
as $$
  with gone as (
    delete from public.messages where expires_at <= now() returning 1
  )
  select count(*)::int from gone;
$$;

select cron.schedule('purge-expired-messages', '7 * * * *',
  'select private.purge_expired_messages()');

-- ---------------------------------------------------------------------------
-- Privileges
-- ---------------------------------------------------------------------------

revoke execute on function
  private.stricter_retention(text, text),
  private.on_friendship_accepted(),
  private.on_message_inserted(),
  private.purge_expired_messages(),
  private.is_live(public.messages)
  from public, anon, authenticated;
revoke execute on function
  public.set_chat_retention(uuid, text), public.get_my_friends()
  from public, anon;
grant execute on function
  public.set_chat_retention(uuid, text), public.get_my_friends()
  to authenticated;
