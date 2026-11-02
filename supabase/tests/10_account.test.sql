-- Account deletion: needs a fresh code sign-in, hides the account at once,
-- can be cancelled within 7 days, leaves no personal data afterwards.
-- Data export: everything about me, nothing about others.
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
-- p_code_age: how long ago the session was confirmed with a code.
create function tests.login(p_id uuid, p_code_age interval default '1 day')
returns void language sql as $$
  select set_config('request.jwt.claims', json_build_object(
    'sub', p_id, 'role', 'authenticated',
    'amr', json_build_array(json_build_object(
      'method', 'otp',
      'timestamp', extract(epoch from now() - p_code_age)::bigint))
  )::text, true);
$$;
grant usage on schema tests to authenticated;
grant execute on all functions in schema tests to authenticated;

select tests.create_user('00000000-0000-0000-0000-00000000000a', 'alice');
select tests.create_user('00000000-0000-0000-0000-00000000000b', 'bob');
select tests.create_user('00000000-0000-0000-0000-00000000000c', 'carol');
insert into public.friendships (user_a, user_b, status, requested_by, accepted_at)
values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b',
  'accepted', '00000000-0000-0000-0000-00000000000a', now());
update public.friendships set message_retention = 'keep';
update public.user_settings set search_visibility = 'everyone';
-- Bob unlocked an achievement together with Alice.
update public.user_achievements set progress = 30, unlocked_at = now()
where user_id = '00000000-0000-0000-0000-00000000000b' and achievement_id = 'month_together';

set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000a');
select public.send_message('00000000-0000-0000-0000-00000000000b', 'bye');
select set_config('tests.code', public.get_my_invite_code(), true);

-- Export -------------------------------------------------------------------------

select is(
  public.export_my_data() #>> '{profile,handle}', 'alice',
  'export: my profile is in it');
select is(
  jsonb_array_length(public.export_my_data() -> 'messages_sent'), 1,
  'export: my messages are in it');
select is(
  public.export_my_data() #>> '{friends,0,handle}', 'bob',
  'export: my friends are in it');
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  jsonb_array_length(public.export_my_data() -> 'messages_sent'), 0,
  'export: someone else''s messages are not in mine');
select is(
  public.export_my_data() #>> '{account,email}', 'bob@test.local',
  'export: only my own account');

-- Request deletion -------------------------------------------------------------------

select tests.login('00000000-0000-0000-0000-00000000000a');
select throws_ok(
  $$select public.request_account_deletion()$$,
  '42501', null, 'delete: refused without a fresh code from email');
select tests.login('00000000-0000-0000-0000-00000000000a', '2 minutes');
select ok(
  public.request_account_deletion() between now() + interval '7 days' - interval '1 minute'
    and now() + interval '7 days' + interval '1 minute',
  'delete: accepted after a fresh code, final in 7 days');

select tests.login('00000000-0000-0000-0000-00000000000b');
select is((select count(*)::int from public.get_my_friends()), 0,
  'delete: friends no longer see the account');
select throws_ok(
  $$select * from public.send_message('00000000-0000-0000-0000-00000000000a', 'hello?')$$,
  '42501', null, 'delete: nobody can message the account');
select tests.login('00000000-0000-0000-0000-00000000000c');
select is((select count(*)::int from public.search_profiles('alice')), 0,
  'delete: search no longer finds it');
select is((select count(*)::int from public.get_invite(current_setting('tests.code'))), 0,
  'delete: its invite link no longer works');

-- Cancel -------------------------------------------------------------------------

select tests.login('00000000-0000-0000-0000-00000000000a');
select is(public.cancel_account_deletion(), true, 'cancel: signing in within 7 days cancels');
select is(public.cancel_account_deletion(), false, 'cancel: nothing to cancel twice');
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select message_retention from public.get_my_friends() where handle = 'alice'),
  'keep', 'cancel: the friendship is back, with its chat rule');

-- Final deletion -----------------------------------------------------------------

select tests.login('00000000-0000-0000-0000-00000000000a', '1 minute');
select public.request_account_deletion();
reset role;
update public.profiles set deletion_requested_at = now() - interval '8 days'
  where id = '00000000-0000-0000-0000-00000000000a';
select is(private.purge_deleted_accounts(), 1, 'purge: deletes after 7 days');
select is(
  (select count(*)::int from auth.users where id = '00000000-0000-0000-0000-00000000000a')
  + (select count(*)::int from public.profiles where id = '00000000-0000-0000-0000-00000000000a')
  + (select count(*)::int from public.user_settings where user_id = '00000000-0000-0000-0000-00000000000a')
  + (select count(*)::int from public.invites where user_id = '00000000-0000-0000-0000-00000000000a'),
  0, 'purge: no account, profile, settings or invite left');
select is(
  (select count(*)::int from public.messages
    where '00000000-0000-0000-0000-00000000000a' in (from_user, to_user))
  + (select count(*)::int from public.friendships
    where '00000000-0000-0000-0000-00000000000a' in (user_a, user_b)),
  0, 'purge: no messages or friendships left');
select is(
  (select count(*)::int from public.user_achievements
    where user_id = '00000000-0000-0000-0000-00000000000b' and achievement_id = 'month_together'),
  1, 'purge: the friend keeps the achievement they earned together');

select * from finish();
rollback;
