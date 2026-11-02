-- Disappearing messages: the pair's rule, expiry after 24 hours or after
-- being seen, capsules safe until they open, clean-up, changing the rule.
begin;
create extension if not exists pgtap with schema extensions;
select plan(14);

create schema tests;
create function tests.create_user(p_id uuid, p_handle text)
returns uuid language plpgsql as $$
begin
  insert into auth.users (instance_id, id, aud, role, email, raw_app_meta_data,
    raw_user_meta_data, created_at, updated_at)
  values ('00000000-0000-0000-0000-000000000000', p_id, 'authenticated',
    'authenticated', p_handle || '@test.local', '{}', '{}', now(), now());
  insert into public.profiles (id, handle, display_name, planet_name, appearance)
  values (p_id, p_handle, p_handle, 'Planet', '{"type": "ocean", "seed": 1, "hue": 200}');
  return p_id;
end;
$$;
create function tests.login(p_id uuid)
returns void language sql as $$
  select set_config('request.jwt.claims',
    json_build_object('sub', p_id, 'role', 'authenticated')::text, true);
$$;
create function tests.befriend(a uuid, b uuid)
returns void language sql as $$
  insert into public.friendships (user_a, user_b, status, requested_by, accepted_at)
  values (least(a, b), greatest(a, b), 'accepted', a, now());
$$;
create function tests.say(p_from uuid, p_to uuid, p_body text, p_age interval)
returns void language sql as $$
  insert into public.messages (from_user, to_user, kind, body, created_at)
  values (p_from, p_to, 'text', p_body, now() - p_age);
$$;
grant usage on schema tests to authenticated;
grant execute on all functions in schema tests to authenticated;

select tests.create_user('00000000-0000-0000-0000-00000000000a', 'alice');
select tests.create_user('00000000-0000-0000-0000-00000000000b', 'bob');
select tests.create_user('00000000-0000-0000-0000-00000000000c', 'carol');

-- A new friendship takes the stricter default.
update public.user_settings set message_retention = 'keep'
  where user_id = '00000000-0000-0000-0000-00000000000a';
update public.user_settings set message_retention = 'afterSeen'
  where user_id = '00000000-0000-0000-0000-00000000000c';
select tests.befriend('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b');
select tests.befriend('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000c');
select is(
  (select message_retention from public.friendships
    where user_b = '00000000-0000-0000-0000-00000000000b'),
  'day', 'rule: keep + day (default) gives day');
select is(
  (select message_retention from public.friendships
    where user_b = '00000000-0000-0000-0000-00000000000c'),
  'afterSeen', 'rule: keep + after seen gives after seen');

-- Day: alice ↔ bob.
select tests.say('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b', 'old', '25 hours');
select tests.say('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b', 'new', '1 hour');
insert into public.messages (from_user, to_user, kind, body, opens_at, created_at)
values ('00000000-0000-0000-0000-00000000000b', '00000000-0000-0000-0000-00000000000a',
  'capsule', 'from the past', now() + interval '1 day', now() - interval '10 days');

set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select array_agg(text order by sent_at) from public.get_thread('00000000-0000-0000-0000-00000000000a')
    where kind = 'text'),
  array['new'], 'day: a message older than 24 hours is no longer served');
select is(
  (select kind from public.get_chat_previews()
    where friend_id = '00000000-0000-0000-0000-00000000000a'),
  'text', 'day: the chat list shows the newest live message');
select is(
  (select count(*)::int from public.get_thread('00000000-0000-0000-0000-00000000000a')
    where kind = 'capsule'),
  1, 'day: a capsule sent 10 days ago is still there until it opens');

-- After seen: alice ↔ carol.
reset role;
select tests.say('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000c', 'psst', '3 days');
select is(
  (select expires_at from public.messages where body = 'psst'), null,
  'after seen: no deadline before the friend opens the chat');

set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000a');
select count(*) from public.get_thread('00000000-0000-0000-0000-00000000000c');
reset role;
select is(
  (select seen_at from public.messages where body = 'psst'), null,
  'after seen: my own opening of the chat does not count');
set local role authenticated;

select tests.login('00000000-0000-0000-0000-00000000000c');
select is(
  (select text from public.get_thread('00000000-0000-0000-0000-00000000000a')),
  'psst', 'after seen: the friend sees it when opening the chat');
reset role;
select ok(
  (select expires_at between now() + interval '59 minutes' and now() + interval '61 minutes'
    from public.messages where body = 'psst'),
  'after seen: gone an hour after being seen');

-- Clean-up.
update public.messages set expires_at = now() - interval '1 minute' where body = 'psst';
select is(private.purge_expired_messages(), 2,
  'clean-up: deletes the expired messages (old + psst)');
select is((select count(*)::int from public.messages where body in ('old', 'psst')), 0,
  'clean-up: they are gone from the table');

-- Changing the rule.
set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000b');
select public.set_chat_retention('00000000-0000-0000-0000-00000000000a', 'keep');
select is(
  (select message_retention from public.get_my_friends() where handle = 'alice'),
  'keep', 'change: either friend can change the rule');
select public.send_message('00000000-0000-0000-0000-00000000000a', 'forever');
reset role;
select is(
  (select retention from public.messages where body = 'forever'),
  'keep', 'change: new messages follow the new rule');
set local role authenticated;

select tests.login('00000000-0000-0000-0000-00000000000c');
select throws_ok(
  $$select public.set_chat_retention('00000000-0000-0000-0000-00000000000b', 'keep')$$,
  '42501', null, 'change: only friends can change a chat''s rule');

select * from finish();
rollback;
