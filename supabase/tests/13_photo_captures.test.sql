-- Photo achievements, stage 1: record_capture, "First shot", privacy.
begin;
create extension if not exists pgtap with schema extensions;
select plan(11);

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

select tests.create_user('00000000-0000-0000-0000-00000000000a', 'alice');
select tests.create_user('00000000-0000-0000-0000-00000000000b', 'bob');
grant usage on schema tests to authenticated;
grant execute on all functions in schema tests to authenticated;

set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000a');

select is(
  (select progress from public.get_my_achievements() where id = 'first_shot'), 0,
  'before the first photo: "First shot" is at 0');

select lives_ok($$select public.record_capture()$$, 'a photo is recorded');

select isnt(
  (select unlocked_at from public.get_my_achievements() where id = 'first_shot'), null,
  'the first photo unlocks "First shot"');
select is(
  (select count(*)::int from public.user_cosmetics where cosmetic_id = 'moon_lens'), 1,
  'and grants the "Lens" moon');
select is(
  (select category from public.get_my_achievements() where id = 'first_shot'), 'photo',
  'it is in the "photo" category');

select lives_ok($$select public.record_capture()$$, 'a second photo is fine');
select is(
  (select count(*)::int from public.xp_events where reason = 'achievement' and ref = 'first_shot'), 1,
  'the reward is granted once');
select is(
  jsonb_array_length(public.export_my_data() -> 'photos_taken'), 2,
  'data export lists when the photos were taken');

select throws_ok(
  $$insert into public.photo_captures (user_id)
    values ('00000000-0000-0000-0000-00000000000a')$$,
  '42501', null, 'the app cannot write captures directly');

select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select count(*)::int from public.photo_captures), 0,
  'someone else''s captures are not visible');

select throws_ok(
  $$select public.record_capture() from generate_series(1, 61)$$,
  '54000', null, 'more than 60 photos an hour are refused');

select * from finish();
rollback;
