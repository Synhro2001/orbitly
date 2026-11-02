import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/data/models/user_settings_model.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/domain/repositories/user_settings_repository.dart';

/// Settings kept in the mock store as JSON, the way Supabase returns them.
class MockUserSettingsRepository implements UserSettingsRepository {
  const MockUserSettingsRepository(this._store);

  final MockStore _store;

  @override
  Future<UserSettings> load() async {
    await _store.delay();
    return UserSettingsModel.fromJson(_store.settings).toEntity();
  }

  @override
  Future<void> save(UserSettings settings) async {
    await _store.delay();
    _store.settings = UserSettingsModel.fromEntity(settings).toJson();
  }
}
