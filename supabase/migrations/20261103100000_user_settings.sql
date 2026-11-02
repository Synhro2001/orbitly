-- Account settings: privacy, notifications, wellbeing and chats. One row per
-- user, created with the profile. Defaults are the most private sensible
-- choice; the user opens up, not the other way round.
--
-- The client reads and updates only its own row (RLS). Check constraints
-- validate values; the server functions that serve other users' data read
-- these settings, so nothing depends on the UI hiding things. Values are
-- the Dart enum names, like profiles.mood.

create table public.user_settings (
  user_id uuid primary key references public.profiles (id) on delete cascade,

  -- Privacy.
  search_visibility text not null default 'friendsOfFriends'
    check (search_visibility in ('everyone', 'friendsOfFriends', 'nobody')),
  request_policy text not null default 'friendsOfFriends'
    check (request_policy in ('everyone', 'friendsOfFriends', 'inviteOnly')),
  moments_audience text not null default 'friends'
    check (moments_audience in ('closeOrbit', 'friends', 'custom')),
  mood_audience text not null default 'friends'
    check (mood_audience in ('closeOrbit', 'friends', 'nobody')),
  show_last_seen boolean not null default false,
  read_receipts boolean not null default true,
  typing_indicator boolean not null default true,
  galaxy_visible boolean not null default false,

  -- Notifications (read by push delivery later).
  notify_messages boolean not null default true,
  notify_requests boolean not null default true,
  notify_capsules boolean not null default true,
  notify_shadow boolean not null default true,
  notify_streaks boolean not null default true,
  notify_achievements boolean not null default true,
  notify_weekly_report boolean not null default true,
  notification_preview text not null default 'sender'
    check (notification_preview in ('full', 'sender', 'none')),
  quiet_hours_enabled boolean not null default true,
  quiet_from time not null default '23:00',
  quiet_to time not null default '08:00',

  -- Wellbeing.
  hide_streaks boolean not null default false,
  daily_limit_minutes int check (daily_limit_minutes in (15, 30, 60, 90)),

  -- Chats: the rule for new chats.
  message_retention text not null default 'day'
    check (message_retention in ('afterSeen', 'day', 'keep')),

  updated_at timestamptz not null default now()
);

alter table public.user_settings enable row level security;

create policy "Settings: only your own"
  on public.user_settings for select to authenticated
  using (user_id = (select auth.uid()));
create policy "Settings: update only your own"
  on public.user_settings for update to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

revoke all on public.user_settings from anon, authenticated;
grant select on public.user_settings to authenticated;
-- Every column except the owner and the timestamp.
grant update (
  search_visibility, request_policy, moments_audience, mood_audience,
  show_last_seen, read_receipts, typing_indicator, galaxy_visible,
  notify_messages, notify_requests, notify_capsules, notify_shadow,
  notify_streaks, notify_achievements, notify_weekly_report,
  notification_preview, quiet_hours_enabled, quiet_from, quiet_to,
  hide_streaks, daily_limit_minutes, message_retention
) on public.user_settings to authenticated;

create function private.touch_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger user_settings_touch
  before update on public.user_settings
  for each row execute function private.touch_updated_at();

-- A new profile gets default settings.
create function private.on_profile_created()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.user_settings (user_id) values (new.id)
  on conflict do nothing;
  return new;
end;
$$;

create trigger profiles_settings
  after insert on public.profiles
  for each row execute function private.on_profile_created();

-- Existing users.
insert into public.user_settings (user_id)
select id from public.profiles
on conflict do nothing;

revoke execute on function private.touch_updated_at(), private.on_profile_created()
  from public, anon, authenticated;

-- One helper for every check: the settings row of a user. Every profile has
-- one (trigger above). If it were missing, all fields would be null, every
-- "is it allowed" comparison would be null, and null counts as "no": a gap
-- closes things rather than opening them.
create function private.settings_of(p_user uuid)
returns public.user_settings
language sql
stable
security definer
set search_path = ''
as $$
  select s from public.user_settings s where s.user_id = p_user;
$$;
revoke execute on function private.settings_of(uuid) from public, anon, authenticated;
