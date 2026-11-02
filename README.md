# Orbitly

A messenger for close friends. You are a planet, and your friends orbit
around you: the closer you are, the closer their orbit.

The app is built with Flutter and runs on Supabase (auth, Postgres, Realtime).
It can also run fully offline on built-in mock data, which is what the tests
use.

## What makes it different

- **Shadow.** Go offline for 1 day, 3 days or a week (exams, a holiday).
  All your streaks freeze (🌘), and when you come back your friends have a
  full day to continue. This answers the main complaint about Snapchat
  streaks: people keep them up out of anxiety, even when they have no energy.
- **Conversation openers.** When a friend is drifting away or a streak has
  cracked, a few first lines appear above the input. Tapping one puts it in
  the field instead of sending it, so it can be edited.
- **Time capsules.** A message your friend can read tomorrow, in a week, a
  month or a year. Until then the recipient sees only a sealed capsule, and
  the server does not even send them the text.
- **Achievements that grow the planet.** Friendship milestones unlock rare
  planet types, moons, rings, glows and comet trails. Pair achievements give
  both friends a shared trophy. No loot boxes, no payments.

## Status

| Area | State |
|---|---|
| Sign-in (6-digit code by email) | Supabase |
| Planet, onboarding, shadow | Supabase |
| Friends, requests, search | Supabase |
| Achievements, cosmetics, unlock animation | Supabase + Realtime |
| Chat: text and time capsules | Supabase + Realtime |
| Snaps (sending), moments, camera | UI only; needs media storage |
| Languages (Russian, English) | Done |
| Settings: privacy, block and report, profile and handle, disappearing messages, wellbeing, account deletion and data export | Supabase |
| Notification settings | Saved; hidden until push exists |
| Weekly report | Mock data |

## Running

You need Flutter stable (tested with 3.47.5 / Dart 3.13.4). For the backend
you also need Docker Desktop and Node.js (the Supabase CLI runs via `npx`).

### On mock data (no backend)

```bash
flutter pub get
flutter run
```

Nothing is saved: data lives in memory and resets on restart.

### With local Supabase

```bash
npx supabase@2.122.0 start      # first start downloads the Docker images
npx supabase@2.122.0 status     # shows the API URL and the publishable key
```

Then run the app against it (`10.0.2.2` is how the Android emulator sees your
computer):

```bash
flutter run --dart-define=USE_MOCKS=false --dart-define=SUPABASE_URL=http://10.0.2.2:54321 --dart-define=SUPABASE_PUBLISHABLE_KEY=<publishable key>
```

Sign in as `anya@orbitly.test`, `misha@orbitly.test` or `lera@orbitly.test`.
The code arrives in Mailpit at http://127.0.0.1:54324. Supabase Studio is at
http://127.0.0.1:54323.

Useful commands:

```bash
npx supabase@2.122.0 db reset   # re-apply migrations and seed data
npx supabase@2.122.0 test db    # run the database tests (pgTAP)
npx supabase@2.122.0 stop
```

Only the project URL and the publishable key go into the app. The secret
(service role) key must never be put in the client or committed.

### Windows: non-ASCII characters in the path

`build_runner`, `gen-l10n` and the Android build fail when the project path
contains non-ASCII characters (for example a Cyrillic "Desktop" folder). Map
the project to a drive letter and work from there:

```bash
subst O: "C:\path\to\orbitly"
```

In PowerShell, switch to it with `cd O:\` (in cmd: `cd /d O:\`). The mapping
is lost on reboot. Moving the project to a plain path such as `C:\dev\orbitly`
avoids the issue entirely.

## Checks

```bash
flutter analyze
flutter test                     # unit and widget tests
npx supabase@2.122.0 test db     # database: RLS, achievements, chat
```

Smoothness benchmark (profile build on a device or emulator, results in
`build/perf.json`):

```bash
flutter drive --profile --driver=test_driver/perf_driver.dart --target=integration_test/perf_test.dart
```

### Code generation

Models (freezed/json), providers (riverpod_generator) and localisation are
generated and committed. After changing models, providers or the `.arb` files:

```bash
dart run build_runner build
flutter gen-l10n
```

## Project structure

```
lib/
  main.dart
  app/            app widget, router, bottom navigation, env.dart (build
                  settings), di.dart (the one place that picks mock or
                  Supabase repositories)
  core/
    domain/       shared entities (Friend, PlanetAppearance, Streak, Award,
                  Cosmetic, Shadow) and use cases (EvaluateStreak,
                  ApplyCosmetics, ShadowPolicy)
    data/         shared models, mock/ (in-memory fake backend),
                  supabase/ (RPC helpers), network/ (HTTP timeout)
    planet_render/ procedural PlanetPainter, rare planets, image cache
    theme/        tokens: colours, spacing, sizes, durations, theme
    widgets/      PlanetView, starfield, streak badge, async view
    utils/        clock, l10n helpers
  features/
    achievements/ collection, wardrobe, unlock animation
    auth/         email code sign-in
    camera/       camera UI (placeholder)
    chat/         chat list, conversation, capsules, openers
    friends/      search, requests, invite link
    onboarding/   planet creation
    planet/       my planet: level, XP, mood, shadow
    report/       weekly report
    settings/     settings screens, account and device settings
    system/       main screen: orbits, moments
  l10n/          UI strings: app_ru.arb (template), app_en.arb
supabase/
  migrations/     schema, RLS, server functions, achievement engine, chat
  tests/          pgTAP tests
  seed.sql        three test users with history
  templates/      sign-in email
test/             unit, widget and security tests
integration_test/ frame-timing benchmark
```

Each feature has `domain/` (pure Dart: entities, repository interface, rules),
`data/` (models, mock and Supabase repositories) and `presentation/` (screens,
widgets, Riverpod controllers).

## Design decisions

- **One switch for the backend.** The UI sees only repository interfaces
  through the providers in `app/di.dart`. `USE_MOCKS` picks the mock or the
  Supabase implementation.
- **Mocks speak JSON.** `MockStore` keeps data as snake_case JSON, the way
  Supabase returns it, so mock repositories go through the same
  JSON → model → entity path as the real ones.
- **The server is the authority.** Progress, XP, rewards, streaks and shadows
  change only through `security definer` functions; RLS is on for every
  table. The client never reads the `messages` table directly: server
  functions hide a friend's capsule text until it opens, and Realtime only
  sends "who wrote to whom" signals, never text.
- **One broken record does not break a screen.** Data from other users is
  parsed with `parseValid`, which skips unreadable rows, and enums have
  fallbacks for values from a newer server.
- **Streaks:** less than 24 h since the last exchange is active, 24–48 h is
  cracked, after that it is lost. A shadow pauses the clock.
- **Planets** are drawn by a `CustomPainter` from a seed (own xorshift, so web
  and Android match) and cached as images by memory budget.
- **Performance:** the orbit map avoids per-frame blurs and opacity layers;
  the benchmark keeps every main screen at 60 fps on the emulator.
- **Languages.** UI strings live in ARB files (`gen-l10n`); the app follows
  the phone's language, falls back to English, and can be switched in the
  settings (stored on the phone). Catalogue texts from the database come as
  `{"ru": ..., "en": ...}` and the app picks one, so switching needs no
  reload; English is required for every row. The language is also saved in
  the account metadata, and the sign-in email uses it. To add a language:
  add `app_<code>.arb`, add the key to every catalogue row, add a branch to
  `supabase/templates/otp.html`, and add it to `AppLanguage`.
- **Privacy by default.** Every setting starts at the most private sensible
  choice and is enforced in SQL (search, requests, invites, mood, blocks,
  disappearing messages), not only hidden in the UI. Friends read each
  other's profiles only through server functions. Account deletion waits
  7 days and runs in pg_cron inside the database; no service role key.
- **Fonts:** Golos Text and Unbounded (OFL), in `assets/fonts`.
- **Analysis:** `very_good_analysis` with two rules off: `public_member_api_docs`
  (this is an app, not a package) and the new constructor syntax rule
  (freezed uses the classic one).

## Next steps

- Snaps and photos in Supabase Storage, visible only to the recipient.
- Loading older messages when scrolling up.
- Push notifications.
- A hosted Supabase project and a test build for friends.
