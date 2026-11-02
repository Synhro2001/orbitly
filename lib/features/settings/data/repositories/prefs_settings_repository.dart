import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/features/settings/domain/entities/device_settings.dart';
import 'package:orbitly/features/settings/domain/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Settings in SharedPreferences. Read once at start-up, so the first frame
/// is already in the right language and with the right motion.
class PrefsSettingsRepository implements SettingsRepository {
  PrefsSettingsRepository._(this._prefs);

  static const _languageKey = 'language';
  static const _hapticsKey = 'haptics';
  static const _motionKey = 'motion';
  static const _mediaAutoloadKey = 'media_autoload';
  static const _dataSaverKey = 'data_saver';
  static const _usageDayKey = 'usage_day';
  static const _usageMinutesKey = 'usage_minutes';
  static const _usageRemindedKey = 'usage_reminded';

  static Future<PrefsSettingsRepository> open() async =>
      PrefsSettingsRepository._(
        await SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
            allowList: {
              _languageKey,
              _hapticsKey,
              _motionKey,
              _mediaAutoloadKey,
              _dataSaverKey,
              _usageDayKey,
              _usageMinutesKey,
              _usageRemindedKey,
            },
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

  @override
  DeviceSettings get device {
    const defaults = DeviceSettings();
    return DeviceSettings(
      haptics: _prefs.getBool(_hapticsKey) ?? defaults.haptics,
      motion:
          MotionPreference.values.asNameMap()[_prefs.getString(_motionKey)] ??
          defaults.motion,
      mediaAutoload:
          MediaAutoload.values.asNameMap()[_prefs.getString(
            _mediaAutoloadKey,
          )] ??
          defaults.mediaAutoload,
      dataSaver: _prefs.getBool(_dataSaverKey) ?? defaults.dataSaver,
    );
  }

  @override
  Future<void> saveDevice(DeviceSettings settings) async {
    await _prefs.setBool(_hapticsKey, settings.haptics);
    await _prefs.setString(_motionKey, settings.motion.name);
    await _prefs.setString(_mediaAutoloadKey, settings.mediaAutoload.name);
    await _prefs.setBool(_dataSaverKey, settings.dataSaver);
  }

  @override
  DailyUsage get usage => DailyUsage(
    day: _prefs.getString(_usageDayKey) ?? '',
    minutes: _prefs.getInt(_usageMinutesKey) ?? 0,
    reminded: _prefs.getBool(_usageRemindedKey) ?? false,
  );

  @override
  Future<void> saveUsage(DailyUsage usage) async {
    await _prefs.setString(_usageDayKey, usage.day);
    await _prefs.setInt(_usageMinutesKey, usage.minutes);
    await _prefs.setBool(_usageRemindedKey, usage.reminded);
  }
}
