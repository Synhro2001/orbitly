-- Translated catalogue: achievement and cosmetic texts become
-- {"ru": "...", "en": "..."} objects. The server sends every language and
-- the app picks the one on screen, so switching language needs no reload.
-- English is the fallback and is required for every row; a new language is
-- one more key, with no schema change.

create function private.is_translated(t jsonb)
returns boolean
language sql
immutable
set search_path = ''
as $$
  -- coalesce: a missing key gives null, and a check constraint lets null pass.
  select coalesce(
    jsonb_typeof(t) = 'object'
      and jsonb_typeof(t -> 'en') = 'string'
      and length(t ->> 'en') > 0,
    false);
$$;

alter table public.cosmetics
  alter column title type jsonb using jsonb_build_object('ru', title);
alter table public.achievements
  alter column title type jsonb using jsonb_build_object('ru', title),
  alter column description type jsonb using jsonb_build_object('ru', description);

update public.cosmetics c
set title = c.title || jsonb_build_object('en', t.en)
from (values
  ('moon_first', 'First moon'),
  ('moon_hourglass', 'Hourglass'),
  ('moon_twin', 'Twin'),
  ('ring_belt', 'Asteroid belt'),
  ('glow_aurora', 'Aurora'),
  ('glow_double_star', 'Double star'),
  ('trail_comet', 'Comet trail'),
  ('planet_ring_world', 'Ring world'),
  ('planet_nebula', 'Nebula'),
  ('planet_aurora', 'Aurora'),
  ('planet_gemini', 'Gemini'),
  ('planet_black_hole', 'Black hole'),
  ('planet_solar_corona', 'Solar corona')
) as t(id, en)
where c.id = t.id;

update public.achievements a
set title = a.title || jsonb_build_object('en', t.title),
    description = a.description || jsonb_build_object('en', t.description)
from (values
  ('first_contact', 'First contact', 'Find your first friend in orbit'),
  ('week_on_orbit', 'A week in orbit', 'A 7-day streak with one friend'),
  ('time_keeper', 'Time keeper', 'Open your first time capsule'),
  ('month_together', 'A month together',
    'A 30-day streak with a friend: a shared moon for you both'),
  ('constellation', 'Constellation', 'Five friends in orbit'),
  ('own_galaxy', 'Your own galaxy', 'Ten friends in orbit'),
  ('comeback', 'Comeback', 'Come back from the shadow and keep your streak'),
  ('polar_night', 'Polar night',
    'Come back from the shadow three times without losing a streak'),
  ('double_star', 'Double star', 'Closeness 90+ with a friend for 30 days in a row'),
  ('hundred_days', 'A hundred days', 'A 100-day streak'),
  ('secret_01', 'In sync', 'You and a friend sent each other snaps in the same minute'),
  ('secret_02', 'Event horizon', 'Send ten time capsules'),
  ('year_of_friendship', 'A year of friendship', 'A 365-day streak')
) as t(id, title, description)
where a.id = t.id;

-- Added after the update, so a row without English fails the migration
-- instead of reaching users.
alter table public.cosmetics
  add constraint cosmetics_title_translated check (private.is_translated(title));
alter table public.achievements
  add constraint achievements_title_translated check (private.is_translated(title)),
  add constraint achievements_description_translated
    check (private.is_translated(description));

-- The return type changes (text → jsonb), so the function is recreated.
drop function public.get_my_achievements();
create function public.get_my_achievements()
returns table (
  id text,
  title jsonb,
  description jsonb,
  icon text,
  category text,
  rarity text,
  hidden boolean,
  pair boolean,
  progress int,
  target int,
  unlocked_at timestamptz,
  seen_at timestamptz,
  reward_cosmetic_id text,
  reward_title jsonb,
  sort int
)
language sql
stable
security definer
set search_path = ''
as $$
  select
    a.id,
    case when masked then null else a.title end,
    case when masked then null else a.description end,
    case when masked then null else a.icon end,
    a.category,
    a.rarity,
    a.hidden,
    a.pair,
    case when masked then null else coalesce(ua.progress, 0) end,
    case when masked then null else private.condition_target(a.condition) end,
    ua.unlocked_at,
    ua.seen_at,
    case when masked then null else c.id end,
    case when masked then null else c.title end,
    a.sort
  from public.achievements a
  left join public.user_achievements ua
    on ua.achievement_id = a.id and ua.user_id = (select auth.uid())
  left join public.cosmetics c on c.id = a.reward ->> 'cosmetic'
  cross join lateral (select a.hidden and ua.unlocked_at is null as masked) m
  order by a.sort;
$$;
revoke execute on function public.get_my_achievements() from public, anon;
grant execute on function public.get_my_achievements() to authenticated;
revoke execute on function private.is_translated(jsonb) from public, anon, authenticated;
