import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/friends/data/models/friends_models.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/domain/repositories/friends_repository.dart';

class MockFriendsRepository implements FriendsRepository {
  const MockFriendsRepository(this._store);

  final MockStore _store;

  @override
  Future<List<UserSummary>> searchByHandle(String query) async {
    final q = query.trim().toLowerCase().replaceFirst('@', '');
    if (q.isEmpty) return const [];
    await _store.delay();
    return [
      for (final json in _store.directory)
        if ((json['handle']! as String).contains(q))
          UserSummaryModel.fromJson(json).toEntity(),
    ];
  }

  @override
  Future<void> sendRequest(String userId) => _store.delay();

  @override
  Future<List<FriendRequest>> getIncomingRequests() async {
    await _store.delay();
    return [
      for (final json in _store.incomingRequests)
        FriendRequestModel.fromJson(json).toEntity(),
    ];
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
    // Новый друг появляется на дальней орбите.
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
