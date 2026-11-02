-- Block hides two people from each other everywhere; quiet orbit mutes a
-- friend for me only; reports are filed but not readable.
--   alice — bob (friends, chatting); carol: stranger with search open
begin;
create extension if not exists pgtap with schema extensions;
select plan(18);

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
update public.user_settings set search_visibility = 'everyone', request_policy = 'everyone';

set local role authenticated;

-- Quiet orbit -----------------------------------------------------------------

select tests.login('00000000-0000-0000-0000-00000000000a');
select public.mute_friend('00000000-0000-0000-0000-00000000000b');
select is(
  (select muted from public.get_my_friends() where handle = 'bob'), true,
  'quiet orbit: the muted friend is marked for me');
select is(
  (select handle from public.get_muted()), 'bob',
  'quiet orbit: the list shows the muted friend');
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select muted from public.get_my_friends() where handle = 'alice'), false,
  'quiet orbit: the friend is not told');
select throws_ok(
  $$select public.mute_friend('00000000-0000-0000-0000-00000000000c')$$,
  '42501', null, 'quiet orbit: only friends can be muted');
select tests.login('00000000-0000-0000-0000-00000000000a');
select public.unmute_friend('00000000-0000-0000-0000-00000000000b');
select is((select count(*)::int from public.get_muted()), 0,
  'quiet orbit: unmuting removes the friend from the list');

-- Block -----------------------------------------------------------------------

select public.send_message('00000000-0000-0000-0000-00000000000b', 'hi');
select public.block_user('00000000-0000-0000-0000-00000000000b');

select is((select count(*)::int from public.get_my_friends()), 0,
  'block: the friendship ends');
select is((select handle from public.get_blocked()), 'bob',
  'block: the blocked list shows the person');
select is((select count(*)::int from public.search_profiles('bob')), 0,
  'block: I no longer find them');
select throws_ok(
  $$select * from public.get_thread('00000000-0000-0000-0000-00000000000b')$$,
  '42501', null, 'block: the chat is closed');

select tests.login('00000000-0000-0000-0000-00000000000b');
select is((select count(*)::int from public.get_my_friends()), 0,
  'block: the friendship is gone for them too');
select is((select count(*)::int from public.search_profiles('alice')), 0,
  'block: they no longer find me');
select is((select count(*)::int from public.get_chat_previews()), 0,
  'block: our chat is gone from their list');
select throws_ok(
  $$select * from public.send_message('00000000-0000-0000-0000-00000000000a', 'hey?')$$,
  '42501', null, 'block: they cannot message me');
select throws_ok(
  $$select public.send_friend_request('00000000-0000-0000-0000-00000000000a')$$,
  '42501', null, 'block: they cannot send a request');

select tests.login('00000000-0000-0000-0000-00000000000a');
select set_config('tests.code', public.get_my_invite_code(), true);
select tests.login('00000000-0000-0000-0000-00000000000b');
select throws_ok(
  format('select public.send_friend_request_by_invite(%L)', current_setting('tests.code')),
  '42501', null, 'block: not even my invite link gets through');

select tests.login('00000000-0000-0000-0000-00000000000a');
select public.unblock_user('00000000-0000-0000-0000-00000000000b');
select is((select count(*)::int from public.search_profiles('bob')), 1,
  'unblock: we can find each other again (no friendship back)');

-- Reports ---------------------------------------------------------------------

select lives_ok(
  $$select public.report_user('00000000-0000-0000-0000-00000000000c', 'spam', 'ads')$$,
  'report: can be filed with a reason');
select throws_ok(
  $$select * from public.reports$$,
  '42501', null, 'report: nobody reads reports through the API');

select * from finish();
rollback;
