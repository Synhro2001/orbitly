# Deploying Orbitly to Supabase Cloud

The steps to take Orbitly from the local Docker setup to hosted Supabase:
a staging project to try things on, and a production project for real users.
Steps marked **(owner)** need the owner's accounts or payment; everything
else is commands.

## 1. Projects (owner)

1. Sign in at supabase.com and turn on two-factor authentication for the
   account (Account → Security).
2. Create two projects, both in the **Central EU (Frankfurt)** region:
   - `orbitly-staging` — Free plan is enough;
   - `orbitly` — production, **Pro plan**: daily backups and no pausing.
3. Write down each project's **reference** (the `xxxx` in
   `https://xxxx.supabase.co`) and **database password**. The password is
   only typed into the CLI prompt; it never goes into the repository.
4. Accept Supabase's Data Processing Addendum (Organization → Legal
   documents). GDPR needs a contract with every processor.

## 2. Database: migrations and background jobs

From the repository root (on Windows: `cd O:\`), staging first:

```bash
npx supabase@2.122.0 link --project-ref <staging-ref>
npx supabase@2.122.0 db push        # applies supabase/migrations; asks for the DB password
npx supabase@2.122.0 test db --linked
```

`db push` does **not** load `seed.sql`. Test users belong only in the local
setup.

Then check in the dashboard (SQL editor) that the background jobs exist:

```sql
select jobname, schedule from cron.job order by jobname;
-- nightly achievements, purge-deleted-accounts, purge-expired-messages,
-- purge-rate-events
```

Repeat with `<production-ref>` once staging works. Do not run
`test db --linked` against production: the tests create and roll back
rows, which is safe, but production should not be a test bed.

## 3. Auth settings and email templates

```bash
npx supabase@2.122.0 config diff    # review first
npx supabase@2.122.0 config push    # confirm each change
```

Overrides for the hosted project live in `[remotes.cloud]` at the end of
`supabase/config.toml` (project `gmagtpaxakvafvqtsyrt`, Paris). They keep the
cloud's own redirect URLs, email frequency, TOTP, pooler and storage values.

**Set up email delivery (section 4) first.** Supabase refuses template changes
on a free project that uses its built-in sender, and the built-in sign-in email
has a link but no six-digit code, so the app cannot sign in until custom SMTP
is on and this push has gone through.

This pushes the `[auth]` section of `supabase/config.toml`:
- six-digit codes;
- the code templates in Russian and English (`supabase/templates`);
- email change confirmed only at the new address.

Afterwards, in Authentication → URL Configuration, set **Site URL** to
`https://orbitly.app`. The local value `http://127.0.0.1:3000` must not stay
in production.

## 4. Email delivery (owner)

The built-in sender allows only a couple of emails an hour, and sign-in
depends on email codes.

1. Create an account with a transactional email provider (Resend, Brevo or
   Postmark). Turn **off** link and click tracking: it can break auth
   emails.
2. Verify the sending domain (for example `no-reply@orbitly.app`). Add the
   DNS records the provider shows: SPF, DKIM and a DMARC policy.
3. In Supabase: Authentication → Emails → SMTP Settings → enable custom
   SMTP. Enter host, port, user and password from the provider; sender name
   "Orbitly".
4. Authentication → Rate Limits: raise "emails per hour" to what the
   provider plan allows.
5. Test: sign in with a Gmail and an Outlook address. The code should arrive
   within a minute, not in spam, in the right language.

## 5. Backups and restore drill (owner)

- Pro plan: daily backups, kept for 7 days (Database → Backups).
- Point-in-time recovery is a paid add-on. Turn it on when losing up to a
  day of data is no longer acceptable.
- **Once a month:** restore the latest backup into a new project ("Restore
  to new project"), open it and run `test db --linked` against it, then
  delete it. A backup that was never restored is not known to work.
- If something goes wrong: stop writes (pause the app's release or put the
  project in read-only mode), restore to a new project, point the app at
  it, and write down what happened. If personal data leaked, the Latvian
  Data State Inspectorate must be told within 72 hours (GDPR art. 33).

## 6. Security checks

- Advisors → Security Advisor: no errors. Warnings are reviewed and
  explained.
- Database → Settings: SSL enforced.
- Only the **publishable** key goes into the app. The secret / service role
  key is never in the app or the repository. Orbitly does not need it at
  all: deletion and clean-up run in pg_cron inside the database.

## 7. Building the app against the cloud

Copy `env/example.json` to `env/staging.json` and `env/production.json`
(git-ignored) and fill in the project URL and publishable key. Then:

```bash
flutter build apk --release --dart-define-from-file=env/staging.json
flutter build appbundle --release --obfuscate --split-debug-info=build/symbols --dart-define-from-file=env/production.json
```

Keep `build/symbols` for every release: crash reports from obfuscated builds
can only be read with them. A release for the store also needs its own
signing key (`android/key.properties`, see `SECURITY.md`).

## 8. Done when

- Two phones on different networks can sign in and chat through staging.
- The code email arrives at Gmail and Outlook within a minute.
- `cron.job` lists all four jobs.
- Security Advisor shows no errors.
- One restore into a new project has worked.
