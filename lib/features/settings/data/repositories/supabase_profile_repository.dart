import 'package:orbitly/features/settings/domain/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileRepository implements ProfileRepository {
  const SupabaseProfileRepository(this._client);

  final SupabaseClient _client;

  /// Name and planet name change directly: RLS allows only my own row and
  /// the table checks the length.
  @override
  Future<void> rename({String? displayName, String? planetName}) => _client
      .from('profiles')
      .update({
        'display_name': ?displayName?.trim(),
        'planet_name': ?planetName?.trim(),
      })
      .eq('id', _client.auth.currentUser!.id);

  @override
  Future<HandleStatus> checkHandle(String handle) async {
    final status = await _client.rpc<String>(
      'check_handle',
      params: {'p_handle': handle},
    );
    return HandleStatus.values.asNameMap()[status] ?? HandleStatus.invalid;
  }

  @override
  Future<void> changeHandle(String handle) async {
    try {
      await _client.rpc<void>('change_handle', params: {'p_handle': handle});
    } on PostgrestException catch (e) {
      throw HandleChangeException(switch (e.code) {
        '55000' => HandleStatus.tooSoon,
        '23505' => HandleStatus.taken,
        _ => HandleStatus.invalid,
      });
    }
  }
}
