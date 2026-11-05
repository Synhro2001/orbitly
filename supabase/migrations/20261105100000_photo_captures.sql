-- Photo achievements, stage 1: the in-app camera and "First shot".
-- See docs/feature-photo-achievements.md.
--
-- The photo itself never leaves the phone yet: the server only learns that
-- a picture was taken with the app's camera. Stage 2 adds the upload, the
-- check by a vision model and the subject of the photo.

-- ---------------------------------------------------------------------------
-- Captures
-- ---------------------------------------------------------------------------

create table public.photo_captures (
  id bigint generated always as identity primary key,
  user_id uuid not null references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now()
);
create index photo_captures_user_idx on public.photo_captures (user_id, created_at);

alter table public.photo_captures enable row level security;
revoke all on public.photo_captures from anon, authenticated;
grant select on public.photo_captures to authenticated;

-- Only the server writes captures (record_capture below).
create policy "Photo captures: only your own"
  on public.photo_captures for select to authenticated
  using (user_id = (select auth.uid()));

-- The camera took a picture. Counts it and unlocks what it earned. At most
-- 60 an hour: more than that is a script, not a person.
create function public.record_capture()
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  perform private.take_rate(me, 'capture', 60, interval '1 hour');
  insert into public.photo_captures (user_id) values (me);
  perform private.evaluate_achievements(me);
end;
$$;

-- ---------------------------------------------------------------------------
-- New condition: {"type": "photo_count", "count": N}
-- ---------------------------------------------------------------------------

create or replace function private.condition_target(p_condition jsonb)
returns int
language sql
immutable
set search_path = ''
as $$
  select case p_condition ->> 'type'
    when 'friends_count' then (p_condition ->> 'count')::int
    when 'streak_days' then (p_condition ->> 'days')::int
    when 'closeness_days' then (p_condition ->> 'days')::int
    when 'event_count' then (p_condition ->> 'count')::int
    when 'photo_count' then (p_condition ->> 'count')::int
    else 1
  end;
$$;

create or replace function private.condition_progress(
  p_condition jsonb,
  p_user uuid,
  p_friend uuid
)
returns int
language plpgsql
stable
set search_path = ''
as $$
declare
  result int;
begin
  case p_condition ->> 'type'
    when 'friends_count' then
      select count(*) into result
      from public.friendships f
      where f.status = 'accepted' and p_user in (f.user_a, f.user_b);

    when 'streak_days' then
      -- A lost streak does not count, even if the nightly job has not reset
      -- it yet.
      select coalesce(max(c.streak_days), 0) into result
      from public.closeness c
      where p_user in (c.user_a, c.user_b)
        and (p_friend is null or p_friend in (c.user_a, c.user_b))
        and private.streak_status(
          c.streak_days, c.last_exchange_at, c.user_a, c.user_b, now()
        ) <> 'burnt';

    when 'closeness_days' then
      select coalesce(max(floor(extract(epoch from now() - c.high_since) / 86400)), 0)
        into result
      from public.closeness c
      where p_user in (c.user_a, c.user_b)
        and (p_friend is null or p_friend in (c.user_a, c.user_b))
        and c.score >= (p_condition ->> 'score')::int
        and c.high_since is not null;

    when 'event_count' then
      select count(*) into result
      from public.interactions i
      where i.from_user = p_user
        and i.kind = p_condition ->> 'event'
        and (p_friend is null or i.to_user = p_friend);

    when 'photo_count' then
      select count(*) into result
      from public.photo_captures pc
      where pc.user_id = p_user;

    when 'special' then
      if p_condition ->> 'kind' = 'sync_snap' then
        select case when exists (
          select 1
          from public.interactions x
          join public.interactions y
            on y.from_user = x.to_user
           and y.to_user = x.from_user
           and y.kind = 'snap'
           and abs(extract(epoch from y.created_at - x.created_at))
               <= (p_condition ->> 'window_seconds')::int
          where x.from_user = p_user
            and x.kind = 'snap'
            and (p_friend is null or x.to_user = p_friend)
        ) then 1 else 0 end into result;
      end if;

    else
      result := 0;
  end case;
  return coalesce(result, 0);
end;
$$;

-- ---------------------------------------------------------------------------
-- Content: the "photo" category, "First shot" and the "Lens" moon
-- ---------------------------------------------------------------------------

alter table public.achievements drop constraint achievements_category_check;
alter table public.achievements add constraint achievements_category_check
  check (category in ('friendship', 'streak', 'closeness', 'collection', 'secret', 'photo'));

insert into public.cosmetics (id, title, kind, rarity, params) values
  ('moon_lens', '{"ru": "Объектив", "en": "Lens"}', 'moon', 'common',
    '{"moons": 1, "skin": "lens"}');

insert into public.achievements
  (id, title, description, icon, category, rarity, condition, reward, hidden, pair, sort)
values
  ('first_shot',
    '{"ru": "Первый кадр", "en": "First shot"}',
    '{"ru": "Сделай первое фото камерой Orbitly", "en": "Take your first photo with the Orbitly camera"}',
    '📷', 'photo', 'common', '{"type": "photo_count", "count": 1}',
    '{"cosmetic": "moon_lens"}', false, false, 140);

-- ---------------------------------------------------------------------------
-- Data export: when photos were taken (there is nothing else to export)
-- ---------------------------------------------------------------------------

create or replace function public.export_my_data()
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  with me as (select private.require_user() as id)
  select jsonb_build_object(
    'exported_at', now(),
    'account', (
      select jsonb_build_object('id', u.id, 'email', u.email, 'created_at', u.created_at)
      from auth.users u, me where u.id = me.id),
    'profile', (
      select to_jsonb(p) - 'deletion_requested_at'
      from public.profiles p, me where p.id = me.id),
    'settings', (
      select to_jsonb(s) - 'user_id'
      from public.user_settings s, me where s.user_id = me.id),
    'friends', coalesce((
      select jsonb_agg(jsonb_build_object(
        'handle', p.handle, 'name', p.display_name,
        'status', f.status, 'since', coalesce(f.accepted_at, f.created_at)))
      from public.friendships f, me, public.profiles p
      where me.id in (f.user_a, f.user_b)
        and p.id = case when f.user_a = me.id then f.user_b else f.user_a end), '[]'),
    'achievements', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', ua.achievement_id, 'progress', ua.progress, 'unlocked_at', ua.unlocked_at))
      from public.user_achievements ua, me where ua.user_id = me.id), '[]'),
    'cosmetics', coalesce((
      select jsonb_agg(jsonb_build_object('id', uc.cosmetic_id, 'equipped', uc.equipped))
      from public.user_cosmetics uc, me where uc.user_id = me.id), '[]'),
    'messages_sent', coalesce((
      select jsonb_agg(jsonb_build_object(
        'to', p.handle, 'kind', m.kind, 'text', m.body,
        'opens_at', m.opens_at, 'sent_at', m.created_at) order by m.created_at)
      from public.messages m, me, public.profiles p
      where m.from_user = me.id and p.id = m.to_user), '[]'),
    'blocked', coalesce((
      select jsonb_agg(p.handle)
      from public.blocks b, me, public.profiles p
      where b.blocker = me.id and p.id = b.blocked), '[]'),
    'quiet_orbit', coalesce((
      select jsonb_agg(p.handle)
      from public.mutes mu, me, public.profiles p
      where mu.user_id = me.id and p.id = mu.muted), '[]'),
    'reports_filed', coalesce((
      select jsonb_agg(jsonb_build_object('reason', r.reason, 'details', r.details,
        'created_at', r.created_at))
      from public.reports r, me where r.reporter = me.id), '[]'),
    'photos_taken', coalesce((
      select jsonb_agg(pc.created_at order by pc.created_at)
      from public.photo_captures pc, me where pc.user_id = me.id), '[]')
  );
$$;

-- ---------------------------------------------------------------------------
-- Privileges
-- ---------------------------------------------------------------------------

revoke execute on function public.record_capture() from public, anon;
grant execute on function public.record_capture() to authenticated;
