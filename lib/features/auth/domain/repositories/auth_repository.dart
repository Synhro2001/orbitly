/// Вход по одноразовому коду из письма — без паролей.
abstract interface class AuthRepository {
  /// Вошёл ли пользователь; сразу отдаёт текущее состояние, потом изменения.
  Stream<bool> watchSignedIn();

  Future<void> sendCode(String email);

  Future<void> verifyCode({required String email, required String code});

  Future<void> signOut();
}
