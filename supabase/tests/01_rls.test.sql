-- RLS and privileges: the client sees nothing of others and cannot grant
-- itself a reward.
begin;
create extension if not exists pgtap with schema extensions;
select plan(18);

-- Helpers (they live only inside this transaction).
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

select tests.create_user('00000000-0000-0000-0000-00000000000a', 'alice');
select tests.create_user('00000000-0000-0000-0000-00000000000b', 'bob');
select tests.create_user('00000000-0000-0000-0000-00000000000c', 'carol');

-- Alice and Bob are friends (the trigger gives both "First contact"); Carol
-- is a stranger.
insert into public.friendships (user_a, user_b, status, requested_by, accepted_at)
values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b',
  'accepted', '00000000-0000-0000-0000-00000000000a', now());

-- Sign in as Alice.
set local role authenticated;
select set_config('request.jwt.claims',
  '{"sub": "00000000-0000-0000-0000-00000000000a", "role": "authenticated"}', true);

select is(
  (select count(*)::int from public.user_achievements
    where user_id = '00000000-0000-0000-0000-00000000000b'),
  0, 'other users'' achievements are hidden');
select is(
  (select count(*)::int from public.user_cosmetics
    where user_id = '00000000-0000-0000-0000-00000000000b'),
  0, 'other users'' cosmetics are hidden');
select is(
  (select count(*)::int from public.user_achievements
    where user_id = '00000000-0000-0000-0000-00000000000a' and unlocked_at is not null),
  1, 'own achievements are visible');
select is(
  (select count(*)::int from public.profiles where id = '00000000-0000-0000-0000-00000000000b'),
  0, 'a friend''s profile is read only through server functions, which apply privacy settings');
select is(
  (select count(*)::int from public.profiles where id = '00000000-0000-0000-0000-00000000000c'),
  0, 'a stranger''s profile is hidden');

select throws_ok(
  $$insert into public.user_achievements (user_id, achievement_id, target, unlocked_at)
    values ('00000000-0000-0000-0000-00000000000a', 'year_of_friendship', 1, now())$$,
  '42501', null, 'cannot grant yourself an achievement');
select throws_ok(
  $$insert into public.user_cosmetics (user_id, cosmetic_id, kind)
    values ('00000000-0000-0000-0000-00000000000a', 'planet_solar_corona', 'planet_type')$$,
  '42501', null, 'cannot grant yourself a cosmetic');
select throws_ok(
  $$insert into public.pair_trophies (user_a, user_b, achievement_id)
    values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b', 'month_together')$$,
  '42501', null, 'cannot grant yourself a shared trophy');
select throws_ok(
  $$insert into public.xp_events (user_id, amount, reason)
    values ('00000000-0000-0000-0000-00000000000a', 100000, 'cheat')$$,
  '42501', null, 'cannot award yourself XP');
select throws_ok(
  $$insert into public.interactions (from_user, to_user, kind)
    values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b', 'capsule_sent')$$,
  '42501', null, 'cannot fake an interaction');
select throws_ok(
  $$update public.profiles set xp = 999999 where id = '00000000-0000-0000-0000-00000000000a'$$,
  '42501', null, 'cannot change your own XP');
select throws_ok(
  $$select * from public.achievements$$,
  '42501', null, 'the catalogue of conditions and secrets is closed');
select throws_ok(
  $$select private.evaluate_achievements('00000000-0000-0000-0000-00000000000a')$$,
  '42501', null, 'the engine cannot be called from the client');
select throws_ok(
  $$select public.equip_cosmetic('planet_solar_corona')$$,
  '42501', null, 'cannot wear what you do not own');

select lives_ok(
  $$update public.profiles set planet_name = 'New name'
    where id = '00000000-0000-0000-0000-00000000000a'$$,
  'you can rename your own planet');
update public.profiles set planet_name = 'Hacked'
  where id = '00000000-0000-0000-0000-00000000000b';

select is(
  (select title from public.get_my_achievements() where id = 'secret_01'),
  null, 'a locked secret has no title');

reset role;
select is(
  (select planet_name from public.profiles where id = '00000000-0000-0000-0000-00000000000b'),
  'Planet', 'another user''s profile did not change');

-- Without signing in (anon) the functions are not available.
set local role anon;
select throws_ok(
  $$select * from public.get_my_achievements()$$,
  '42501', null, 'the catalogue is unavailable without sign-in');
reset role;

select * from finish();
rollback;
