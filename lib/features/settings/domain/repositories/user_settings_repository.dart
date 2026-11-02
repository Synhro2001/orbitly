import 'package:orbitly/features/settings/domain/entities/user_settings.dart';

/// Account settings on the server.
abstract interface class UserSettingsRepository {
  Future<UserSettings> load();

  Future<void> save(UserSettings settings);
}
