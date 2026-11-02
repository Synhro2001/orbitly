/// What the live check says about a handle the user is typing.
enum HandleStatus { ok, invalid, taken, mine, tooSoon }

/// A handle change refused by the server, with the reason.
class HandleChangeException implements Exception {
  const HandleChangeException(this.status);

  final HandleStatus status;
}

/// My name, planet name and handle.
abstract interface class ProfileRepository {
  Future<void> rename({String? displayName, String? planetName});

  Future<HandleStatus> checkHandle(String handle);

  /// Throws [HandleChangeException] when the server refuses.
  Future<void> changeHandle(String handle);
}

/// The same rule as the database: 3–32 of a-z, 0-9, dot, underscore.
final handlePattern = RegExp(r'^[a-z0-9._]{3,32}$');

/// What the user typed, the way the server compares it.
String normalizeHandle(String input) =>
    input.trim().replaceFirst(RegExp('^@'), '').toLowerCase();
