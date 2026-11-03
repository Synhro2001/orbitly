-- Rate limits: search 120 a hour, friend requests 30 a hour, per user.
begin;
create extension if not exists pgtap with schema extensions;
select plan(5);

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
-- 31 people who accept requests from everyone.
select tests.create_user(
  ('00000000-0000-0000-0000-' || lpad(n::text, 12, '0'))::uuid, 'user' || n)
from generate_series(100, 130) n;
update public.user_settings set request_policy = 'everyone', search_visibility = 'everyone';

set local role authenticated;
select set_config('request.jwt.claims',
  '{"sub": "00000000-0000-0000-0000-00000000000a", "role": "authenticated"}', true);

select lives_ok(
  $$select count(*) from generate_series(1, 120) n,
    lateral public.search_profiles(left('user' || n, 4))$$,
  'search: 120 searches in an hour are fine');
select throws_ok(
  $$select * from public.search_profiles('user')$$,
  '54000', null, 'search: the 121st within the hour is refused');

select lives_ok(
  $$select public.send_friend_request(('00000000-0000-0000-0000-' || lpad(n::text, 12, '0'))::uuid)
    from generate_series(100, 129) n$$,
  'requests: 30 in an hour are fine');
select throws_ok(
  $$select public.send_friend_request('00000000-0000-0000-0000-000000000130')$$,
  '54000', null, 'requests: the 31st within the hour is refused');

reset role;
update private.rate_events set created_at = now() - interval '2 hours';
set local role authenticated;
select lives_ok(
  $$select public.send_friend_request('00000000-0000-0000-0000-000000000130')$$,
  'requests: allowed again an hour later');

select * from finish();
rollback;
