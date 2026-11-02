import 'package:orbitly/features/auth/domain/repositories/auth_repository.dart';

/// In mock mode the user is already signed in.
class MockAuthRepository implements AuthRepository {
  const MockAuthRepository();

  @override
  Stream<bool> watchSignedIn() => Stream.value(true);

  @override
  Future<void> sendCode(String email) async {}

  @override
  Future<void> verifyCode({
    required String email,
    required String code,
  }) async {}

  @override
  Future<void> signOut() async {}
}
