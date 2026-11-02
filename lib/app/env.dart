/// Build settings, passed with `--dart-define`.
///
/// Only the project URL and the publishable key ship with the app. The
/// secret key (service role / sb_secret) never does.
abstract final class Env {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  /// Mocks are for tests and running offline. On by default when no
  /// Supabase URL is given.
  static const useMocks = bool.fromEnvironment(
    'USE_MOCKS',
    defaultValue: supabaseUrl == '',
  );

  /// A Supabase started with `supabase start` on this computer. It never
  /// sends real email: sign-in codes land in its Mailpit inbox instead.
  static final bool isLocalSupabase = RegExp(
    r'^https?://(10\.0\.2\.2|127\.0\.0\.1|localhost)(:|/|$)',
  ).hasMatch(supabaseUrl);
}
