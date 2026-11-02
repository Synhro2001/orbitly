import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/app/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.freezed.dart';
part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
Stream<bool> signedIn(Ref ref) =>
    ref.watch(authRepositoryProvider).watchSignedIn().distinct();

enum LoginError { invalidEmail, invalidCode, sendFailed }

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default(false) bool codeSent,
    @Default(false) bool isBusy,
    LoginError? error,
  }) = _LoginState;
}

@riverpod
class LoginController extends _$LoginController {
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static const codeLength = 6;

  @override
  LoginState build() => const LoginState();

  Future<void> sendCode(String email) async {
    final trimmed = email.trim();
    if (!_email.hasMatch(trimmed)) {
      state = state.copyWith(error: LoginError.invalidEmail);
      return;
    }
    state = state.copyWith(email: trimmed, isBusy: true, error: null);
    try {
      await ref.read(authRepositoryProvider).sendCode(trimmed);
      if (ref.mounted) state = state.copyWith(codeSent: true, isBusy: false);
    } on Object {
      if (ref.mounted) {
        state = state.copyWith(isBusy: false, error: LoginError.sendFailed);
      }
    }
  }

  /// После успеха роутер сам уведёт с экрана входа (signedIn → true).
  Future<void> verify(String code) async {
    final trimmed = code.trim();
    if (trimmed.length != codeLength) {
      state = state.copyWith(error: LoginError.invalidCode);
      return;
    }
    state = state.copyWith(isBusy: true, error: null);
    try {
      await ref
          .read(authRepositoryProvider)
          .verifyCode(email: state.email, code: trimmed);
    } on Object {
      if (ref.mounted) {
        state = state.copyWith(isBusy: false, error: LoginError.invalidCode);
      }
    }
  }

  void changeEmail() => state = const LoginState();
}
