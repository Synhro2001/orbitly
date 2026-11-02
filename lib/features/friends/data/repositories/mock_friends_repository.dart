import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/features/friends/data/models/friends_models.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/domain/friend_search_rules.dart';
import 'package:orbitly/features/friends/domain/repositories/friends_repository.dart';

class MockFriendsRepository implements FriendsRepository {
  const MockFriendsRepository(this._store);

  final MockStore _store;

  @override
  Future<List<UserSummary>> searchByHandle(String query) async {
    final q = query.trim().toLowerCase().replaceFirst('@', '');
    if (q.length > FriendSearchRules.maxQueryLength) return const [];
    if (q.isEmpty) return const [];
    await _store.delay();
    return parseValid(
      _store.directory.where((json) => '${json['handle']}'.contains(q)),
      (json) => UserSummaryModel.fromJson(json).toEntity(),
    );
  }

  @override
  Future<void> sendRequest(String userId) => _store.delay();

  @override
  Future<List<FriendRequest>> getIncomingRequests() async {
    await _store.delay();
    return parseValid(
      _store.incomingRequests,
      (json) => FriendRequestModel.fromJson(json).toEntity(),
    );
  }

  @override
  Future<void> respondToRequest(
    String requestId, {
    required bool accept,
  }) async {
    await _store.delay();
    final request = _store.incomingRequests.firstWhere(
      (r) => r['id'] == requestId,
    );
    _store.incomingRequests.remove(request);
    if (!accept) return;
    final user = request['user']! as Json;
    // A new friend appears on the outermost orbit.
    _store.friends.add({
      ...user,
      'closeness': 5,
      'streak_days': 0,
      'last_exchange_at': DateTime.now().toIso8601String(),
      'mood': 'happy',
    });
    _store.messages[user['id']! as String] = [];
  }

  @override
  Future<String> getInviteLink() async {
    await _store.delay();
    return 'https://orbitly.app/invite/${_store.myPlanet?['handle'] ?? 'me'}';
  }
}
