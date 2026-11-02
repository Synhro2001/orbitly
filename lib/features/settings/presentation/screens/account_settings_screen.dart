import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/presentation/controllers/account_controller.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';

/// Account and data: email, sessions, data download, sign out, deletion.
class AccountSettingsScreen extends ConsumerWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final email = ref.watch(authRepositoryProvider).email;
    return SettingsPage(
      title: l10n.settingsAccount,
      children: [
        SettingsSection(
          children: [
            SettingsLink(
              key: const Key('account-email'),
              icon: Icons.alternate_email_rounded,
              title: l10n.accountEmail,
              subtitle: email,
              onTap: () => showDialog<void>(
                context: context,
                builder: (_) => const _ChangeEmailDialog(),
              ),
            ),
            SettingsLink(
              key: const Key('account-sign-out-others'),
              icon: Icons.devices_other_rounded,
              title: l10n.accountSignOutOthers,
              subtitle: l10n.accountSignOutOthersHint,
              onTap: () => _signOutOthers(context, ref),
            ),
          ],
        ),
        SettingsSection(
          children: [
            SettingsLink(
              key: const Key('account-export'),
              icon: Icons.download_rounded,
              title: l10n.accountExport,
              subtitle: l10n.accountExportHint,
              onTap: () => _export(context, ref),
            ),
          ],
        ),
        SettingsSection(
          children: [
            SettingsLink(
              key: const Key('sign-out'),
              icon: Icons.logout_rounded,
              title: l10n.settingsSignOut,
              onTap: () => _confirmSignOut(context, ref),
            ),
            SettingsLink(
              key: const Key('account-delete'),
              icon: Icons.delete_forever_outlined,
              color: AppColors.danger,
              title: l10n.accountDelete,
              onTap: () => context.push(AppRoutes.settingsDeleteAccount),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _signOutOthers(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    try {
      await ref.read(authRepositoryProvider).signOutOtherDevices();
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.accountSignedOutOthers)),
      );
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(l10n.settingsSaveFailed)));
    }
  }

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.accountExportFailed;
    try {
      await shareMyData(await ref.read(accountRepositoryProvider).exportData());
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(failed)));
    }
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsSignOutConfirm),
        content: Text(l10n.settingsSignOutBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              l10n.actionCancel,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.settingsSignOut),
          ),
        ],
      ),
    );
    // The router leaves for the login screen by itself (signedIn → false).
    if (confirmed ?? false) await ref.read(authRepositoryProvider).signOut();
  }
}

/// New email → code sent there → enter it.
class _ChangeEmailDialog extends ConsumerStatefulWidget {
  const _ChangeEmailDialog();

  @override
  ConsumerState<_ChangeEmailDialog> createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState extends ConsumerState<_ChangeEmailDialog> {
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final _email = TextEditingController();
  final _code = TextEditingController();
  bool _codeSent = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    final l10n = context.l10n;
    final auth = ref.read(authRepositoryProvider);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (!_codeSent) {
        if (!_emailPattern.hasMatch(_email.text.trim())) {
          setState(() => _error = l10n.loginInvalidEmail);
          return;
        }
        await auth.requestEmailChange(_email.text);
        setState(() => _codeSent = true);
      } else {
        await auth.confirmEmailChange(newEmail: _email.text, code: _code.text);
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.accountEmailChanged)));
        Navigator.pop(context);
      }
    } on Object {
      setState(
        () => _error = _codeSent ? l10n.loginInvalidCode : l10n.loginSendError,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.accountEmailChange),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('email-new'),
            controller: _email,
            enabled: !_codeSent,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: l10n.accountEmailNew),
          ),
          if (_codeSent) ...[
            const SizedBox(height: AppSpacing.s),
            Text(l10n.loginCodeSubtitle(_email.text.trim())),
            TextField(
              key: const Key('email-code'),
              controller: _code,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(hintText: l10n.loginCodeHint),
            ),
          ],
          if (_error case final error?)
            Text(error, style: const TextStyle(color: AppColors.danger)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            l10n.actionCancel,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        TextButton(
          key: const Key('email-next'),
          onPressed: _busy ? null : _next,
          child: Text(_codeSent ? l10n.loginVerify : l10n.loginSendCode),
        ),
      ],
    );
  }
}
