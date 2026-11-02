-- Chat: sending, privileges, capsules before and after opening, chat list,
-- snaps.
begin;
create extension if not exists pgtap with schema extensions;
select plan(25);

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
grant usage on schema tests to authenticated;
grant execute on all functions in schema tests to authenticated;

select tests.create_user('00000000-0000-0000-0000-00000000000a', 'alice');
select tests.create_user('00000000-0000-0000-0000-00000000000b', 'bob');
select tests.create_user('00000000-0000-0000-0000-00000000000c', 'carol');
insert into public.friendships (user_a, user_b, status, requested_by, accepted_at)
values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b',
  'accepted', '00000000-0000-0000-0000-00000000000a', now());

-- Two capsules from Bob to Alice: one opens already, the other in a week.
insert into public.messages (from_user, to_user, kind, body, opens_at, created_at) values
  ('00000000-0000-0000-0000-00000000000b', '00000000-0000-0000-0000-00000000000a',
    'capsule', 'old secret', now() - interval '1 hour', now() - interval '10 days'),
  ('00000000-0000-0000-0000-00000000000b', '00000000-0000-0000-0000-00000000000a',
    'capsule', 'future secret', now() + interval '7 days', now() - interval '1 day');
-- A snap from Bob.
insert into public.messages (id, from_user, to_user, kind, created_at) values
  ('00000000-0000-0000-0000-0000000000f1', '00000000-0000-0000-0000-00000000000b',
    '00000000-0000-0000-0000-00000000000a', 'snap', now() - interval '2 hours');

set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000a');

-- No direct table access: otherwise capsule text could be read early.
select throws_ok(
  $$select body from public.messages$$,
  '42501', null, 'the messages table cannot be read directly');
select throws_ok(
  $$insert into public.messages (from_user, to_user, kind, body)
    values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b', 'text', 'x')$$,
  '42501', null, 'the messages table cannot be written directly');

-- Sending.
select is(
  (select text from public.send_message('00000000-0000-0000-0000-00000000000b', '  Hi!  ')),
  'Hi!', 'message sent, surrounding spaces trimmed');
select is(
  (select is_mine from public.send_message('00000000-0000-0000-0000-00000000000b', 'one more')),
  true, 'own message is marked as mine');
select is(
  (select count(*)::int from public.interactions
    where from_user = '00000000-0000-0000-0000-00000000000a' and kind = 'text'),
  2, 'every message logs an event (closeness, streak, Realtime)');
select throws_ok(
  $$select * from public.send_message('00000000-0000-0000-0000-00000000000c', 'who are you?')$$,
  '42501', null, 'cannot message a stranger');
select throws_ok(
  $$select * from public.send_message('00000000-0000-0000-0000-00000000000b', '   ')$$,
  '22023', null, 'an empty message is rejected');
select throws_ok(
  format($$select * from public.send_message('00000000-0000-0000-0000-00000000000b', %L)$$,
    repeat('a', 1001)),
  '22023', null, 'more than 1000 characters is rejected');

-- Capsules.
select is(
  (select kind from public.send_capsule('00000000-0000-0000-0000-00000000000b',
    'in a month', now() + interval '30 days')),
  'capsule', 'capsule sent');
select throws_ok(
  $$select * from public.send_capsule('00000000-0000-0000-0000-00000000000b', 'x', now() - interval '1 minute')$$,
  '22023', null, 'a capsule into the past is rejected');
select throws_ok(
  $$select * from public.send_capsule('00000000-0000-0000-0000-00000000000b', 'x', now() + interval '400 days')$$,
  '22023', null, 'a capsule more than a year ahead is rejected');

-- The conversation as Alice sees it.
select is(
  (select text from public.get_thread('00000000-0000-0000-0000-00000000000b')
    where opens_at > now() and not is_mine),
  null, 'future capsule text does not leave the server');
select is(
  (select text from public.get_thread('00000000-0000-0000-0000-00000000000b')
    where opens_at < now() and not is_mine),
  'old secret', 'an opened capsule is readable');
select is(
  (select count(*)::int from public.interactions
    where from_user = '00000000-0000-0000-0000-00000000000a' and kind = 'capsule_opened'),
  1, 'capsule opening is logged once, though the chat was opened twice');
select is(
  (select array_agg(kind order by sent_at) from public.get_thread('00000000-0000-0000-0000-00000000000b')),
  array['capsule', 'capsule', 'snap', 'text', 'text', 'capsule'],
  'messages are in order');
select is(
  (select count(*)::int from public.get_thread('00000000-0000-0000-0000-00000000000b', 2)),
  2, 'the limit returns the latest messages');
select throws_ok(
  $$select * from public.get_thread('00000000-0000-0000-0000-00000000000c')$$,
  '42501', null, 'cannot open a stranger''s conversation');

-- Chat list and unread snaps.
select is(
  (select kind from public.get_chat_previews()
    where friend_id = '00000000-0000-0000-0000-00000000000b'),
  'capsule', 'the chat list shows the last message');
select is(
  (select has_unread_snaps from public.get_my_friends()
    where id = '00000000-0000-0000-0000-00000000000b'),
  true, 'an unseen snap glows');
select lives_ok(
  $$select public.open_snap('00000000-0000-0000-0000-0000000000f1')$$,
  'a snap opens');
select is(
  (select has_unread_snaps from public.get_my_friends()
    where id = '00000000-0000-0000-0000-00000000000b'),
  false, 'the glow goes out after viewing');
select throws_ok(
  $$select public.open_snap('00000000-0000-0000-0000-0000000000f1')$$,
  'P0002', null, 'a snap is viewed once');

-- Bob sees his future capsule in full; Carol sees nothing.
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select text from public.get_thread('00000000-0000-0000-0000-00000000000a')
    where opens_at > now() + interval '6 days' and is_mine),
  'future secret', 'the sender sees their capsule text');
select tests.login('00000000-0000-0000-0000-00000000000c');
select is(
  (select count(*)::int from public.get_chat_previews()),
  0, 'a stranger sees no chats');

-- Rate limit: 30 messages per minute.
select tests.login('00000000-0000-0000-0000-00000000000a');
select throws_ok(
  $$select count(*) from generate_series(1, 40) n,
    lateral public.send_message('00000000-0000-0000-0000-00000000000b', 'spam ' || n)$$,
  '54000', null, 'spam hits the rate limit');

select * from finish();
rollback;
