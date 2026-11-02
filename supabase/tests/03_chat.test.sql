-- Чат: отправка, права, капсулы до и после срока, список чатов, снапы.
begin;
create extension if not exists pgtap with schema extensions;
select plan(25);

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
create function tests.login(p_id uuid)
returns void language sql as $$
  select set_config('request.jwt.claims',
    json_build_object('sub', p_id, 'role', 'authenticated')::text, true);
$$;
grant usage on schema tests to authenticated;
grant execute on all functions in schema tests to authenticated;

select tests.create_user('00000000-0000-0000-0000-00000000000a', 'alice');
select tests.create_user('00000000-0000-0000-0000-00000000000b', 'bob');
select tests.create_user('00000000-0000-0000-0000-00000000000c', 'carol');
insert into public.friendships (user_a, user_b, status, requested_by, accepted_at)
values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b',
  'accepted', '00000000-0000-0000-0000-00000000000a', now());

-- Две капсулы Боба для Алисы: одна уже открывается, другая — через неделю.
insert into public.messages (from_user, to_user, kind, body, opens_at, created_at) values
  ('00000000-0000-0000-0000-00000000000b', '00000000-0000-0000-0000-00000000000a',
    'capsule', 'старая тайна', now() - interval '1 hour', now() - interval '10 days'),
  ('00000000-0000-0000-0000-00000000000b', '00000000-0000-0000-0000-00000000000a',
    'capsule', 'будущая тайна', now() + interval '7 days', now() - interval '1 day');
-- Снап от Боба.
insert into public.messages (id, from_user, to_user, kind, created_at) values
  ('00000000-0000-0000-0000-0000000000f1', '00000000-0000-0000-0000-00000000000b',
    '00000000-0000-0000-0000-00000000000a', 'snap', now() - interval '2 hours');

set local role authenticated;
select tests.login('00000000-0000-0000-0000-00000000000a');

-- Прямого доступа к таблице нет: иначе текст капсулы читался бы до срока.
select throws_ok(
  $$select body from public.messages$$,
  '42501', null, 'таблицу messages напрямую не прочитать');
select throws_ok(
  $$insert into public.messages (from_user, to_user, kind, body)
    values ('00000000-0000-0000-0000-00000000000a', '00000000-0000-0000-0000-00000000000b', 'text', 'x')$$,
  '42501', null, 'в таблицу messages напрямую не написать');

-- Отправка.
select is(
  (select text from public.send_message('00000000-0000-0000-0000-00000000000b', '  Привет!  ')),
  'Привет!', 'сообщение отправлено, пробелы по краям убраны');
select is(
  (select is_mine from public.send_message('00000000-0000-0000-0000-00000000000b', 'ещё')),
  true, 'своё сообщение помечено как моё');
select is(
  (select count(*)::int from public.interactions
    where from_user = '00000000-0000-0000-0000-00000000000a' and kind = 'text'),
  2, 'каждое сообщение пишет событие в журнал (близость, серия, Realtime)');
select throws_ok(
  $$select * from public.send_message('00000000-0000-0000-0000-00000000000c', 'кто ты?')$$,
  '42501', null, 'чужому писать нельзя');
select throws_ok(
  $$select * from public.send_message('00000000-0000-0000-0000-00000000000b', '   ')$$,
  '22023', null, 'пустое сообщение не отправить');
select throws_ok(
  format($$select * from public.send_message('00000000-0000-0000-0000-00000000000b', %L)$$,
    repeat('а', 1001)),
  '22023', null, 'больше 1000 символов не отправить');

-- Капсулы.
select is(
  (select kind from public.send_capsule('00000000-0000-0000-0000-00000000000b',
    'через месяц', now() + interval '30 days')),
  'capsule', 'капсула отправлена');
select throws_ok(
  $$select * from public.send_capsule('00000000-0000-0000-0000-00000000000b', 'x', now() - interval '1 minute')$$,
  '22023', null, 'капсулу в прошлое не отправить');
select throws_ok(
  $$select * from public.send_capsule('00000000-0000-0000-0000-00000000000b', 'x', now() + interval '400 days')$$,
  '22023', null, 'капсулу дальше чем на год не отправить');

-- Переписка глазами Алисы.
select is(
  (select text from public.get_thread('00000000-0000-0000-0000-00000000000b')
    where opens_at > now() and not is_mine),
  null, 'текст будущей капсулы не уходит с сервера');
select is(
  (select text from public.get_thread('00000000-0000-0000-0000-00000000000b')
    where opens_at < now() and not is_mine),
  'старая тайна', 'капсула после срока читается');
select is(
  (select count(*)::int from public.interactions
    where from_user = '00000000-0000-0000-0000-00000000000a' and kind = 'capsule_opened'),
  1, 'открытие капсулы записано один раз, хоть переписку открыли дважды');
select is(
  (select array_agg(kind order by sent_at) from public.get_thread('00000000-0000-0000-0000-00000000000b')),
  array['capsule', 'capsule', 'snap', 'text', 'text', 'capsule'],
  'сообщения по порядку');
select is(
  (select count(*)::int from public.get_thread('00000000-0000-0000-0000-00000000000b', 2)),
  2, 'лимит отдаёт последние сообщения');
select throws_ok(
  $$select * from public.get_thread('00000000-0000-0000-0000-00000000000c')$$,
  '42501', null, 'чужую переписку не открыть');

-- Список чатов и непрочитанные снапы.
select is(
  (select kind from public.get_chat_previews()
    where friend_id = '00000000-0000-0000-0000-00000000000b'),
  'capsule', 'в списке чатов — последнее сообщение');
select is(
  (select has_unread_snaps from public.get_my_friends()
    where id = '00000000-0000-0000-0000-00000000000b'),
  true, 'непросмотренный снап подсвечен');
select lives_ok(
  $$select public.open_snap('00000000-0000-0000-0000-0000000000f1')$$,
  'снап открывается');
select is(
  (select has_unread_snaps from public.get_my_friends()
    where id = '00000000-0000-0000-0000-00000000000b'),
  false, 'после просмотра подсветка гаснет');
select throws_ok(
  $$select public.open_snap('00000000-0000-0000-0000-0000000000f1')$$,
  'P0002', null, 'снап смотрят один раз');

-- Боб видит свою будущую капсулу целиком, Кэрол не видит ничего.
select tests.login('00000000-0000-0000-0000-00000000000b');
select is(
  (select text from public.get_thread('00000000-0000-0000-0000-00000000000a')
    where opens_at > now() + interval '6 days' and is_mine),
  'будущая тайна', 'отправитель видит текст своей капсулы');
select tests.login('00000000-0000-0000-0000-00000000000c');
select is(
  (select count(*)::int from public.get_chat_previews()),
  0, 'посторонний не видит чужих чатов');

-- Лимит частоты: 30 сообщений в минуту.
select tests.login('00000000-0000-0000-0000-00000000000a');
select throws_ok(
  $$select count(*) from generate_series(1, 40) n,
    lateral public.send_message('00000000-0000-0000-0000-00000000000b', 'спам ' || n)$$,
  '54000', null, 'спам упирается в лимит частоты');

select * from finish();
rollback;
