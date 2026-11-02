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

  /// Kept in the account metadata, where the email template reads it.
  @override
  Future<void> saveLanguage(String language) async {
    if (_auth.currentUser?.userMetadata?[_localeKey] == language) return;
    await _auth.updateUser(UserAttributes(data: {_localeKey: language}));
  }

  static const _localeKey = 'locale';
}
