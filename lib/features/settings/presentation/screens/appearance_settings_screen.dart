import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/features/settings/presentation/controllers/language_controller.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';
import 'package:orbitly/l10n/app_localizations.dart';

/// Appearance and accessibility: settings of this phone only.
class AppearanceSettingsScreen extends ConsumerWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final language = ref.watch(languageControllerProvider);
    return SettingsPage(
      title: l10n.settingsAppearance,
      children: [
        SettingsSection(
          title: l10n.settingsLanguage,
          children: [
            RadioGroup<AppLanguage>(
              groupValue: language,
              onChanged: (picked) {
                if (picked == null) return;
                unawaited(
                  ref.read(languageControllerProvider.notifier).select(picked),
                );
              },
              child: Column(
                children: [
                  for (final option in AppLanguage.values)
                    RadioListTile<AppLanguage>(
                      key: Key('language-${option.name}'),
                      value: option,
                      title: Text(languageName(option, l10n)),
                      contentPadding: EdgeInsets.zero,
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Each language is named in itself, so it can be found even when the
/// screen is in a language the user does not read.
String languageName(AppLanguage language, AppLocalizations l10n) =>
    switch (language) {
      AppLanguage.system => l10n.settingsLanguageSystem,
      AppLanguage.russian => 'Русский',
      AppLanguage.english => 'English',
    };
