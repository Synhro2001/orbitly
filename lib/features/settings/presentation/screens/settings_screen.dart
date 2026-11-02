import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/features/settings/presentation/controllers/language_controller.dart';
import 'package:orbitly/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final language = ref.watch(languageControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      extendBodyBehindAppBar: true,
      body: StarfieldBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.l),
            children: [
              Text(l10n.settingsLanguage, style: textTheme.titleMedium),
              RadioGroup<AppLanguage>(
                groupValue: language,
                onChanged: (picked) {
                  if (picked != null) {
                    unawaited(
                      ref
                          .read(languageControllerProvider.notifier)
                          .select(picked),
                    );
                  }
                },
                child: Column(
                  children: [
                    for (final option in AppLanguage.values)
                      RadioListTile<AppLanguage>(
                        key: Key('language-${option.name}'),
                        value: option,
                        title: Text(_languageName(option, l10n)),
                        contentPadding: EdgeInsets.zero,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(l10n.settingsAccount, style: textTheme.titleMedium),
              ListTile(
                key: const Key('sign-out'),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout_rounded),
                title: Text(l10n.settingsSignOut),
                onTap: () => _confirmSignOut(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Each language is named in itself, so it can be found even when the
  /// screen is in a language the user does not read.
  static String _languageName(AppLanguage language, AppLocalizations l10n) =>
      switch (language) {
        AppLanguage.system => l10n.settingsLanguageSystem,
        AppLanguage.russian => 'Русский',
        AppLanguage.english => 'English',
      };

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
