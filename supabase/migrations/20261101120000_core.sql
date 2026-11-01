-- Ядро Orbitly: профили (планеты), дружба, близость, взаимодействия.
-- Таблица сообщений создаётся на будущее; клиент к ней пока не подключён.
--
-- Правила доступа:
--  * RLS включён на каждой таблице.
--  * У ролей anon/authenticated сначала отбираются все права, затем выдаются
--    только нужные (новые таблицы в Supabase по умолчанию открыты).
--  * Всё, что влияет на прогресс и награды, меняется только функциями на
--    сервере: клиенту нельзя доверять.

create schema if not exists private;
revoke all on schema private from public;
-- Политикам RLS нужны функции-помощники из private.
grant usage on schema private to authenticated;

-- ---------------------------------------------------------------------------
-- Профиль = планета пользователя
-- ---------------------------------------------------------------------------

-- Базовый вид планеты: только 7 обычных типов. Редкие типы открываются
-- наградами и хранятся в user_cosmetics.
create function private.is_valid_base_appearance(appearance jsonb)
returns boolean
language sql
immutable
set search_path = ''
as $$
  select jsonb_typeof(appearance) = 'object'
    and appearance ->> 'type' in
      ('ocean', 'lava', 'ice', 'jungle', 'candy', 'crystal', 'gas')
    and jsonb_typeof(appearance -> 'seed') = 'number'
    and jsonb_typeof(appearance -> 'hue') = 'number'
    and (appearance ->> 'hue')::numeric between 0 and 360;
$$;

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  handle text not null unique check (handle ~ '^[a-z0-9._]{3,32}$'),
  display_name text not null check (char_length(display_name) between 1 and 40),
  planet_name text not null check (char_length(planet_name) between 2 and 20),
  appearance jsonb not null check (private.is_valid_base_appearance(appearance)),
  mood text not null default 'happy'
    check (mood in ('happy', 'calm', 'inLove', 'excited', 'tired', 'sad')),
  -- Опыт и уровень пишет только сервер (журнал xp_events).
  xp int not null default 0 check (xp >= 0),
  level int not null default 1 check (level >= 1),
  best_streak_days int not null default 0,
  shadow_from timestamptz,
  shadow_until timestamptz,
  created_at timestamptz not null default now(),
  check ((shadow_from is null) = (shadow_until is null)),
  check (shadow_until is null or shadow_until > shadow_from)
);

-- ---------------------------------------------------------------------------
-- Дружба: одна строка на пару, user_a < user_b
-- ---------------------------------------------------------------------------

create table public.friendships (
  user_a uuid not null references public.profiles (id) on delete cascade,
  user_b uuid not null references public.profiles (id) on delete cascade,
  status text not null check (status in ('pending', 'accepted')),
  requested_by uuid not null references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now(),
  accepted_at timestamptz,
  primary key (user_a, user_b),
  check (user_a < user_b),
  check (requested_by in (user_a, user_b))
);
create index friendships_user_b_idx on public.friendships (user_b);

create function private.are_friends(me uuid, other uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.friendships f
    where f.user_a = least(me, other)
      and f.user_b = greatest(me, other)
      and f.status = 'accepted'
  );
$$;
revoke execute on function private.are_friends(uuid, uuid) from public;
grant execute on function private.are_friends(uuid, uuid) to authenticated;

-- ---------------------------------------------------------------------------
-- Близость и серия пары
-- ---------------------------------------------------------------------------

create table public.closeness (
  user_a uuid not null,
  user_b uuid not null,
  score int not null default 10 check (score between 0 and 100),
  streak_days int not null default 0 check (streak_days >= 0),
  last_exchange_at timestamptz,
  -- С какого момента близость держится на уровне 90+ без перерыва.
  high_since timestamptz,
  primary key (user_a, user_b),
  foreign key (user_a, user_b)
    references public.friendships (user_a, user_b) on delete cascade,
  check (user_a < user_b)
);

-- ---------------------------------------------------------------------------
-- Взаимодействия: журнал событий, из которого считаются близость и награды.
-- Пишет только сервер (будущий чат — триггером, сейчас — seed и тесты).
-- ---------------------------------------------------------------------------

create table public.interactions (
  id bigint generated always as identity primary key,
  from_user uuid not null references public.profiles (id) on delete cascade,
  to_user uuid not null references public.profiles (id) on delete cascade,
  kind text not null check (kind in
    ('text', 'snap', 'capsule_sent', 'capsule_opened', 'shadow_return')),
  created_at timestamptz not null default now(),
  check (from_user <> to_user)
);
create index interactions_from_kind_idx on public.interactions (from_user, kind);
create index interactions_to_created_idx on public.interactions (to_user, created_at);

-- ---------------------------------------------------------------------------
-- Сообщения (следующий этап: чат, снапы, капсулы)
-- ---------------------------------------------------------------------------

create table public.messages (
  id uuid primary key default gen_random_uuid(),
  from_user uuid not null references public.profiles (id) on delete cascade,
  to_user uuid not null references public.profiles (id) on delete cascade,
  kind text not null check (kind in ('text', 'snap', 'capsule')),
  body text check (char_length(body) <= 1000),
  media_path text,
  opens_at timestamptz,
  opened_at timestamptz,
  created_at timestamptz not null default now(),
  check (from_user <> to_user),
  check ((kind = 'capsule') = (opens_at is not null))
);
create index messages_pair_created_idx
  on public.messages (from_user, to_user, created_at);

-- Текст чужой капсулы не отдаётся до срока: читать переписку клиент будет
-- через этот view, а не из таблицы.
create view public.messages_visible
with (security_invoker = true)
as
select
  m.id, m.from_user, m.to_user, m.kind,
  case
    when m.kind = 'capsule'
      and m.from_user <> (select auth.uid())
      and m.opens_at > now()
    then null
    else m.body
  end as body,
  m.media_path, m.opens_at, m.opened_at, m.created_at
from public.messages m;

-- ---------------------------------------------------------------------------
-- Права и политики
-- ---------------------------------------------------------------------------

alter table public.profiles enable row level security;
alter table public.friendships enable row level security;
alter table public.closeness enable row level security;
alter table public.interactions enable row level security;
alter table public.messages enable row level security;

revoke all on public.profiles, public.friendships, public.closeness,
  public.interactions, public.messages, public.messages_visible
  from anon, authenticated;

grant select on public.profiles, public.friendships, public.closeness,
  public.interactions to authenticated;
-- Своё имя, название, настроение и базовый вид меняет сам пользователь.
-- Опыт, уровень, тень — только функции на сервере.
grant update (display_name, planet_name, mood, appearance)
  on public.profiles to authenticated;

create policy "Профиль: я и мои друзья"
  on public.profiles for select to authenticated
  using (
    id = (select auth.uid())
    or private.are_friends((select auth.uid()), id)
  );

create policy "Профиль: менять только свой"
  on public.profiles for update to authenticated
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));

create policy "Дружба: только свои пары"
  on public.friendships for select to authenticated
  using ((select auth.uid()) in (user_a, user_b));

create policy "Близость: только свои пары"
  on public.closeness for select to authenticated
  using ((select auth.uid()) in (user_a, user_b));

create policy "Взаимодействия: только свои"
  on public.interactions for select to authenticated
  using ((select auth.uid()) in (from_user, to_user));

-- Политики для чата написаны заранее; права на таблицу клиенту выдадим на
-- следующем этапе.
create policy "Сообщения: только участники"
  on public.messages for select to authenticated
  using ((select auth.uid()) in (from_user, to_user));
