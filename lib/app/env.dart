/// Настройки сборки, передаются через `--dart-define`.
///
/// В приложение попадают только адрес проекта и публичный (publishable)
/// ключ. Секретный ключ (service role / sb_secret) — никогда.
abstract final class Env {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  /// Моки — для тестов и запуска без сети. Включены по умолчанию, если
  /// адрес Supabase не задан.
  static const useMocks = bool.fromEnvironment(
    'USE_MOCKS',
    defaultValue: supabaseUrl == '',
  );
}
