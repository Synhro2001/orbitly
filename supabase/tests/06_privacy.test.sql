-- Privacy settings really limit access: search, friend requests, invites,
-- mood.
--   alice — bob — carol   (friends in a chain: alice and carol are friends
--   dave                    of friends; dave is a stranger)
begin;
create extension if not exists pgtap with schema extensions;
select plan(17);

create schema tests;
create function tests.create_user(p_id uuid, p_handle text)
returns uuid language plpgsql as $$
begin
  insert into auth.users (instance_id, id, aud, role, email, raw_app_meta_data,
    raw_user_meta_data, created_at, updated_at)
  values ('00000000-0000-0000-0000-000000000000', p_id, 'authenticated',
    'authenticated', p_handle || '@test.local', '{}', '{}', now(), now());
  insert into public.profiles (id, handle, display_name, planet_name, appearance, mood)
  values (p_id, p_handle, p_handle, 'Planet', '{"type": "ocean", "seed": 1, "hue": 200}', 'calm');
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
grant usage on schema tests to authenticated;
grant execute on all functions in schema tests to authenticated;

select tests.create_user('00000000-0000-0000-0000-00000000000a', 'alice');
select tests.create_user('00000000-0000-0000-0000-00000000000b', 'bob');
select tests.create_user('00000000-0000-0000-0000-00000000000c', 'carol');
select tests.create_user('00000000-0000-0000-0000-00000000000d', 'dave');
select tests.befriend('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b');
select tests.befriend('00000000-0000-0000-0000-00000000000b', '00000000-0000-0000-0000-00000000000c');

set local role authenticated;

-- Search ----------------------------------------------------------------------

select tests.login('00000000-0000-0000-0000-00000000000c');
select is((select count(*)::int from public.search_profiles('alice')), 1,
  'search: a friend of a friend finds me by default');
select tests.login('00000000-0000-0000-0000-00000000000d');
select is((select count(*)::int from public.search_profiles('alice')), 0,
  'search: a stranger does not find me by default');

select tests.login('00000000-0000-0000-0000-00000000000a');
update public.user_settings set search_visibility = 'nobody';
select tests.login('00000000-0000-0000-0000-00000000000c');
select is((select count(*)::int from public.search_profiles('alice')), 0,
  'search: "nobody" hides me from friends of friends too');

select tests.login('00000000-0000-0000-0000-00000000000a');
update public.user_settings set search_visibility = 'everyone';
select tests.login('00000000-0000-0000-0000-00000000000d');
select is((select count(*)::int from public.search_profiles('alice')), 1,
  'search: "everyone" lets a stranger find me');

-- Requests --------------------------------------------------------------------

select throws_ok(
  $$select public.send_friend_request('00000000-0000-0000-0000-00000000000a')$$,
  '42501', null, 'requests: a stranger cannot send one by default');
select tests.login('00000000-0000-0000-0000-00000000000c');
select lives_ok(
  $$select public.send_friend_request('00000000-0000-0000-0000-00000000000a')$$,
  'requests: a friend of a friend can by default');

select tests.login('00000000-0000-0000-0000-00000000000a');
update public.user_settings set request_policy = 'everyone';
select tests.login('00000000-0000-0000-0000-00000000000d');
select lives_ok(
  $$select public.send_friend_request('00000000-0000-0000-0000-00000000000a')$$,
  'requests: "everyone" lets a stranger send one');
reset role;
delete from public.friendships where requested_by = '00000000-0000-0000-0000-00000000000d';
set local role authenticated;

-- Invites ---------------------------------------------------------------------

select tests.login('00000000-0000-0000-0000-00000000000a');
update public.user_settings set request_policy = 'inviteOnly';
select set_config('tests.code', public.get_my_invite_code(), true);
select is(public.get_my_invite_code(), current_setting('tests.code'),
  'invites: my code stays the same until I change it');

select tests.login('00000000-0000-0000-0000-00000000000d');
select throws_ok(
  $$select public.send_friend_request('00000000-0000-0000-0000-00000000000a')$$,
  '42501', null, 'requests: "invite only" stops a direct request');
select is(
  (select handle from public.get_invite(current_setting('tests.code'))), 'alice',
  'invites: the code shows who invites');
select lives_ok(
  format('select public.send_friend_request_by_invite(%L)', current_setting('tests.code')),
  'invites: my code lets its holder send a request anyway');
select is(
  (select status from public.friendships
    where user_a = '00000000-0000-0000-0000-00000000000a'
      and user_b = '00000000-0000-0000-0000-00000000000d'),
  'pending', 'invites: the request is waiting for me');

select tests.login('00000000-0000-0000-0000-00000000000a');
select public.rotate_invite_code();
select tests.login('00000000-0000-0000-0000-00000000000c');
select throws_ok(
  format('select public.send_friend_request_by_invite(%L)', current_setting('tests.code')),
  'P0002', null, 'invites: an old code stops working after a new one is made');

-- Mood ------------------------------------------------------------------------

select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select mood from public.get_my_friends() where handle = 'alice'), 'calm',
  'mood: friends see it by default');

select tests.login('00000000-0000-0000-0000-00000000000a');
update public.user_settings set mood_audience = 'nobody';
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select mood from public.get_my_friends() where handle = 'alice'), null,
  'mood: "nobody" hides it from friends');

select tests.login('00000000-0000-0000-0000-00000000000a');
update public.user_settings set mood_audience = 'closeOrbit';
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select mood from public.get_my_friends() where handle = 'alice'), null,
  'mood: "close orbit" hides it from a friend who is not close');

reset role;
update public.closeness set score = 80
where user_a = '00000000-0000-0000-0000-00000000000a'
  and user_b = '00000000-0000-0000-0000-00000000000b';
set local role authenticated;
select is(
  (select mood from public.get_my_friends() where handle = 'alice'), 'calm',
  'mood: "close orbit" shows it to a close friend');

select * from finish();
rollback;
