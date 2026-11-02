import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/features/settings/domain/repositories/settings_repository.dart';

/// Settings that last until the app closes. For tests.
class InMemorySettingsRepository implements SettingsRepository {
  InMemorySettingsRepository([this._language = AppLanguage.system]);

  AppLanguage _language;

  @override
  AppLanguage get language => _language;

  @override
  Future<void> setLanguage(AppLanguage language) async => _language = language;
}
