import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/features/settings/domain/entities/device_settings.dart';

/// Settings that live on this phone.
abstract interface class SettingsRepository {
  AppLanguage get language;

  Future<void> setLanguage(AppLanguage language);

  DeviceSettings get device;

  Future<void> saveDevice(DeviceSettings settings);

  DailyUsage get usage;

  Future<void> saveUsage(DailyUsage usage);
}
