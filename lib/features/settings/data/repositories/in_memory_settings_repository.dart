import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/features/settings/domain/entities/device_settings.dart';
import 'package:orbitly/features/settings/domain/repositories/settings_repository.dart';

/// Settings that last until the app closes. For tests.
class InMemorySettingsRepository implements SettingsRepository {
  InMemorySettingsRepository([this._language = AppLanguage.system]);

  AppLanguage _language;

  @override
  AppLanguage get language => _language;

  @override
  Future<void> setLanguage(AppLanguage language) async => _language = language;

  @override
  DeviceSettings device = const DeviceSettings();

  @override
  Future<void> saveDevice(DeviceSettings settings) async => device = settings;

  @override
  DailyUsage usage = const DailyUsage();

  @override
  Future<void> saveUsage(DailyUsage usage) async => this.usage = usage;
}
