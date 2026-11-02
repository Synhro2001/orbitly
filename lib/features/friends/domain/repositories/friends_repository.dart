import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';

abstract interface class FriendsRepository {
  /// Search by handle; an empty query gives an empty result.
  Future<List<UserSummary>> searchByHandle(String query);

  Future<void> sendRequest(String userId);

  Future<List<FriendRequest>> getIncomingRequests();

  Future<void> respondToRequest(String requestId, {required bool accept});

  Future<String> getInviteLink();

  /// A new link; the old link and QR code stop working.
  Future<String> renewInviteLink();

  /// Who invites with [code]; null if the code is unknown or old.
  Future<UserSummary?> getInvite(String code);

  /// A request through someone's invite: allowed whatever their settings.
  Future<void> sendRequestByInvite(String code);
}

/// The link that opens an invite in the app.
String inviteLinkFor(String code) => 'https://orbitly.app/invite/$code';
