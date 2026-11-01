-- Движок достижений: каждое из 13 достижений открывается при своём условии и
-- не открывается без него; повторный пересчёт ничего не дублирует; общие
-- трофеи появляются у обоих.
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
  values (tests.uid(n), 'user' || n, 'User ' || n, 'Планета',
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

-- 1. Первый контакт ---------------------------------------------------------
select ok(not tests.unlocked(1, 'first_contact'), 'первый контакт: без друзей — нет');
select tests.befriend(1, 2);
select ok(tests.unlocked(1, 'first_contact'), 'первый контакт: открылся');
select ok(tests.unlocked(2, 'first_contact'), 'первый контакт: открылся и у друга');

-- 2. Неделя на орбите — через настоящий подсчёт серии триггером -------------
select tests.befriend(3, 4);
select tests.talk(3, 4, 'text', now() - make_interval(days => d))
  from generate_series(6, 1, -1) d;
select is(
  (select streak_days from public.closeness
    where user_a = tests.uid(3) and user_b = tests.uid(4)),
  6, 'серия считается по дням');
select ok(not tests.unlocked(3, 'week_on_orbit'), 'неделя на орбите: 6 дней — нет');
select tests.talk(3, 4, 'text');
select ok(tests.unlocked(3, 'week_on_orbit'), 'неделя на орбите: 7 дней — да');
select ok(tests.unlocked(4, 'week_on_orbit'), 'неделя на орбите: и у друга');

-- 3. Месяц вместе (pair), Сто дней, Год дружбы ------------------------------
select tests.befriend(5, 6);
select tests.set_pair(5, 6, 29);
select ok(not tests.unlocked(5, 'month_together'), 'месяц вместе: 29 дней — нет');
select tests.set_pair(5, 6, 30);
select ok(tests.unlocked(5, 'month_together'), 'месяц вместе: открылся');
select ok(tests.unlocked(6, 'month_together'), 'месяц вместе: и у друга (pair)');
select ok(tests.has_trophy(5, 6, 'month_together'), 'месяц вместе: общий трофей');
select ok(
  exists (select 1 from public.user_cosmetics
    where user_id = tests.uid(6) and cosmetic_id = 'moon_twin'),
  'месяц вместе: награда у обоих');

select tests.set_pair(5, 6, 99);
select ok(not tests.unlocked(5, 'hundred_days'), 'сто дней: 99 — нет');
select tests.set_pair(5, 6, 100);
select ok(tests.unlocked(5, 'hundred_days'), 'сто дней: да');
select tests.set_pair(5, 6, 364);
select ok(not tests.unlocked(5, 'year_of_friendship'), 'год дружбы: 364 — нет');
select tests.set_pair(5, 6, 365);
select ok(tests.unlocked(5, 'year_of_friendship'), 'год дружбы: да');

-- Сгоревшая серия не засчитывается, даже если число большое.
select tests.befriend(7, 8);
update public.closeness set streak_days = 400, last_exchange_at = now() - interval '5 days'
  where user_a = tests.uid(7) and user_b = tests.uid(8);
select private.evaluate_achievements(tests.uid(7));
select ok(not tests.unlocked(7, 'week_on_orbit'), 'сгоревшая серия не считается');

-- 4. Хранитель времени ------------------------------------------------------
select tests.befriend(9, 10);
select ok(not tests.unlocked(9, 'time_keeper'), 'хранитель времени: без капсулы — нет');
select tests.talk(9, 10, 'capsule_opened');
select ok(tests.unlocked(9, 'time_keeper'), 'хранитель времени: да');

-- 5. Созвездие (5 друзей) и Своя галактика (10 друзей) ----------------------
select tests.befriend(11, n) from generate_series(12, 15) n;
select ok(not tests.unlocked(11, 'constellation'), 'созвездие: 4 друга — нет');
select tests.befriend(11, 16);
select ok(tests.unlocked(11, 'constellation'), 'созвездие: 5 друзей — да');
select tests.befriend(11, n) from generate_series(17, 20) n;
select ok(not tests.unlocked(11, 'own_galaxy'), 'своя галактика: 9 друзей — нет');
select tests.befriend(11, 21);
select ok(tests.unlocked(11, 'own_galaxy'), 'своя галактика: 10 друзей — да');

-- 6. Возвращение: вернулся из тени, серия продолжилась ----------------------
select tests.befriend(22, 23);
update public.closeness set streak_days = 5, last_exchange_at = now() - interval '3 days'
  where user_a = tests.uid(22) and user_b = tests.uid(23);
update public.profiles
  set shadow_from = now() - interval '3 days' + interval '1 hour',
      shadow_until = now() - interval '1 hour'
  where id = tests.uid(22);
select tests.talk(22, 23, 'text');
select ok(tests.unlocked(22, 'comeback'), 'возвращение: да');
select is(
  (select streak_days from public.closeness
    where user_a = tests.uid(22) and user_b = tests.uid(23)),
  6, 'возвращение: серия продолжилась');

-- Без тени та же пауза сжигает серию — возвращения нет.
select tests.befriend(24, 25);
update public.closeness set streak_days = 5, last_exchange_at = now() - interval '3 days'
  where user_a = tests.uid(24) and user_b = tests.uid(25);
select tests.talk(24, 25, 'text');
select ok(not tests.unlocked(24, 'comeback'), 'возвращение: без тени — нет');

-- 7. Полярная ночь: три возвращения -----------------------------------------
select tests.befriend(26, 27);
select tests.talk(26, 27, 'shadow_return') from generate_series(1, 2);
select ok(not tests.unlocked(26, 'polar_night'), 'полярная ночь: 2 — нет');
select tests.talk(26, 27, 'shadow_return');
select ok(tests.unlocked(26, 'polar_night'), 'полярная ночь: 3 — да');

-- 8. Двойная звезда (pair): близость 90+ 30 дней ----------------------------
select tests.befriend(28, 29);
select tests.set_pair(28, 29, 1, 95, now() - interval '29 days');
select ok(not tests.unlocked(28, 'double_star'), 'двойная звезда: 29 дней — нет');
select tests.set_pair(28, 29, 1, 95, now() - interval '31 days');
select ok(tests.unlocked(28, 'double_star'), 'двойная звезда: да');
select ok(tests.unlocked(29, 'double_star'), 'двойная звезда: и у друга');
select ok(tests.has_trophy(28, 29, 'double_star'), 'двойная звезда: общий трофей');

-- 9. Синхрон (секрет, pair): снапы друг другу в одну минуту -----------------
select tests.befriend(30, 31);
select tests.talk(30, 31, 'snap', now() - interval '10 minutes');
select tests.talk(31, 30, 'snap', now() - interval '8 minutes');
select ok(not tests.unlocked(30, 'secret_01'), 'синхрон: 2 минуты разницы — нет');
select ok(
  not exists (select 1 from public.user_achievements
    where user_id = tests.uid(30) and achievement_id = 'secret_01'),
  'секрет: до открытия строки прогресса нет');
select tests.talk(30, 31, 'snap', now() - interval '60 seconds');
select tests.talk(31, 30, 'snap', now() - interval '30 seconds');
select ok(tests.unlocked(30, 'secret_01'), 'синхрон: да');
select ok(tests.unlocked(31, 'secret_01'), 'синхрон: и у друга');
select ok(tests.has_trophy(30, 31, 'secret_01'), 'синхрон: общий трофей');

-- 10. Горизонт событий (секрет): 10 капсул ----------------------------------
select tests.befriend(32, 33);
select tests.talk(32, 33, 'capsule_sent') from generate_series(1, 9);
select ok(not tests.unlocked(32, 'secret_02'), 'горизонт событий: 9 — нет');
select tests.talk(32, 33, 'capsule_sent');
select ok(tests.unlocked(32, 'secret_02'), 'горизонт событий: 10 — да');

-- 11. Идемпотентность -------------------------------------------------------
-- Сначала один полный пересчёт: не всех пользователей триггеры пересчитали
-- целиком. Затем ещё два — они не должны ничего менять.
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
  (select achievements from before_counts), 'повторный пересчёт: достижения не дублируются');
select is((select count(*) from public.user_cosmetics),
  (select cosmetics from before_counts), 'повторный пересчёт: косметика не дублируется');
select is((select count(*) from public.xp_events),
  (select xp_events from before_counts), 'повторный пересчёт: опыт не начисляется заново');
select is((select count(*) from public.pair_trophies),
  (select trophies from before_counts), 'повторный пересчёт: трофеи не дублируются');
select is((select sum(xp) from public.profiles),
  (select xp from before_counts), 'повторный пересчёт: сумма опыта та же');

-- Уровень считается из опыта.
select is(
  (select level from public.profiles where id = tests.uid(5)),
  (select floor(sqrt(xp / 50.0))::int + 1 from public.profiles where id = tests.uid(5)),
  'уровень = floor(sqrt(xp / 50)) + 1');

select * from finish();
rollback;
