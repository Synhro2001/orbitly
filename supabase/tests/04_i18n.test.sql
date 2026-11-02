-- Translated catalogue: every text has Russian and English, a row without
-- English is rejected, the client gets all languages, secrets stay hidden.
begin;
create extension if not exists pgtap with schema extensions;
select plan(7);

select is(
  (select count(*)::int from public.achievements
    where not (title ? 'ru' and title ? 'en' and description ? 'ru' and description ? 'en')),
  0, 'every achievement has Russian and English');
select is(
  (select count(*)::int from public.cosmetics where not (title ? 'ru' and title ? 'en')),
  0, 'every cosmetic has Russian and English');

select throws_ok(
  $$insert into public.cosmetics (id, title, kind, rarity)
    values ('test_moon', '{"ru": "Луна"}', 'moon', 'common')$$,
  '23514', null, 'a cosmetic without English is rejected');
select throws_ok(
  $$update public.achievements set description = '"plain text"' where id = 'comeback'$$,
  '23514', null, 'a plain string instead of translations is rejected');

insert into auth.users (instance_id, id, aud, role, email, raw_app_meta_data,
  raw_user_meta_data, created_at, updated_at)
values ('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-00000000000a',
  'authenticated', 'authenticated', 'alice@test.local', '{}', '{}', now(), now());
insert into public.profiles (id, handle, display_name, planet_name, appearance)
values ('00000000-0000-0000-0000-00000000000a', 'alice', 'alice', 'Planet',
  '{"type": "ocean", "seed": 1, "hue": 200}');
insert into public.user_achievements (user_id, achievement_id, progress, target, unlocked_at)
values ('00000000-0000-0000-0000-00000000000a', 'time_keeper', 1, 1, now());

select set_config('request.jwt.claims',
  '{"sub": "00000000-0000-0000-0000-00000000000a", "role": "authenticated"}', true);
set local role authenticated;

select is(
  (select title ->> 'en' from public.get_my_achievements() where id = 'time_keeper'),
  'Time keeper', 'the client gets the English title');
select is(
  (select reward_title ->> 'ru' from public.get_my_achievements() where id = 'time_keeper'),
  'Песочные часы', 'the reward title comes in every language');
select is(
  (select description from public.get_my_achievements() where id = 'secret_02'),
  null, 'a locked secret still has no description');

select * from finish();
rollback;
