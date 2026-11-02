import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/core/data/supabase/rpc_rows.dart';
import 'package:orbitly/features/friends/data/models/friends_models.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/domain/friend_search_rules.dart';
import 'package:orbitly/features/friends/domain/repositories/friends_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Requests and search go through server functions: other profiles are
/// closed by RLS. A request id is the id of the user who sent it.
class SupabaseFriendsRepository implements FriendsRepository {
  const SupabaseFriendsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<UserSummary>> searchByHandle(String query) async {
    final q = query.trim().replaceFirst('@', '');
    if (q.isEmpty || q.length > FriendSearchRules.maxQueryLength) {
      return const [];
    }
    final rows = await _client.rpcRows(
      'search_profiles',
      params: {'p_query': q},
    );
    return parseValid(rows, userSummaryFromRow);
  }

  @override
  Future<void> sendRequest(String userId) =>
      _client.rpc<void>('send_friend_request', params: {'p_user': userId});

  @override
  Future<List<FriendRequest>> getIncomingRequests() async {
    return parseValid(
      await _client.rpcRows('get_incoming_requests'),
      (row) => FriendRequestModel.fromJson({
        'id': row['user_id'],
        'user': {
          'id': row['user_id'],
          'name': row['display_name'],
          'handle': row['handle'],
          'appearance': row['appearance'],
        },
        'sent_at': row['created_at'],
      }).toEntity(),
    );
  }

  @override
  Future<void> respondToRequest(String requestId, {required bool accept}) =>
      _client.rpc<void>(
        'respond_friend_request',
        params: {'p_user': requestId, 'p_accept': accept},
      );

  /// The link carries a random code, not the handle: it can be renewed,
  /// and it does not reveal who I am to someone who only sees the link.
  @override
  Future<String> getInviteLink() async =>
      inviteLinkFor(await _client.rpc<String>('get_my_invite_code'));

  @override
  Future<String> renewInviteLink() async =>
      inviteLinkFor(await _client.rpc<String>('rotate_invite_code'));

  @override
  Future<UserSummary?> getInvite(String code) async {
    final rows = await _client.rpcRows('get_invite', params: {'p_code': code});
    return parseValid(rows, userSummaryFromRow).firstOrNull;
  }

  @override
  Future<void> sendRequestByInvite(String code) => _client.rpc<void>(
    'send_friend_request_by_invite',
    params: {'p_code': code},
  );
}
