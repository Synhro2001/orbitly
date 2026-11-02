import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/auth/presentation/controllers/auth_controller.dart';

/// Вход по коду из письма: email → 6 цифр. Паролей нет.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _code = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  String? _errorText(LoginError? error) => switch (error) {
    LoginError.invalidEmail => context.l10n.loginInvalidEmail,
    LoginError.invalidCode => context.l10n.loginInvalidCode,
    LoginError.sendFailed => context.l10n.loginSendError,
    null => null,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    return Scaffold(
      body: StarfieldBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              const SizedBox(height: AppSpacing.xxl),
              Text(
                state.codeSent ? l10n.loginCodeTitle : l10n.loginTitle,
                style: textTheme.displaySmall,
              ),
              const SizedBox(height: AppSpacing.s),
              Text(
                state.codeSent
                    ? l10n.loginCodeSubtitle(state.email)
                    : l10n.loginSubtitle,
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xl),
              if (!state.codeSent)
                TextField(
                  key: const Key('login-email'),
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.send,
                  onSubmitted: controller.sendCode,
                  decoration: InputDecoration(
                    hintText: l10n.loginEmailHint,
                    errorText: _errorText(state.error),
                  ),
                )
              else
                TextField(
                  key: const Key('login-code'),
                  controller: _code,
                  keyboardType: TextInputType.number,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  maxLength: LoginController.codeLength,
                  textInputAction: TextInputAction.done,
                  onSubmitted: controller.verify,
                  decoration: InputDecoration(
                    hintText: l10n.loginCodeHint,
                    counterText: '',
                    errorText: _errorText(state.error),
                  ),
                ),
              const SizedBox(height: AppSpacing.l),
              FilledButton(
                onPressed: state.isBusy
                    ? null
                    : () => state.codeSent
                          ? controller.verify(_code.text)
                          : controller.sendCode(_email.text),
                child: state.isBusy
                    ? const SizedBox.square(
                        dimension: AppSpacing.l,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        state.codeSent ? l10n.loginVerify : l10n.loginSendCode,
                      ),
              ),
              if (state.codeSent)
                TextButton(
                  onPressed: state.isBusy
                      ? null
                      : () {
                          _code.clear();
                          controller.changeEmail();
                        },
                  child: Text(
                    l10n.loginChangeEmail,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
