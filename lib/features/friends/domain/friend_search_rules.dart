abstract final class FriendSearchRules {
  /// Handles are at most 32 characters: a longer query finds nothing, and
  /// the server does not need to process junk.
  static const maxQueryLength = 32;
}
