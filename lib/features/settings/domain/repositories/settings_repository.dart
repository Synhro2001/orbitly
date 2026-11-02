import 'package:orbitly/features/settings/domain/app_language.dart';

/// Settings that live on this phone.
abstract interface class SettingsRepository {
  AppLanguage get language;

  Future<void> setLanguage(AppLanguage language);
}
