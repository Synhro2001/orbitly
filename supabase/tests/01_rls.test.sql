-- RLS и права: клиент не видит чужое и не может выдать себе награду.
begin;
create extension if not exists pgtap with schema extensions;
select plan(18);

-- Помощники (живут только внутри этой транзакции).
create schema tests;
create function tests.create_user(p_id uuid, p_handle text)
returns uuid language plpgsql as $$
begin
  insert into auth.users (instance_id, id, aud, role, email, raw_app_meta_data,
    raw_user_meta_data, created_at, updated_at)
  values ('00000000-0000-0000-0000-000000000000', p_id, 'authenticated',
    'authenticated', p_handle || '@test.local', '{}', '{}', now(), now());
  insert into public.profiles (id, handle, display_name, planet_name, appearance)
  values (p_id, p_handle, p_handle, 'Планета', '{"type": "ocean", "seed": 1, "hue": 200}');
  return p_id;
end;
$$;

select tests.create_user('00000000-0000-0000-0000-00000000000a', 'alice');
select tests.create_user('00000000-0000-0000-0000-00000000000b', 'bob');
select tests.create_user('00000000-0000-0000-0000-00000000000c', 'carol');

-- Алиса и Боб дружат (триггер выдаст обоим «Первый контакт»), Кэрол — чужая.
insert into public.friendships (user_a, user_b, status, requested_by, accepted_at)
values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b',
  'accepted', '00000000-0000-0000-0000-00000000000a', now());

-- Входим как Алиса.
set local role authenticated;
select set_config('request.jwt.claims',
  '{"sub": "00000000-0000-0000-0000-00000000000a", "role": "authenticated"}', true);

select is(
  (select count(*)::int from public.user_achievements
    where user_id = '00000000-0000-0000-0000-00000000000b'),
  0, 'чужие достижения не видны');
select is(
  (select count(*)::int from public.user_cosmetics
    where user_id = '00000000-0000-0000-0000-00000000000b'),
  0, 'чужая косметика не видна');
select is(
  (select count(*)::int from public.user_achievements
    where user_id = '00000000-0000-0000-0000-00000000000a' and unlocked_at is not null),
  1, 'свои достижения видны');
select is(
  (select count(*)::int from public.profiles where id = '00000000-0000-0000-0000-00000000000b'),
  1, 'профиль друга виден');
select is(
  (select count(*)::int from public.profiles where id = '00000000-0000-0000-0000-00000000000c'),
  0, 'профиль чужого не виден');

select throws_ok(
  $$insert into public.user_achievements (user_id, achievement_id, target, unlocked_at)
    values ('00000000-0000-0000-0000-00000000000a', 'year_of_friendship', 1, now())$$,
  '42501', null, 'нельзя выдать себе достижение');
select throws_ok(
  $$insert into public.user_cosmetics (user_id, cosmetic_id, kind)
    values ('00000000-0000-0000-0000-00000000000a', 'planet_solar_corona', 'planet_type')$$,
  '42501', null, 'нельзя выдать себе косметику');
select throws_ok(
  $$insert into public.pair_trophies (user_a, user_b, achievement_id)
    values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b', 'month_together')$$,
  '42501', null, 'нельзя выдать себе общий трофей');
select throws_ok(
  $$insert into public.xp_events (user_id, amount, reason)
    values ('00000000-0000-0000-0000-00000000000a', 100000, 'cheat')$$,
  '42501', null, 'нельзя начислить себе опыт');
select throws_ok(
  $$insert into public.interactions (from_user, to_user, kind)
    values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b', 'capsule_sent')$$,
  '42501', null, 'нельзя подделать событие общения');
select throws_ok(
  $$update public.profiles set xp = 999999 where id = '00000000-0000-0000-0000-00000000000a'$$,
  '42501', null, 'нельзя поменять себе опыт');
select throws_ok(
  $$select * from public.achievements$$,
  '42501', null, 'каталог условий и секретов закрыт');
select throws_ok(
  $$select private.evaluate_achievements('00000000-0000-0000-0000-00000000000a')$$,
  '42501', null, 'движок нельзя вызвать с клиента');
select throws_ok(
  $$select public.equip_cosmetic('planet_solar_corona')$$,
  '42501', null, 'нельзя надеть то, чего нет');

select lives_ok(
  $$update public.profiles set planet_name = 'Новое имя'
    where id = '00000000-0000-0000-0000-00000000000a'$$,
  'своё название планеты менять можно');
update public.profiles set planet_name = 'Взлом'
  where id = '00000000-0000-0000-0000-00000000000b';

select is(
  (select title from public.get_my_achievements() where id = 'secret_01'),
  null, 'секретное неоткрытое достижение без названия');

reset role;
select is(
  (select planet_name from public.profiles where id = '00000000-0000-0000-0000-00000000000b'),
  'Планета', 'чужой профиль не изменился');

-- Без входа (anon) функции недоступны.
set local role anon;
select throws_ok(
  $$select * from public.get_my_achievements()$$,
  '42501', null, 'без входа каталог недоступен');
reset role;

select * from finish();
rollback;
