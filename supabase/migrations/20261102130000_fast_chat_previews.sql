-- The chat list used to walk through every message the user ever sent or
-- received to find the last one per friend: about 0.5 s with 200k messages.
-- Now it starts from the friend list and takes the newest message in each
-- direction straight from messages_pair_created_idx, so the cost depends on
-- the number of friends, not on the size of the history.
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
        order by m.created_at desc limit 1)
      union all
      (select m as msg from public.messages m
        where m.from_user = fr.friend_id and m.to_user = me.id
        order by m.created_at desc limit 1)
    ) both_ways
    order by (both_ways.msg).created_at desc
    limit 1
  ) last
  cross join lateral private.message_for(last.msg, me.id) x;
$$;
