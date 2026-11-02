-- Achievement engine: each of the 13 achievements unlocks with its condition
-- and stays locked without it; recomputing duplicates nothing; shared
-- trophies appear for both friends.
begin;
create extension if not exists pgtap with schema extensions;
select plan(45);

create schema tests;

create function tests.uid(n int) returns uuid language sql immutable as $$
  select ('00000000-0000-0000-0000-' || lpad(n::text, 12, '0'))::uuid;
$$;

create function tests.create_user(n int) returns uuid language plpgsql as $$
begin
  insert into auth.users (instance_id, id, aud, role, email, raw_app_meta_data,
    raw_user_meta_data, created_at, updated_at)
  values ('00000000-0000-0000-0000-000000000000', tests.uid(n), 'authenticated',
    'authenticated', 'user' || n || '@test.local', '{}', '{}', now(), now());
  insert into public.profiles (id, handle, display_name, planet_name, appearance)
  values (tests.uid(n), 'user' || n, 'User ' || n, 'Planet',
    '{"type": "ocean", "seed": 1, "hue": 200}');
  return tests.uid(n);
end;
$$;

create function tests.befriend(a int, b int) returns void language sql as $$
  insert into public.friendships (user_a, user_b, status, requested_by, accepted_at)
  values (least(tests.uid(a), tests.uid(b)), greatest(tests.uid(a), tests.uid(b)),
    'accepted', tests.uid(a), now());
$$;

create function tests.talk(a int, b int, k text, at timestamptz default now())
returns void language sql as $$
  insert into public.interactions (from_user, to_user, kind, created_at)
  values (tests.uid(a), tests.uid(b), k, at);
$$;

create function tests.unlocked(n int, achievement text) returns boolean
language sql as $$
  select exists (
    select 1 from public.user_achievements
    where user_id = tests.uid(n) and achievement_id = achievement
      and unlocked_at is not null);
$$;

create function tests.set_pair(a int, b int, streak int, score int default 50,
  high_since timestamptz default null) returns void language plpgsql as $$
begin
  update public.closeness
    set streak_days = streak, score = set_pair.score,
        high_since = set_pair.high_since,
        last_exchange_at = now() - interval '1 hour'
    where user_a = least(tests.uid(a), tests.uid(b))
      and user_b = greatest(tests.uid(a), tests.uid(b));
  perform private.evaluate_achievements(tests.uid(a));
end;
$$;

create function tests.has_trophy(a int, b int, achievement text) returns boolean
language sql as $$
  select exists (
    select 1 from public.pair_trophies
    where user_a = least(tests.uid(a), tests.uid(b))
      and user_b = greatest(tests.uid(a), tests.uid(b))
      and achievement_id = achievement);
$$;

select tests.create_user(n) from generate_series(1, 40) n;

-- 1. First contact ----------------------------------------------------------
select ok(not tests.unlocked(1, 'first_contact'), 'first contact: no friends, no');
select tests.befriend(1, 2);
select ok(tests.unlocked(1, 'first_contact'), 'first contact: unlocked');
select ok(tests.unlocked(2, 'first_contact'), 'first contact: unlocked for the friend too');

-- 2. A week in orbit, through real streak counting by the trigger -----------
select tests.befriend(3, 4);
select tests.talk(3, 4, 'text', now() - make_interval(days => d))
  from generate_series(6, 1, -1) d;
select is(
  (select streak_days from public.closeness
    where user_a = tests.uid(3) and user_b = tests.uid(4)),
  6, 'the streak counts days');
select ok(not tests.unlocked(3, 'week_on_orbit'), 'week in orbit: 6 days, no');
select tests.talk(3, 4, 'text');
select ok(tests.unlocked(3, 'week_on_orbit'), 'week in orbit: 7 days, yes');
select ok(tests.unlocked(4, 'week_on_orbit'), 'week in orbit: for the friend too');

-- 3. A month together (pair), A hundred days, A year of friendship ----------
select tests.befriend(5, 6);
select tests.set_pair(5, 6, 29);
select ok(not tests.unlocked(5, 'month_together'), 'month together: 29 days, no');
select tests.set_pair(5, 6, 30);
select ok(tests.unlocked(5, 'month_together'), 'month together: unlocked');
select ok(tests.unlocked(6, 'month_together'), 'month together: for the friend too (pair)');
select ok(tests.has_trophy(5, 6, 'month_together'), 'month together: shared trophy');
select ok(
  exists (select 1 from public.user_cosmetics
    where user_id = tests.uid(6) and cosmetic_id = 'moon_twin'),
  'month together: both get the reward');

select tests.set_pair(5, 6, 99);
select ok(not tests.unlocked(5, 'hundred_days'), 'hundred days: 99, no');
select tests.set_pair(5, 6, 100);
select ok(tests.unlocked(5, 'hundred_days'), 'hundred days: yes');
select tests.set_pair(5, 6, 364);
select ok(not tests.unlocked(5, 'year_of_friendship'), 'year of friendship: 364, no');
select tests.set_pair(5, 6, 365);
select ok(tests.unlocked(5, 'year_of_friendship'), 'year of friendship: yes');

-- A lost streak does not count, however large the number.
select tests.befriend(7, 8);
update public.closeness set streak_days = 400, last_exchange_at = now() - interval '5 days'
  where user_a = tests.uid(7) and user_b = tests.uid(8);
select private.evaluate_achievements(tests.uid(7));
select ok(not tests.unlocked(7, 'week_on_orbit'), 'a lost streak does not count');

-- 4. Time keeper ------------------------------------------------------------
select tests.befriend(9, 10);
select ok(not tests.unlocked(9, 'time_keeper'), 'time keeper: no capsule, no');
select tests.talk(9, 10, 'capsule_opened');
select ok(tests.unlocked(9, 'time_keeper'), 'time keeper: yes');

-- 5. Constellation (5 friends) and Own galaxy (10 friends) ------------------
select tests.befriend(11, n) from generate_series(12, 15) n;
select ok(not tests.unlocked(11, 'constellation'), 'constellation: 4 friends, no');
select tests.befriend(11, 16);
select ok(tests.unlocked(11, 'constellation'), 'constellation: 5 friends, yes');
select tests.befriend(11, n) from generate_series(17, 20) n;
select ok(not tests.unlocked(11, 'own_galaxy'), 'own galaxy: 9 friends, no');
select tests.befriend(11, 21);
select ok(tests.unlocked(11, 'own_galaxy'), 'own galaxy: 10 friends, yes');

-- 6. Comeback: returned from shadow and the streak went on ------------------
select tests.befriend(22, 23);
update public.closeness set streak_days = 5, last_exchange_at = now() - interval '3 days'
  where user_a = tests.uid(22) and user_b = tests.uid(23);
update public.profiles
  set shadow_from = now() - interval '3 days' + interval '1 hour',
      shadow_until = now() - interval '1 hour'
  where id = tests.uid(22);
select tests.talk(22, 23, 'text');
select ok(tests.unlocked(22, 'comeback'), 'comeback: yes');
select is(
  (select streak_days from public.closeness
    where user_a = tests.uid(22) and user_b = tests.uid(23)),
  6, 'comeback: the streak went on');

-- Without a shadow the same pause burns the streak, so no comeback.
select tests.befriend(24, 25);
update public.closeness set streak_days = 5, last_exchange_at = now() - interval '3 days'
  where user_a = tests.uid(24) and user_b = tests.uid(25);
select tests.talk(24, 25, 'text');
select ok(not tests.unlocked(24, 'comeback'), 'comeback: no shadow, no');

-- 7. Polar night: three comebacks -------------------------------------------
select tests.befriend(26, 27);
select tests.talk(26, 27, 'shadow_return') from generate_series(1, 2);
select ok(not tests.unlocked(26, 'polar_night'), 'polar night: 2, no');
select tests.talk(26, 27, 'shadow_return');
select ok(tests.unlocked(26, 'polar_night'), 'polar night: 3, yes');

-- 8. Double star (pair): closeness 90+ for 30 days --------------------------
select tests.befriend(28, 29);
select tests.set_pair(28, 29, 1, 95, now() - interval '29 days');
select ok(not tests.unlocked(28, 'double_star'), 'double star: 29 days, no');
select tests.set_pair(28, 29, 1, 95, now() - interval '31 days');
select ok(tests.unlocked(28, 'double_star'), 'double star: yes');
select ok(tests.unlocked(29, 'double_star'), 'double star: for the friend too');
select ok(tests.has_trophy(28, 29, 'double_star'), 'double star: shared trophy');

-- 9. Sync (secret, pair): snaps to each other within one minute -------------
select tests.befriend(30, 31);
select tests.talk(30, 31, 'snap', now() - interval '10 minutes');
select tests.talk(31, 30, 'snap', now() - interval '8 minutes');
select ok(not tests.unlocked(30, 'secret_01'), 'sync: 2 minutes apart, no');
select ok(
  not exists (select 1 from public.user_achievements
    where user_id = tests.uid(30) and achievement_id = 'secret_01'),
  'secret: no progress row before unlock');
select tests.talk(30, 31, 'snap', now() - interval '60 seconds');
select tests.talk(31, 30, 'snap', now() - interval '30 seconds');
select ok(tests.unlocked(30, 'secret_01'), 'sync: yes');
select ok(tests.unlocked(31, 'secret_01'), 'sync: for the friend too');
select ok(tests.has_trophy(30, 31, 'secret_01'), 'sync: shared trophy');

-- 10. Event horizon (secret): 10 capsules -----------------------------------
select tests.befriend(32, 33);
select tests.talk(32, 33, 'capsule_sent') from generate_series(1, 9);
select ok(not tests.unlocked(32, 'secret_02'), 'event horizon: 9, no');
select tests.talk(32, 33, 'capsule_sent');
select ok(tests.unlocked(32, 'secret_02'), 'event horizon: 10, yes');

-- 11. Idempotency -----------------------------------------------------------
-- First one full recompute: the triggers did not recompute every user in
-- full. Then two more, which must change nothing.
select private.evaluate_achievements(tests.uid(n)) from generate_series(1, 40) n;
create temp table before_counts as
select
  (select count(*) from public.user_achievements where unlocked_at is not null) as achievements,
  (select count(*) from public.user_cosmetics) as cosmetics,
  (select count(*) from public.xp_events) as xp_events,
  (select count(*) from public.pair_trophies) as trophies,
  (select sum(xp) from public.profiles) as xp;

select private.evaluate_achievements(tests.uid(n)) from generate_series(1, 40) n;
select private.evaluate_achievements(tests.uid(n)) from generate_series(1, 40) n;

select is(
  (select count(*) from public.user_achievements where unlocked_at is not null),
  (select achievements from before_counts), 'recompute: achievements are not duplicated');
select is((select count(*) from public.user_cosmetics),
  (select cosmetics from before_counts), 'recompute: cosmetics are not duplicated');
select is((select count(*) from public.xp_events),
  (select xp_events from before_counts), 'recompute: XP is not awarded again');
select is((select count(*) from public.pair_trophies),
  (select trophies from before_counts), 'recompute: trophies are not duplicated');
select is((select sum(xp) from public.profiles),
  (select xp from before_counts), 'recompute: total XP is unchanged');

-- The level is derived from XP.
select is(
  (select level from public.profiles where id = tests.uid(5)),
  (select floor(sqrt(xp / 50.0))::int + 1 from public.profiles where id = tests.uid(5)),
  'level = floor(sqrt(xp / 50)) + 1');

select * from finish();
rollback;
