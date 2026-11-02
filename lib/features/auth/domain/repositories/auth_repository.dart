/// Sign-in with a one-time code from email, no passwords.
abstract interface class AuthRepository {
  /// Whether the user is signed in: the current state first, then changes.
  Stream<bool> watchSignedIn();

  Future<void> sendCode(String email);

  Future<void> verifyCode({required String email, required String code});

  Future<void> signOut();
}
