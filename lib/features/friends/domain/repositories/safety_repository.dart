import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';

/// Why someone is reported. The values are stored as they are.
enum ReportReason {
  spam,
  harassment,
  inappropriate,
  impersonation,
  underage,
  other,
}

/// Block, quiet orbit and reports.
abstract interface class SafetyRepository {
  /// Hides us from each other everywhere and ends the friendship.
  Future<void> block(String userId);

  /// Does not bring the friendship back: a new request is needed.
  Future<void> unblock(String userId);

  Future<List<UserSummary>> getBlocked();

  /// No notifications and no glow from this friend. They are not told.
  Future<void> mute(String friendId);

  Future<void> unmute(String friendId);

  Future<List<UserSummary>> getMuted();

  Future<void> report(String userId, ReportReason reason, {String? details});
}
