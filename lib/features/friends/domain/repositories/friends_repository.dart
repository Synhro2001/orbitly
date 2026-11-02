import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';

abstract interface class FriendsRepository {
  /// Search by handle; an empty query gives an empty result.
  Future<List<UserSummary>> searchByHandle(String query);

  Future<void> sendRequest(String userId);

  Future<List<FriendRequest>> getIncomingRequests();

  Future<void> respondToRequest(String requestId, {required bool accept});

  Future<String> getInviteLink();
}
