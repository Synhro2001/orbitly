-- Help and age.
--   feedback — "Report a problem": text, app version, device. Filed by the
--              user, read only by the team (no client reads).
--   18+      — Orbitly is for adults. Creating a planet needs the user to
--              confirm it; the time of confirmation is kept.

create table public.feedback (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles (id) on delete set null,
  message text not null check (char_length(btrim(message)) between 1 and 2000),
  app_version text check (char_length(app_version) <= 40),
  device text check (char_length(device) <= 100),
  created_at timestamptz not null default now()
);
create index feedback_user_created_idx on public.feedback (user_id, created_at);
alter table public.feedback enable row level security;
revoke all on public.feedback from anon, authenticated;

create function public.submit_feedback(p_message text, p_app_version text, p_device text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
begin
  if (select count(*) from public.feedback
      where user_id = me and created_at > now() - interval '1 day') >= 10 then
    raise exception 'Too much feedback today' using errcode = '54000';
  end if;
  insert into public.feedback (user_id, message, app_version, device)
  values (me, btrim(p_message), left(p_app_version, 40), left(p_device, 100));
end;
$$;

alter table public.profiles add column adult_confirmed_at timestamptz;

-- The old three-argument version had no age confirmation.
drop function public.complete_onboarding(text, text, jsonb);
create function public.complete_onboarding(
  p_display_name text,
  p_planet_name text,
  p_appearance jsonb,
  p_is_adult boolean
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := private.require_user();
  base text;
  candidate text;
  n int := 0;
begin
  if not coalesce(p_is_adult, false) then
    raise exception 'Orbitly is for people aged 18 and over' using errcode = '22023';
  end if;
  if exists (select 1 from public.profiles where id = me) then
    raise exception 'Profile already exists' using errcode = '23505';
  end if;

  select left(regexp_replace(lower(split_part(u.email, '@', 1)), '[^a-z0-9._]', '', 'g'), 26)
    into base
    from auth.users u
    where u.id = me;
  if base is null or char_length(base) < 3 then
    base := 'planet';
  end if;

  candidate := base;
  while private.handle_taken(candidate, me) loop
    n := n + 1;
    candidate := base || n::text;
  end loop;

  -- Take only the base fields from the given look; the table constraint
  -- checks the rest.
  insert into public.profiles (id, handle, display_name, planet_name, appearance, adult_confirmed_at)
  values (
    me,
    candidate,
    btrim(p_display_name),
    btrim(p_planet_name),
    jsonb_build_object(
      'type', p_appearance -> 'type',
      'seed', p_appearance -> 'seed',
      'hue', p_appearance -> 'hue'
    ),
    now()
  );
end;
$$;

revoke execute on function
  public.submit_feedback(text, text, text),
  public.complete_onboarding(text, text, jsonb, boolean)
  from public, anon;
grant execute on function
  public.submit_feedback(text, text, text),
  public.complete_onboarding(text, text, jsonb, boolean)
  to authenticated;
