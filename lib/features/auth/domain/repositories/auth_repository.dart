/// Sign-in with a one-time code from email, no passwords.
abstract interface class AuthRepository {
  /// Whether the user is signed in: the current state first, then changes.
  Stream<bool> watchSignedIn();

  /// [language] is the app language: a new account gets its first email
  /// in it.
  Future<void> sendCode(String email, {required String language});

  Future<void> verifyCode({required String email, required String code});

  Future<void> signOut();

  /// Signs out every other phone and browser; this one stays signed in.
  Future<void> signOutOtherDevices();

  /// Remembers the app language on the account (for sign-in emails).
  Future<void> saveLanguage(String language);

  /// The signed-in account's email.
  String? get email;

  /// Sends a code to [newEmail]; the change happens on [confirmEmailChange].
  Future<void> requestEmailChange(String newEmail);

  Future<void> confirmEmailChange({
    required String newEmail,
    required String code,
  });

  /// A fresh code to my own email, to confirm a serious step (deletion).
  Future<void> sendCodeToMe();

  /// Signs in again with that code: the session becomes "just verified".
  Future<void> verifyCodeFromMe(String code);
}
