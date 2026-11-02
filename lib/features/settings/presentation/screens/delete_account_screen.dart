import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';

enum _Step { info, code, done }

/// Deleting the account in three steps: what happens → code from email →
/// done. Also opened in the web build at /delete-account, so the account
/// can be deleted without installing the app (Google Play requirement).
class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() =>
      _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  final _code = TextEditingController();
  _Step _step = _Step.info;
  bool _busy = false;
  String? _error;
  late DateTime _deletesOn;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action, String failure) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on Object {
      if (mounted) setState(() => _error = failure);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _sendCode() => _run(() async {
    await ref.read(authRepositoryProvider).sendCodeToMe();
    setState(() => _step = _Step.code);
  }, context.l10n.loginSendError);

  Future<void> _confirm() => _run(() async {
    await ref.read(authRepositoryProvider).verifyCodeFromMe(_code.text);
    final date = await ref.read(accountRepositoryProvider).requestDeletion();
    setState(() {
      _deletesOn = date;
      _step = _Step.done;
    });
  }, context.l10n.loginInvalidCode);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return SettingsPage(
      title: l10n.accountDelete,
      children: switch (_step) {
        _Step.info => [
          Text(l10n.deleteWhat, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.s),
          for (final line in [
            l10n.deleteWhatProfile,
            l10n.deleteWhatMessages,
            l10n.deleteWhatFriends,
            l10n.deleteWhatTrophies,
            l10n.deleteWhatGrace,
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s),
              child: Text('• $line', style: textTheme.bodyMedium),
            ),
          const SizedBox(height: AppSpacing.m),
          Text(l10n.deleteExportFirst, style: textTheme.bodySmall),
          const SizedBox(height: AppSpacing.l),
          FilledButton(
            key: const Key('delete-start'),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: _busy ? null : _sendCode,
            child: Text(l10n.deleteSendCode),
          ),
          ?_errorText(),
        ],
        _Step.code => [
          Text(
            l10n.loginCodeSubtitle(
              ref.read(authRepositoryProvider).email ?? '',
            ),
            style: textTheme.bodyMedium,
          ),
          TextField(
            key: const Key('delete-code'),
            controller: _code,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(hintText: l10n.loginCodeHint),
          ),
          const SizedBox(height: AppSpacing.s),
          FilledButton(
            key: const Key('delete-confirm'),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: _busy ? null : _confirm,
            child: Text(l10n.deleteConfirm),
          ),
          ?_errorText(),
        ],
        _Step.done => [
          Text(
            l10n.deleteDone(_deletesOn),
            key: const Key('delete-done'),
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.l),
          FilledButton(
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
            child: Text(l10n.deleteDoneOk),
          ),
        ],
      },
    );
  }

  Widget? _errorText() => _error == null
      ? null
      : Padding(
          padding: const EdgeInsets.only(top: AppSpacing.s),
          child: Text(_error!, style: const TextStyle(color: AppColors.danger)),
        );
}
