/// Sign-in with a one-time code from email, no passwords.
abstract interface class AuthRepository {
  /// Whether the user is signed in: the current state first, then changes.
  Stream<bool> watchSignedIn();

  /// [language] is the app language: a new account gets its first email
  /// in it.
  Future<void> sendCode(String email, {required String language});

  Future<void> verifyCode({required String email, required String code});

  Future<void> signOut();

  /// Remembers the app language on the account (for sign-in emails).
  Future<void> saveLanguage(String language);
}
