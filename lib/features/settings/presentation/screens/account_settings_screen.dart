import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';

/// Account and data: email, sessions, data export, deletion.
class AccountSettingsScreen extends ConsumerWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SettingsPage(
      title: l10n.settingsAccount,
      children: [
        SettingsLink(
          key: const Key('sign-out'),
          icon: Icons.logout_rounded,
          title: l10n.settingsSignOut,
          onTap: () => _confirmSignOut(context, ref),
        ),
      ],
    );
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
