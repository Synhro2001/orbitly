import 'package:orbitly/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements AuthRepository {
  const SupabaseAuthRepository(this._auth);

  final GoTrueClient _auth;

  @override
  Stream<bool> watchSignedIn() async* {
    yield _auth.currentSession != null;
    yield* _auth.onAuthStateChange.map((state) => state.session != null);
  }

  /// The email template sends a 6-digit code ({{ .Token }}), not a link.
  /// `data` becomes the metadata of a new account; the template picks the
  /// email language from `.Data.locale`.
  @override
  Future<void> sendCode(String email, {required String language}) =>
      _auth.signInWithOtp(email: email, data: {_localeKey: language});

  @override
  Future<void> verifyCode({required String email, required String code}) =>
      _auth.verifyOTP(email: email, token: code, type: OtpType.email);

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> signOutOtherDevices() =>
      _auth.signOut(scope: SignOutScope.others);

  /// Kept in the account metadata, where the email template reads it.
  @override
  Future<void> saveLanguage(String language) async {
    if (_auth.currentUser?.userMetadata?[_localeKey] == language) return;
    await _auth.updateUser(UserAttributes(data: {_localeKey: language}));
  }

  @override
  String? get email => _auth.currentUser?.email;

  /// The server sends a code to the new address only
  /// (double_confirm_changes = false in config.toml).
  @override
  Future<void> requestEmailChange(String newEmail) =>
      _auth.updateUser(UserAttributes(email: newEmail.trim()));

  @override
  Future<void> confirmEmailChange({
    required String newEmail,
    required String code,
  }) => _auth.verifyOTP(
    email: newEmail.trim(),
    token: code.trim(),
    type: OtpType.emailChange,
  );

  @override
  Future<void> sendCodeToMe() =>
      _auth.signInWithOtp(email: email, shouldCreateUser: false);

  @override
  Future<void> verifyCodeFromMe(String code) =>
      _auth.verifyOTP(email: email, token: code.trim(), type: OtpType.email);

  static const _localeKey = 'locale';
}
