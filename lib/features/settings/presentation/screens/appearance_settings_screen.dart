import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/features/settings/domain/entities/device_settings.dart';
import 'package:orbitly/features/settings/presentation/controllers/device_settings_controller.dart';
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
    final device = ref.watch(deviceSettingsControllerProvider);
    final devices = ref.read(deviceSettingsControllerProvider.notifier);
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
        SettingsSection(
          children: [
            SettingsSwitch(
              key: const Key('appearance-haptics'),
              title: l10n.appearanceHaptics,
              value: device.haptics,
              onChanged: (v) =>
                  unawaited(devices.change((d) => d.copyWith(haptics: v))),
            ),
            SettingsChoice<MotionPreference>(
              key: const Key('appearance-motion'),
              title: l10n.appearanceMotion,
              value: device.motion,
              options: MotionPreference.values,
              label: (v) => switch (v) {
                MotionPreference.system => l10n.appearanceMotionSystem,
                MotionPreference.reduced => l10n.appearanceMotionReduced,
              },
              onChanged: (v) =>
                  unawaited(devices.change((d) => d.copyWith(motion: v))),
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
