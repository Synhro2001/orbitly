# Orbitly security

First audit: 1 November 2026, on branch `feat/ui-mock`, when the app still ran
on mock data. Updated on 2 November 2026 after the move to Supabase: the
server-side items from that audit are now marked as done or still open.

## What was checked

| Area | How | Result |
|---|---|---|
| Dependencies | all 78 packages from `pubspec.lock` against the OSV database (api.osv.dev) | no vulnerabilities |
| Secrets | search for keys, tokens and passwords in the code and the whole git history | none found |
| Logging | `print` / `debugPrint` / `log` in `lib/` | none |
| Network | `http://` URLs in the code | none |
| Deep links | `/chat/<someone else's id>` | a clean error, no crash |
| Text input | length of messages, search, planet name | limited |
| Other users' data | unknown types, broken records | do not break the screen |
| Android | manifest and signature of the final APK (`aapt`, `apksigner`) | see below |
| Web | CSP, browser console after a build | no errors |

Client tests are in `test/security/`; server tests are in `supabase/tests/`
(pgTAP).

## Found and fixed in the app

1. **One broken record broke the screen for every friend.** Planet looks and
   messages come from users. An unknown planet type, mood or message kind
   threw an exception, and the whole friend list or chat failed to open. Enums
   now have fallback values, and unreadable records are skipped
   (`core/data/parse.dart`).
2. **The text of a sealed capsule reached the recipient's device** and was
   hidden only by the UI, so a modified client could read it. The server now
   never sends the text before the capsule opens (see below).
3. **A fake shadow revived streaks.** The client could send a shadow lasting a
   year or starting in the past. `ShadowPolicy` now allows at most 7 days,
   starting only "now", and leaving early may only move the end closer. The
   server enforces the same rules.
4. **No length limit on messages and capsules.** A huge text would bloat the
   database and freeze the recipient's screen. `MessageRules`: up to 1000
   characters, a capsule at most a year ahead. Both the client and the server
   check this. Search is limited to 32 characters.
5. **Android: data went into backups.** Chats and tokens were copied to the
   cloud and to a new phone on transfer. Now `allowBackup="false"` and
   `data_extraction_rules.xml`.
6. **Android: cleartext HTTP was allowed on versions 7–8.1.** Now
   `usesCleartextTraffic="false"`. Debug builds allow http only to the local
   Supabase (`10.0.2.2`, `127.0.0.1`, `localhost`).
7. **Android: release builds were always signed with the debug key.** The key
   now comes from `android/key.properties` (gitignored). Without it the debug
   key is still used, and such a build **must not be published**.
8. **Web: no Content-Security-Policy.** Scripts now load only from our own
   origin and Flutter's renderer from `gstatic.com`.

## Server (Supabase)

The client is never trusted: these rules live in the database (RLS policies
and `security definer` functions).

Done:

- **Row level security on every table.** Clients cannot grant themselves
  achievements, cosmetics, XP or interactions; covered by
  `supabase/tests/01_rls.test.sql`.
- **Chat access.** The client has no rights on the `messages` table at all.
  Reading and sending go through server functions that check friendship, so
  only the two participants see a conversation.
- **Capsules.** `text` is `null` for the recipient until `opens_at`; the
  opening time must be between now and one year ahead. Realtime only sends
  "who wrote to whom" signals, never text.
- **View-once snaps.** The server marks a snap as viewed and refuses a second
  view.
- **Shadow.** The same rules as `ShadowPolicy`, using the server clock.
- **Length limits** on messages (1000), search (32), names and planet names.
- **Rate limit on messages:** 30 per minute per user.
- **Keys.** Only the publishable key ships with the app; the service role key
  is never in the client or in git.

Still open:

- **Rate limits on friend requests and search**, to stop spam and handle
  enumeration.
- **Streak status by server time.** The client computes it from the phone
  clock, which can be changed. This only affects what is shown; rewards are
  computed on the server.
- **Snap media.** When photos move to Supabase Storage: private bucket,
  short-lived signed URLs, the file deleted after viewing.
- **Real email delivery.** A hosted project needs its own SMTP provider; the
  built-in one has tight hourly limits.

## Still to do in the app

- **Block screenshots on the snap viewer** (`FLAG_SECURE` on Android,
  screenshot detection on iOS) once the real camera is in.
- **Store session tokens in secure storage** (Keystore / Keychain).
  `supabase_flutter` keeps them in SharedPreferences by default; backups are
  already off, but a rooted device can still read them.
- **Own signing key** before the first release:
  `keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`,
  then `android/key.properties` with `storeFile`, `storePassword`, `keyAlias`,
  `keyPassword`.
- **Obfuscate Dart in release builds:**
  `flutter build apk --release --obfuscate --split-debug-info=build/symbols`.
- **Web hosting headers:** `X-Frame-Options: DENY` (or CSP
  `frame-ancestors 'none'`) and HSTS. These cannot be set in a meta tag.
