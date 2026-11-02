import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/core/data/supabase/rpc_rows.dart';
import 'package:orbitly/features/friends/data/models/friends_models.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/domain/repositories/safety_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSafetyRepository implements SafetyRepository {
  const SupabaseSafetyRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<void> block(String userId) =>
      _client.rpc<void>('block_user', params: {'p_user': userId});

  @override
  Future<void> unblock(String userId) =>
      _client.rpc<void>('unblock_user', params: {'p_user': userId});

  @override
  Future<List<UserSummary>> getBlocked() async =>
      _users(await _client.rpcRows('get_blocked'));

  @override
  Future<void> mute(String friendId) =>
      _client.rpc<void>('mute_friend', params: {'p_friend': friendId});

  @override
  Future<void> unmute(String friendId) =>
      _client.rpc<void>('unmute_friend', params: {'p_friend': friendId});

  @override
  Future<List<UserSummary>> getMuted() async =>
      _users(await _client.rpcRows('get_muted'));

  @override
  Future<void> report(String userId, ReportReason reason, {String? details}) =>
      _client.rpc<void>(
        'report_user',
        params: {
          'p_user': userId,
          'p_reason': reason.name,
          'p_details': details,
        },
      );

  List<UserSummary> _users(List<Map<String, dynamic>> rows) =>
      parseValid(rows, userSummaryFromRow);
}
