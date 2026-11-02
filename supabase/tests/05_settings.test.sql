-- user_settings: created with the profile, private defaults, only your own
-- row can be read or changed, values are checked.
begin;
create extension if not exists pgtap with schema extensions;
select plan(9);

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

select is(
  (select (search_visibility, request_policy, show_last_seen, galaxy_visible, message_retention)::text
    from public.user_settings where user_id = '00000000-0000-0000-0000-00000000000a'),
  '(friendsOfFriends,friendsOfFriends,f,f,day)',
  'a new profile gets the private defaults');

set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000a');

select is(
  (select count(*)::int from public.user_settings), 1,
  'only your own settings are visible');
select lives_ok(
  $$update public.user_settings set search_visibility = 'nobody'
    where user_id = '00000000-0000-0000-0000-00000000000a'$$,
  'you can change your own settings');
select is(
  (select search_visibility from public.user_settings), 'nobody',
  'the change is saved');

update public.user_settings set search_visibility = 'everyone'
  where user_id = '00000000-0000-0000-0000-00000000000b';
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select search_visibility from public.user_settings), 'friendsOfFriends',
  'someone else''s settings cannot be changed');

select throws_ok(
  $$update public.user_settings set search_visibility = 'aliens'$$,
  '23514', null, 'an unknown value is rejected');
select throws_ok(
  $$update public.user_settings set daily_limit_minutes = 7$$,
  '23514', null, 'a daily limit outside the choices is rejected');
select throws_ok(
  $$update public.user_settings set user_id = '00000000-0000-0000-0000-00000000000a'$$,
  '42501', null, 'the owner of a row cannot be changed');

set local role anon;
select throws_ok(
  $$select * from public.user_settings$$,
  '42501', null, 'without sign-in settings are closed');

select * from finish();
rollback;
