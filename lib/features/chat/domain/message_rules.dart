/// Message limits. The client prevents breaking them and the server checks
/// again, because a client can be faked.
abstract final class MessageRules {
  /// Guards against huge messages that bloat the database and freeze the
  /// recipient's screen.
  static const maxLength = 1000;

  /// A capsule cannot be sent more than a year ahead.
  static const maxCapsuleDelay = Duration(days: 366);

  static bool isValid(String text) {
    final trimmed = text.trim();
    return trimmed.isNotEmpty && trimmed.length <= maxLength;
  }

  static bool isValidCapsuleDate(DateTime opensAt, {required DateTime now}) =>
      opensAt.isAfter(now) && !opensAt.isAfter(now.add(maxCapsuleDelay));
}
