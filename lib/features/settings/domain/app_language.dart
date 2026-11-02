/// The app language the user picked. [system] follows the phone.
enum AppLanguage {
  system(null),
  russian('ru'),
  english('en');

  AppLanguage(this.code);

  /// Language code, or null for "same as the phone".
  final String? code;

  /// A stored code back to a language; anything unknown means [system].
  static AppLanguage fromCode(String? code) => values.firstWhere(
    (language) => code != null && language.code == code,
    orElse: () => system,
  );
}

/// English is shown when the phone has none of the app's languages.
const fallbackLanguage = 'en';

/// The language to show for the phone's languages ([preferred], most wanted
/// first): the first one the app has, otherwise [fallbackLanguage].
String resolveLanguage(Iterable<String> preferred, Set<String> supported) =>
    preferred.firstWhere(supported.contains, orElse: () => fallbackLanguage);
