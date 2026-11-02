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
}
