import 'package:orbitly/features/settings/domain/repositories/account_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAccountRepository implements AccountRepository {
  const SupabaseAccountRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<DateTime> requestDeletion() async =>
      DateTime.parse(await _client.rpc<String>('request_account_deletion'))
          .toLocal();

  @override
  Future<bool> cancelDeletion() => _client.rpc<bool>('cancel_account_deletion');

  @override
  Future<Map<String, Object?>> exportData() =>
      _client.rpc<Map<String, Object?>>('export_my_data');
}
