import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/features/settings/domain/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Settings in SharedPreferences. Read once at start-up, so the first frame
/// is already in the right language.
class PrefsSettingsRepository implements SettingsRepository {
  PrefsSettingsRepository._(this._prefs);

  static const _languageKey = 'language';

  static Future<PrefsSettingsRepository> open() async =>
      PrefsSettingsRepository._(
        await SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
            allowList: {_languageKey},
          ),
        ),
      );

  final SharedPreferencesWithCache _prefs;

  @override
  AppLanguage get language =>
      AppLanguage.fromCode(_prefs.getString(_languageKey));

  @override
  Future<void> setLanguage(AppLanguage language) => switch (language.code) {
    final code? => _prefs.setString(_languageKey, code),
    null => _prefs.remove(_languageKey),
  };
}
