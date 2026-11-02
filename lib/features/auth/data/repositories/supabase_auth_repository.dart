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
  @override
  Future<void> sendCode(String email) => _auth.signInWithOtp(email: email);

  @override
  Future<void> verifyCode({required String email, required String code}) =>
      _auth.verifyOTP(email: email, token: code, type: OtpType.email);

  @override
  Future<void> signOut() => _auth.signOut();
}
