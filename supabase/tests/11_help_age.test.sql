-- 18+: a planet is created only with the age confirmed. Feedback is filed,
-- limited, and not readable through the API.
begin;
create extension if not exists pgtap with schema extensions;
select plan(6);

insert into auth.users (instance_id, id, aud, role, email, raw_app_meta_data,
  raw_user_meta_data, created_at, updated_at)
values ('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-00000000000a',
  'authenticated', 'authenticated', 'alice@test.local', '{}', '{}', now(), now());

set local role authenticated;
select set_config('request.jwt.claims',
  '{"sub": "00000000-0000-0000-0000-00000000000a", "role": "authenticated"}', true);

select throws_ok(
  $$select public.complete_onboarding('Alice', 'Venus',
    '{"type": "ocean", "seed": 1, "hue": 200}', false)$$,
  '22023', null, '18+: no planet without confirming the age');
select lives_ok(
  $$select public.complete_onboarding('Alice', 'Venus',
    '{"type": "ocean", "seed": 1, "hue": 200}', true)$$,
  '18+: a planet with the age confirmed');
select isnt((select adult_confirmed_at from public.profiles), null,
  '18+: the time of confirmation is kept');

select lives_ok(
  $$select public.submit_feedback('The chat froze', '1.0.0+1', 'Pixel 8')$$,
  'feedback: filed with version and device');
select throws_ok(
  $$select * from public.feedback$$,
  '42501', null, 'feedback: not readable through the API');
select throws_ok(
  $$select public.submit_feedback('   ', '1.0.0+1', 'Pixel 8')$$,
  '23514', null, 'feedback: an empty message is rejected');

select * from finish();
rollback;
