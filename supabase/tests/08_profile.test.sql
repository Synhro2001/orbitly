-- Handle changes: at most once in 30 days, the old handle reserved for 14
-- days, live check, names change directly within their limits.
begin;
create extension if not exists pgtap with schema extensions;
select plan(12);

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

set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000a');

select is(public.check_handle('Al'), 'invalid', 'check: too short is invalid');
select is(public.check_handle('bob'), 'taken', 'check: someone else''s handle is taken');
select is(public.check_handle('@alice'), 'mine', 'check: my own handle is mine');
select is(public.check_handle('alice.star'), 'ok', 'check: a free handle is ok');

select lives_ok($$select public.change_handle('alice.star')$$, 'change: works the first time');
select is((select handle from public.profiles), 'alice.star', 'change: the new handle is saved');
select throws_ok($$select public.change_handle('alice.moon')$$,
  '55000', null, 'change: not again within 30 days');

select tests.login('00000000-0000-0000-0000-00000000000b');
select is(public.check_handle('alice'), 'taken',
  'reserve: the old handle is not free for others for 14 days');
reset role;
update public.released_handles set released_at = now() - interval '15 days';
set local role authenticated;
select is(public.check_handle('alice'), 'ok',
  'reserve: after 14 days the old handle is free');

reset role;
update public.profiles set handle_changed_at = now() - interval '31 days'
  where id = '00000000-0000-0000-0000-00000000000a';
set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000a');
select lives_ok($$select public.change_handle('alice.moon')$$,
  'change: allowed again after 30 days');

select lives_ok(
  $$update public.profiles set display_name = 'Alice', planet_name = 'Venus'$$,
  'names: change freely');
select throws_ok(
  $$update public.profiles set planet_name = 'x'$$,
  '23514', null, 'names: limits still apply');

select * from finish();
rollback;
