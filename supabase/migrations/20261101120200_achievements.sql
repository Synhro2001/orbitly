-- Achievements and rewards: "the planet grows with the friendship".
--
-- The achievement and cosmetics catalogues are content in the database, not
-- in the app. Only the server grants progress and rewards: the idempotent
-- evaluate_achievements function, called by triggers and a nightly pg_cron
-- job. The client reads the result and can only mark things as seen and
-- wear unlocked cosmetics.

-- ---------------------------------------------------------------------------
-- Catalogues
-- ---------------------------------------------------------------------------

create table public.cosmetics (
  id text primary key,
  title text not null,
  kind text not null
    check (kind in ('planet_type', 'moon', 'ring', 'glow', 'comet_trail')),
  rarity text not null check (rarity in ('common', 'rare', 'epic', 'legendary')),
  params jsonb not null default '{}'
);

create table public.achievements (
  id text primary key,
  title text not null,
  description text not null,
  icon text not null,
  category text not null
    check (category in ('friendship', 'streak', 'closeness', 'collection', 'secret')),
  rarity text not null check (rarity in ('common', 'rare', 'epic', 'legendary')),
  condition jsonb not null,
  reward jsonb not null,
  hidden boolean not null default false,
  pair boolean not null default false,
  sort int not null default 0,
  check (reward ? 'cosmetic')
);

-- ---------------------------------------------------------------------------
-- User state
-- ---------------------------------------------------------------------------

create table public.user_achievements (
  user_id uuid not null references public.profiles (id) on delete cascade,
  achievement_id text not null references public.achievements (id) on delete cascade,
  progress int not null default 0,
  target int not null,
  unlocked_at timestamptz,
  seen_at timestamptz,
  primary key (user_id, achievement_id),
  check (seen_at is null or unlocked_at is not null)
);

create table public.pair_trophies (
  user_a uuid not null references public.profiles (id) on delete cascade,
  user_b uuid not null references public.profiles (id) on delete cascade,
  achievement_id text not null references public.achievements (id) on delete cascade,
  earned_at timestamptz not null default now(),
  primary key (user_a, user_b, achievement_id),
  check (user_a < user_b)
);
create index pair_trophies_user_b_idx on public.pair_trophies (user_b);

create table public.user_cosmetics (
  user_id uuid not null references public.profiles (id) on delete cascade,
  cosmetic_id text not null references public.cosmetics (id) on delete cascade,
  -- Copy of cosmetics.kind, needed for the "one worn item per kind" rule.
  kind text not null,
  owned_at timestamptz not null default now(),
  equipped boolean not null default false,
  primary key (user_id, cosmetic_id)
);
create unique index user_cosmetics_one_equipped_per_kind
  on public.user_cosmetics (user_id, kind) where equipped;

create table public.xp_events (
  id bigint generated always as identity primary key,
  user_id uuid not null references public.profiles (id) on delete cascade,
  amount int not null check (amount > 0),
  reason text not null,
  ref text,
  created_at timestamptz not null default now()
);
create index xp_events_user_idx on public.xp_events (user_id, created_at);

-- ---------------------------------------------------------------------------
-- Content: cosmetics and achievements
-- ---------------------------------------------------------------------------

insert into public.cosmetics (id, title, kind, rarity, params) values
  ('moon_first',          'Первый спутник',     'moon',        'common',    '{"moons": 1}'),
  ('moon_hourglass',      'Песочные часы',      'moon',        'common',    '{"moons": 1, "skin": "hourglass"}'),
  ('moon_twin',           'Двойник',            'moon',        'rare',      '{"moons": 2}'),
  ('ring_belt',           'Пояс астероидов',    'ring',        'common',    '{}'),
  ('glow_aurora',         'Аврора',             'glow',        'rare',      '{"style": "aurora"}'),
  ('glow_double_star',    'Двойная звезда',     'glow',        'epic',      '{"style": "doubleStar"}'),
  ('trail_comet',         'След кометы',        'comet_trail', 'epic',      '{}'),
  ('planet_ring_world',   'Кольцевой мир',      'planet_type', 'rare',      '{"type": "ringWorld"}'),
  ('planet_nebula',       'Туманность',         'planet_type', 'rare',      '{"type": "nebula"}'),
  ('planet_aurora',       'Аврора',             'planet_type', 'rare',      '{"type": "aurora"}'),
  ('planet_gemini',       'Близнецы',           'planet_type', 'epic',      '{"type": "gemini"}'),
  ('planet_black_hole',   'Чёрная дыра',        'planet_type', 'epic',      '{"type": "blackHole"}'),
  ('planet_solar_corona', 'Солнечная корона',   'planet_type', 'legendary', '{"type": "solarCorona"}');

-- Secret achievements have neutral ids: the client sees the id, and it must
-- not give the secret away.
insert into public.achievements
  (id, title, description, icon, category, rarity, condition, reward, hidden, pair, sort)
values
  ('first_contact', 'Первый контакт', 'Найди первого друга на орбите', '🛰️',
    'friendship', 'common', '{"type": "friends_count", "count": 1}',
    '{"cosmetic": "moon_first"}', false, false, 10),
  ('week_on_orbit', 'Неделя на орбите', 'Серия 7 дней с одним другом', '🔥',
    'streak', 'common', '{"type": "streak_days", "days": 7}',
    '{"cosmetic": "ring_belt"}', false, false, 20),
  ('time_keeper', 'Хранитель времени', 'Открой первую капсулу времени', '⏳',
    'collection', 'common', '{"type": "event_count", "event": "capsule_opened", "count": 1}',
    '{"cosmetic": "moon_hourglass"}', false, false, 30),
  ('month_together', 'Месяц вместе', 'Серия 30 дней с другом — общий спутник вам обоим', '🌗',
    'streak', 'rare', '{"type": "streak_days", "days": 30}',
    '{"cosmetic": "moon_twin"}', false, true, 40),
  ('constellation', 'Созвездие', 'Пять друзей на орбите', '✨',
    'friendship', 'rare', '{"type": "friends_count", "count": 5}',
    '{"cosmetic": "planet_ring_world"}', false, false, 50),
  ('own_galaxy', 'Своя галактика', 'Десять друзей на орбите', '🌌',
    'friendship', 'rare', '{"type": "friends_count", "count": 10}',
    '{"cosmetic": "planet_nebula"}', false, false, 60),
  ('comeback', 'Возвращение', 'Вернись из тени и продолжи серию', '🌘',
    'streak', 'rare', '{"type": "event_count", "event": "shadow_return", "count": 1}',
    '{"cosmetic": "glow_aurora"}', false, false, 70),
  ('polar_night', 'Полярная ночь', 'Три раза вернись из тени, не потеряв серию', '🌠',
    'collection', 'rare', '{"type": "event_count", "event": "shadow_return", "count": 3}',
    '{"cosmetic": "planet_aurora"}', false, false, 80),
  ('double_star', 'Двойная звезда', 'Близость 90+ с другом 30 дней подряд', '💫',
    'closeness', 'epic', '{"type": "closeness_days", "score": 90, "days": 30}',
    '{"cosmetic": "glow_double_star"}', false, true, 90),
  ('hundred_days', 'Сто дней', 'Серия 100 дней', '☄️',
    'streak', 'epic', '{"type": "streak_days", "days": 100}',
    '{"cosmetic": "trail_comet"}', false, false, 100),
  ('secret_01', 'Синхрон', 'Вы с другом отправили снапы друг другу в одну минуту', '👯',
    'secret', 'epic', '{"type": "special", "kind": "sync_snap", "window_seconds": 60}',
    '{"cosmetic": "planet_gemini"}', true, true, 110),
  ('secret_02', 'Горизонт событий', 'Отправь десять капсул времени', '🕳️',
    'secret', 'epic', '{"type": "event_count", "event": "capsule_sent", "count": 10}',
    '{"cosmetic": "planet_black_hole"}', true, false, 120),
  ('year_of_friendship', 'Год дружбы', 'Серия 365 дней', '👑',
    'streak', 'legendary', '{"type": "streak_days", "days": 365}',
    '{"cosmetic": "planet_solar_corona"}', false, false, 130);

-- ---------------------------------------------------------------------------
-- Streak: the same logic as EvaluateStreak in the app
-- ---------------------------------------------------------------------------

create function private.streak_status(
  p_streak int,
  p_last timestamptz,
  p_a uuid,
  p_b uuid,
  p_at timestamptz
)
returns text
language plpgsql
stable
set search_path = ''
as $$
declare
  ref timestamptz := p_last;
  s record;
  gap interval;
begin
  if p_streak <= 0 or p_last is null then
    return 'burnt';
  end if;
  for s in
    select shadow_from as f, shadow_until as u
    from public.profiles
    where id in (p_a, p_b) and shadow_from is not null
    order by shadow_from
  loop
    -- A shadow does not save a streak that was lost before it began.
    continue when s.f >= ref + interval '48 hours';
    if s.f <= p_at and p_at < s.u then
      return 'paused';
    end if;
    if s.u <= p_at and s.u > ref then
      ref := s.u;
    end if;
  end loop;
  gap := p_at - ref;
  if gap < interval '24 hours' then
    return 'active';
  elsif gap < interval '48 hours' then
    return 'cracked';
  end if;
  return 'burnt';
end;
$$;

-- ---------------------------------------------------------------------------
-- Achievement conditions
-- ---------------------------------------------------------------------------

create function private.condition_target(p_condition jsonb)
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
    else 1
  end;
$$;

-- Progress towards a condition. p_friend = null gives the best result across
-- all friends; otherwise only this pair counts (for pair achievements).
create function private.condition_progress(
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
-- Granting rewards
-- ---------------------------------------------------------------------------

create function private.xp_for_rarity(p_rarity text)
returns int
language sql
immutable
set search_path = ''
as $$
  select case p_rarity
    when 'common' then 50
    when 'rare' then 150
    when 'epic' then 400
    when 'legendary' then 1000
    else 0
  end;
$$;

-- Unlock an achievement and grant its reward. Returns true only if it
-- unlocked right now: calling it again grants nothing.
create function private.unlock(
  p_user uuid,
  p_achievement public.achievements
)
returns boolean
language plpgsql
set search_path = ''
as $$
declare
  v_target int := private.condition_target(p_achievement.condition);
  v_unlocked boolean;
begin
  insert into public.user_achievements as ua
    (user_id, achievement_id, progress, target, unlocked_at)
  values (p_user, p_achievement.id, v_target, v_target, now())
  on conflict (user_id, achievement_id) do update
    set progress = excluded.progress,
        target = excluded.target,
        unlocked_at = excluded.unlocked_at
    where ua.unlocked_at is null
  returning true into v_unlocked;

  if v_unlocked is not true then
    return false;
  end if;

  insert into public.user_cosmetics (user_id, cosmetic_id, kind)
  select p_user, c.id, c.kind
  from public.cosmetics c
  where c.id = p_achievement.reward ->> 'cosmetic'
  on conflict do nothing;

  insert into public.xp_events (user_id, amount, reason, ref)
  values (
    p_user,
    coalesce(
      (p_achievement.reward ->> 'xp')::int,
      private.xp_for_rarity(p_achievement.rarity)
    ),
    'achievement',
    p_achievement.id
  );
  return true;
end;
$$;

-- ---------------------------------------------------------------------------
-- Engine: recompute progress and unlock what was earned
-- ---------------------------------------------------------------------------

create function private.evaluate_achievements(p_user uuid)
returns void
language plpgsql
set search_path = ''
as $$
declare
  a public.achievements;
  f record;
  v_target int;
  v_progress int;
begin
  if not exists (select 1 from public.profiles where id = p_user) then
    return;
  end if;

  for a in select * from public.achievements order by sort loop
    v_target := private.condition_target(a.condition);

    if a.pair then
      -- A pair achievement unlocks for both friends and leaves a shared
      -- trophy.
      v_progress := 0;
      for f in
        select case when fr.user_a = p_user then fr.user_b else fr.user_a end as id
        from public.friendships fr
        where fr.status = 'accepted' and p_user in (fr.user_a, fr.user_b)
      loop
        v_progress := greatest(
          v_progress, private.condition_progress(a.condition, p_user, f.id)
        );
        if private.condition_progress(a.condition, p_user, f.id) >= v_target then
          perform private.unlock(p_user, a);
          perform private.unlock(f.id, a);
          insert into public.pair_trophies (user_a, user_b, achievement_id)
          values (least(p_user, f.id), greatest(p_user, f.id), a.id)
          on conflict do nothing;
        end if;
      end loop;
    else
      v_progress := private.condition_progress(a.condition, p_user, null);
      if v_progress >= v_target then
        perform private.unlock(p_user, a);
      end if;
    end if;

    -- Progress of locked achievements. Secrets get no row until unlocked,
    -- so the row cannot be used to work out the secret.
    if not a.hidden then
      insert into public.user_achievements as ua
        (user_id, achievement_id, progress, target)
      values (p_user, a.id, least(v_progress, v_target), v_target)
      on conflict (user_id, achievement_id) do update
        set progress = excluded.progress, target = excluded.target
        where ua.unlocked_at is null
          and (ua.progress, ua.target)
            is distinct from (excluded.progress, excluded.target);
    end if;
  end loop;
end;
$$;

-- ---------------------------------------------------------------------------
-- Triggers
-- ---------------------------------------------------------------------------

-- XP and level: level = floor(sqrt(xp / 50)) + 1.
create function private.on_xp_event()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  update public.profiles
    set xp = xp + new.amount,
        level = floor(sqrt((xp + new.amount) / 50.0))::int + 1
    where id = new.user_id;
  return null;
end;
$$;

create trigger xp_events_apply
  after insert on public.xp_events
  for each row execute function private.on_xp_event();

-- Interaction: closeness, streak, return from shadow, then both users'
-- achievements.
create function private.on_interaction()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  a uuid := least(new.from_user, new.to_user);
  b uuid := greatest(new.from_user, new.to_user);
  c public.closeness;
  previous_exchange timestamptz;
  status text;
  sender_shadow_until timestamptz;
begin
  if not private.are_friends(new.from_user, new.to_user) then
    raise exception 'Interactions are allowed only between friends'
      using errcode = '42501';
  end if;

  if new.kind in ('text', 'snap', 'capsule_sent') then
    select * into c from public.closeness
      where user_a = a and user_b = b
      for update;
    if not found then
      insert into public.closeness (user_a, user_b) values (a, b)
        returning * into c;
    end if;

    previous_exchange := c.last_exchange_at;
    status := private.streak_status(
      c.streak_days, c.last_exchange_at, a, b, new.created_at
    );

    if status = 'burnt' then
      c.streak_days := 1;
    elsif (new.created_at at time zone 'utc')::date
        > (c.last_exchange_at at time zone 'utc')::date then
      c.streak_days := c.streak_days + 1;
    end if;

    c.score := least(100, c.score + case new.kind
      when 'text' then 1 when 'snap' then 2 else 3 end);
    c.high_since := case
      when c.score >= 90 then coalesce(c.high_since, new.created_at)
      else null
    end;

    update public.closeness
      set score = c.score,
          streak_days = c.streak_days,
          last_exchange_at = greatest(coalesce(c.last_exchange_at, new.created_at), new.created_at),
          high_since = c.high_since
      where user_a = a and user_b = b;

    update public.profiles
      set best_streak_days = greatest(best_streak_days, c.streak_days)
      where id in (a, b);

    -- A return: the sender's shadow ended after the previous exchange and the
    -- streak did not burn out. Counts once per shadow.
    select shadow_until into sender_shadow_until
      from public.profiles where id = new.from_user;
    if status <> 'burnt'
      and sender_shadow_until is not null
      and sender_shadow_until <= new.created_at
      and sender_shadow_until > previous_exchange
      and not exists (
        select 1 from public.interactions i
        where i.from_user = new.from_user
          and i.kind = 'shadow_return'
          and i.created_at >= sender_shadow_until
      )
    then
      insert into public.interactions (from_user, to_user, kind, created_at)
      values (new.from_user, new.to_user, 'shadow_return', new.created_at);
    end if;
  end if;

  perform private.evaluate_achievements(new.from_user);
  perform private.evaluate_achievements(new.to_user);
  return null;
end;
$$;

create trigger interactions_apply
  after insert on public.interactions
  for each row execute function private.on_interaction();

create function private.on_friendship()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.status = 'accepted'
    and (tg_op = 'INSERT' or old.status is distinct from new.status) then
    insert into public.closeness (user_a, user_b)
      values (new.user_a, new.user_b)
      on conflict do nothing;
    perform private.evaluate_achievements(new.user_a);
    perform private.evaluate_achievements(new.user_b);
  end if;
  return null;
end;
$$;

create trigger friendships_apply
  after insert or update of status on public.friendships
  for each row execute function private.on_friendship();

-- ---------------------------------------------------------------------------
-- Nightly job: lost streaks, cooling closeness, time-based conditions
-- ---------------------------------------------------------------------------

create function private.nightly()
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  p record;
begin
  update public.closeness c
    set streak_days = 0
    where c.streak_days > 0
      and private.streak_status(
        c.streak_days, c.last_exchange_at, c.user_a, c.user_b, now()
      ) = 'burnt';

  -- After three days without contact, closeness slowly cools down.
  update public.closeness
    set score = greatest(0, score - 1)
    where last_exchange_at < now() - interval '3 days';
  update public.closeness
    set high_since = null
    where score < 90 and high_since is not null;

  for p in select id from public.profiles loop
    perform private.evaluate_achievements(p.id);
  end loop;
end;
$$;

create extension if not exists pg_cron with schema pg_catalog;
grant usage on schema cron to postgres;
select cron.schedule('orbitly-nightly', '0 3 * * *', 'select private.nightly()');

-- ---------------------------------------------------------------------------
-- RPCs for the client
-- ---------------------------------------------------------------------------

-- The catalogue with my progress. Locked secrets come without title,
-- description, progress and reward.
create function public.get_my_achievements()
returns table (
  id text,
  title text,
  description text,
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
  reward_title text,
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

create function public.mark_achievement_seen(p_achievement_id text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  update public.user_achievements
    set seen_at = now()
    where user_id = me
      and achievement_id = p_achievement_id
      and unlocked_at is not null
      and seen_at is null;
end;
$$;

create function public.equip_cosmetic(p_cosmetic_id text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  owned_kind text;
begin
  select kind into owned_kind
    from public.user_cosmetics
    where user_id = me and cosmetic_id = p_cosmetic_id;
  if owned_kind is null then
    raise exception 'Cosmetic is not owned' using errcode = '42501';
  end if;
  update public.user_cosmetics
    set equipped = false
    where user_id = me and kind = owned_kind and equipped;
  update public.user_cosmetics
    set equipped = true
    where user_id = me and cosmetic_id = p_cosmetic_id;
end;
$$;

create function public.unequip_cosmetic(p_kind text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  update public.user_cosmetics
    set equipped = false
    where user_id = me and kind = p_kind and equipped;
end;
$$;

-- Friends for the system and lists: profile, worn cosmetics, closeness,
-- streak, shadow and the pair's shared trophies.
create function public.get_my_friends()
returns table (
  id uuid,
  handle text,
  display_name text,
  planet_name text,
  appearance jsonb,
  equipped jsonb,
  mood text,
  closeness int,
  streak_days int,
  last_exchange_at timestamptz,
  shadow_from timestamptz,
  shadow_until timestamptz,
  trophies jsonb
)
language sql
stable
security definer
set search_path = ''
as $$
  select
    p.id,
    p.handle,
    p.display_name,
    p.planet_name,
    p.appearance,
    coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', c.id, 'title', c.title, 'kind', c.kind,
        'rarity', c.rarity, 'params', c.params))
      from public.user_cosmetics uc
      join public.cosmetics c on c.id = uc.cosmetic_id
      where uc.user_id = p.id and uc.equipped
    ), '[]'::jsonb),
    p.mood,
    coalesce(cl.score, 0),
    coalesce(cl.streak_days, 0),
    cl.last_exchange_at,
    p.shadow_from,
    p.shadow_until,
    coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', a.id, 'title', a.title, 'icon', a.icon,
        'rarity', a.rarity, 'earned_at', pt.earned_at) order by pt.earned_at)
      from public.pair_trophies pt
      join public.achievements a on a.id = pt.achievement_id
      where pt.user_a = f.user_a and pt.user_b = f.user_b
    ), '[]'::jsonb)
  from public.friendships f
  join public.profiles p
    on p.id = case when f.user_a = (select auth.uid()) then f.user_b else f.user_a end
  left join public.closeness cl
    on cl.user_a = f.user_a and cl.user_b = f.user_b
  where f.status = 'accepted'
    and (select auth.uid()) in (f.user_a, f.user_b)
  order by cl.score desc nulls last;
$$;

-- ---------------------------------------------------------------------------
-- Privileges, policies, Realtime
-- ---------------------------------------------------------------------------

alter table public.cosmetics enable row level security;
alter table public.achievements enable row level security;
alter table public.user_achievements enable row level security;
alter table public.pair_trophies enable row level security;
alter table public.user_cosmetics enable row level security;
alter table public.xp_events enable row level security;

revoke all on public.cosmetics, public.achievements, public.user_achievements,
  public.pair_trophies, public.user_cosmetics, public.xp_events
  from anon, authenticated;

-- The achievement catalogue is closed for direct reads: conditions and
-- secrets go out only through get_my_achievements(). The client cannot
-- insert or change anything.
grant select on public.cosmetics, public.user_achievements,
  public.pair_trophies, public.user_cosmetics, public.xp_events
  to authenticated;

create policy "Cosmetics: catalogue visible to signed-in users"
  on public.cosmetics for select to authenticated
  using (true);

create policy "Achievements: only your own"
  on public.user_achievements for select to authenticated
  using (user_id = (select auth.uid()));

create policy "Shared trophies: only your own pairs"
  on public.pair_trophies for select to authenticated
  using ((select auth.uid()) in (user_a, user_b));

create policy "User cosmetics: only your own"
  on public.user_cosmetics for select to authenticated
  using (user_id = (select auth.uid()));

create policy "XP: only your own"
  on public.xp_events for select to authenticated
  using (user_id = (select auth.uid()));

revoke execute on all functions in schema public from public, anon;
revoke execute on all functions in schema private from public, anon, authenticated;
grant execute on function
  private.are_friends(uuid, uuid),
  private.is_valid_base_appearance(jsonb)
  to authenticated;
grant execute on function
  public.get_my_achievements(),
  public.mark_achievement_seen(text),
  public.equip_cosmetic(text),
  public.unequip_cosmetic(text),
  public.get_my_friends()
  to authenticated;

-- New unlocks reach the app at once (RLS applies here too).
alter publication supabase_realtime add table public.user_achievements;
