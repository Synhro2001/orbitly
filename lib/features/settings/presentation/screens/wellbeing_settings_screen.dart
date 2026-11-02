import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/env.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';

/// Closeness without pressure: shadow, streaks without counters, a soft
/// daily reminder.
class WellbeingSettingsScreen extends ConsumerWidget {
  const WellbeingSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return UserSettingsPage(
      title: l10n.settingsWellbeing,
      builder: (s) => [
        SettingsLink(
          key: const Key('wellbeing-shadow'),
          icon: Icons.dark_mode_outlined,
          title: l10n.planetShadowTitle,
          subtitle: l10n.wellbeingShadowHint,
          onTap: () => context.go(AppRoutes.planet),
        ),
        SettingsSwitch(
          key: const Key('wellbeing-hide-streaks'),
          title: l10n.wellbeingHideStreaks,
          subtitle: l10n.wellbeingHideStreaksHint,
          value: s.hideStreaks,
          onChanged: (v) =>
              applySetting(context, ref, (s) => s.copyWith(hideStreaks: v)),
        ),
        SettingsChoice<int?>(
          key: const Key('wellbeing-limit'),
          title: l10n.wellbeingLimit,
          subtitle: l10n.wellbeingLimitHint,
          value: s.dailyLimitMinutes,
          options: const [null, ...UserSettings.dailyLimitChoices],
          label: (v) => v == null ? l10n.wellbeingLimitOff : l10n.minutes(v),
          onChanged: (v) => applySetting(
            context,
            ref,
            (s) => s.copyWith(dailyLimitMinutes: v),
          ),
        ),
        if (Env.notificationsEnabled)
          SettingsLink(
            icon: Icons.bedtime_outlined,
            title: l10n.notificationsQuietHours,
            onTap: () => context.push(AppRoutes.settingsNotifications),
          ),
      ],
    );
  }
}
