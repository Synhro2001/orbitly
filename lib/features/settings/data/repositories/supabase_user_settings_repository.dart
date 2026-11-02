import 'package:orbitly/features/settings/data/models/user_settings_model.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/domain/repositories/user_settings_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The `user_settings` row of the signed-in user (RLS: only your own).
class SupabaseUserSettingsRepository implements UserSettingsRepository {
  const SupabaseUserSettingsRepository(this._client);

  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  @override
  Future<UserSettings> load() async {
    final row = await _client
        .from('user_settings')
        .select()
        .eq('user_id', _userId)
        .single();
    return UserSettingsModel.fromJson(row).toEntity();
  }

  @override
  Future<void> save(UserSettings settings) => _client
      .from('user_settings')
      .update(UserSettingsModel.fromEntity(settings).toJson())
      .eq('user_id', _userId);
}
