import 'package:orbitly/features/auth/domain/repositories/auth_repository.dart';

/// In mock mode the user is already signed in. Any 6-digit code works.
class MockAuthRepository implements AuthRepository {
  const MockAuthRepository();

  @override
  Stream<bool> watchSignedIn() => Stream.value(true);

  @override
  Future<void> sendCode(String email, {required String language}) async {}

  @override
  Future<void> verifyCode({
    required String email,
    required String code,
  }) async {}

  @override
  Future<void> signOut() async {}

  @override
  Future<void> signOutOtherDevices() async {}

  @override
  Future<void> saveLanguage(String language) async {}

  @override
  String? get email => 'me@orbitly.test';

  @override
  Future<void> requestEmailChange(String newEmail) async {}

  @override
  Future<void> confirmEmailChange({
    required String newEmail,
    required String code,
  }) async {}

  @override
  Future<void> sendCodeToMe() async {}

  @override
  Future<void> verifyCodeFromMe(String code) async {}
}
