import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';

/// What to be notified about, how much of it to show, quiet hours. Push
/// delivery reads these settings on the server; until it exists, the screen
/// is hidden (Env.notificationsEnabled).
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    void apply(UserSettings Function(UserSettings s) update) =>
        applySetting(context, ref, update);

    return UserSettingsPage(
      title: l10n.settingsNotifications,
      builder: (s) => [
        SettingsSection(
          title: l10n.notificationsWhat,
          children: [
            SettingsSwitch(
              title: l10n.notifyMessages,
              value: s.notifyMessages,
              onChanged: (v) => apply((s) => s.copyWith(notifyMessages: v)),
            ),
            SettingsSwitch(
              title: l10n.notifyRequests,
              value: s.notifyRequests,
              onChanged: (v) => apply((s) => s.copyWith(notifyRequests: v)),
            ),
            SettingsSwitch(
              title: l10n.notifyCapsules,
              value: s.notifyCapsules,
              onChanged: (v) => apply((s) => s.copyWith(notifyCapsules: v)),
            ),
            SettingsSwitch(
              title: l10n.notifyShadow,
              value: s.notifyShadow,
              onChanged: (v) => apply((s) => s.copyWith(notifyShadow: v)),
            ),
            SettingsSwitch(
              title: l10n.notifyStreaks,
              value: s.notifyStreaks,
              onChanged: (v) => apply((s) => s.copyWith(notifyStreaks: v)),
            ),
            SettingsSwitch(
              title: l10n.notifyAchievements,
              value: s.notifyAchievements,
              onChanged: (v) => apply((s) => s.copyWith(notifyAchievements: v)),
            ),
            SettingsSwitch(
              title: l10n.notifyWeeklyReport,
              value: s.notifyWeeklyReport,
              onChanged: (v) => apply((s) => s.copyWith(notifyWeeklyReport: v)),
            ),
          ],
        ),
        SettingsSection(
          children: [
            SettingsChoice<NotificationPreview>(
              title: l10n.notificationsPreview,
              value: s.notificationPreview,
              options: NotificationPreview.values,
              label: (v) => switch (v) {
                NotificationPreview.full => l10n.previewFull,
                NotificationPreview.sender => l10n.previewSender,
                NotificationPreview.none => l10n.previewNone,
              },
              onChanged: (v) =>
                  apply((s) => s.copyWith(notificationPreview: v)),
            ),
            SettingsSwitch(
              key: const Key('quiet-hours'),
              title: l10n.notificationsQuietHours,
              subtitle: l10n.notificationsQuietHoursHint,
              value: s.quietHoursEnabled,
              onChanged: (v) => apply((s) => s.copyWith(quietHoursEnabled: v)),
            ),
            if (s.quietHoursEnabled)
              SettingsLink(
                key: const Key('quiet-hours-time'),
                icon: Icons.schedule_rounded,
                title: l10n.notificationsQuietFromTo(
                  _format(context, s.quietFromMinute),
                  _format(context, s.quietToMinute),
                ),
                onTap: () => _pickTimes(context, ref, s),
              ),
            SettingsLink(
              icon: Icons.volume_up_outlined,
              title: l10n.notificationsSystem,
              subtitle: l10n.notificationsSystemHint,
              onTap: () => AppSettings.openAppSettings(
                type: AppSettingsType.notification,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String _format(BuildContext context, int minute) =>
      TimeOfDay(hour: minute ~/ 60, minute: minute % 60).format(context);

  Future<void> _pickTimes(
    BuildContext context,
    WidgetRef ref,
    UserSettings s,
  ) async {
    final from = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: s.quietFromMinute ~/ 60,
        minute: s.quietFromMinute % 60,
      ),
    );
    if (from == null || !context.mounted) return;
    final to = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: s.quietToMinute ~/ 60,
        minute: s.quietToMinute % 60,
      ),
    );
    if (to == null || !context.mounted) return;
    applySetting(
      context,
      ref,
      (s) => s.copyWith(
        quietFromMinute: from.hour * 60 + from.minute,
        quietToMinute: to.hour * 60 + to.minute,
      ),
    );
  }
}
