-- Test data for local development (supabase db reset).
-- Three users sign in by email; the code arrives in Mailpit
-- (http://127.0.0.1:54324).
--
--   anya@orbitly.test   — something to see right away:
--                         "Time keeper" is unlocked but not shown yet, so
--                         the unlock animation plays on first sign-in;
--                         a 6-day streak with Misha, so one message opens
--                         "A week in orbit".
--   misha@orbitly.test
--   lera@orbitly.test

-- Supabase Auth users ---------------------------------------------------------

insert into auth.users (
  instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
  confirmation_token, recovery_token, email_change_token_new, email_change
)
select
  '00000000-0000-0000-0000-000000000000', u.id, 'authenticated', 'authenticated',
  u.email, '', now(),
  '{"provider": "email", "providers": ["email"]}', '{}', now(), now(),
  '', '', '', ''
from (values
  ('a0000000-0000-0000-0000-000000000001'::uuid, 'anya@orbitly.test'),
  ('a0000000-0000-0000-0000-000000000002'::uuid, 'misha@orbitly.test'),
  ('a0000000-0000-0000-0000-000000000003'::uuid, 'lera@orbitly.test')
) as u (id, email);

insert into auth.identities (
  id, user_id, provider_id, identity_data, provider, last_sign_in_at,
  created_at, updated_at
)
select gen_random_uuid(), u.id, u.id::text,
  jsonb_build_object('sub', u.id::text, 'email', u.email, 'email_verified', true),
  'email', now(), now(), now()
from auth.users u
where u.email like '%@orbitly.test';

-- Planets ---------------------------------------------------------------------

insert into public.profiles (id, handle, display_name, planet_name, appearance, mood)
values
  ('a0000000-0000-0000-0000-000000000001', 'anya.sky', 'Аня', 'Лазурия',
    '{"type": "ocean", "seed": 1001, "hue": 190}', 'happy'),
  ('a0000000-0000-0000-0000-000000000002', 'misha_m', 'Миша', 'Вулкания',
    '{"type": "lava", "seed": 1038, "hue": 12}', 'calm'),
  ('a0000000-0000-0000-0000-000000000003', 'lera.moon', 'Лера', 'Карамель',
    '{"type": "candy", "seed": 1075, "hue": 320}', 'inLove');

-- Friendships: all three are friends. The trigger grants "First contact" ------

insert into public.friendships (user_a, user_b, status, requested_by, created_at, accepted_at)
values
  ('a0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000002',
    'accepted', 'a0000000-0000-0000-0000-000000000001', now() - interval '20 days', now() - interval '20 days'),
  ('a0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000003',
    'accepted', 'a0000000-0000-0000-0000-000000000003', now() - interval '15 days', now() - interval '15 days'),
  ('a0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000003',
    'accepted', 'a0000000-0000-0000-0000-000000000002', now() - interval '10 days', now() - interval '10 days');

-- Interaction history (in chronological order: the trigger counts streaks) ---

-- Anya ↔ Misha: every day for the last 6 days, a 6-day streak.
insert into public.interactions (from_user, to_user, kind, created_at)
select
  case when d % 2 = 0 then 'a0000000-0000-0000-0000-000000000001'::uuid
       else 'a0000000-0000-0000-0000-000000000002'::uuid end,
  case when d % 2 = 0 then 'a0000000-0000-0000-0000-000000000002'::uuid
       else 'a0000000-0000-0000-0000-000000000001'::uuid end,
  case when d % 3 = 0 then 'snap' else 'text' end,
  now() - make_interval(days => d)
from generate_series(6, 1, -1) as d;

-- Misha ↔ Lera: lots of snaps, high closeness.
insert into public.interactions (from_user, to_user, kind, created_at)
select
  case when n % 2 = 0 then 'a0000000-0000-0000-0000-000000000002'::uuid
       else 'a0000000-0000-0000-0000-000000000003'::uuid end,
  case when n % 2 = 0 then 'a0000000-0000-0000-0000-000000000003'::uuid
       else 'a0000000-0000-0000-0000-000000000002'::uuid end,
  'snap',
  now() - make_interval(hours => 3 * n)
from generate_series(20, 1, -1) as n;

-- Anya ↔ Lera: a couple of messages and a time capsule Anya opened yesterday.
insert into public.interactions (from_user, to_user, kind, created_at) values
  ('a0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000001',
    'capsule_sent', now() - interval '30 days' + interval '1 day'),
  ('a0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000003',
    'text', now() - interval '2 days'),
  ('a0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000003',
    'capsule_opened', now() - interval '1 day');

-- Everything unlocked counts as "shown", except Anya's "Time keeper": she
-- sees its animation on first sign-in.
update public.user_achievements
  set seen_at = now()
  where unlocked_at is not null
    and not (user_id = 'a0000000-0000-0000-0000-000000000001'
             and achievement_id = 'time_keeper');

-- Anya already wears her first moon.
update public.user_cosmetics
  set equipped = true
  where user_id = 'a0000000-0000-0000-0000-000000000001'
    and cosmetic_id = 'moon_first';

-- Message texts. The messages table does not update closeness (the
-- interactions log above does), so this is only what the chat shows.
insert into public.messages (from_user, to_user, kind, body, opens_at, opened_at, created_at) values
  ('a0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000002',
    'text', 'Привет! Как прошёл экзамен?', null, null, now() - interval '2 days'),
  ('a0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000001',
    'text', 'Сдал! Отмечаем в субботу 🎉', null, null, now() - interval '1 day 23 hours'),
  ('a0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000001',
    'capsule', 'С днём рождения! Открой и улыбнись 🎂', now() + interval '3 days', null,
    now() - interval '1 day'),
  ('a0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000001',
    'snap', null, null, null, now() - interval '20 hours'),
  ('a0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000001',
    'capsule', 'Помнишь, как мы загадали это месяц назад?', now() - interval '1 day',
    now() - interval '1 day', now() - interval '29 days'),
  ('a0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000003',
    'text', 'Лера, это было лучшее послание 💜', null, null, now() - interval '20 hours');
