import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';
import 'package:orbitly/l10n/app_localizations.dart';

/// Who can find me, contact me and see what. Each choice is checked on the
/// server, not only hidden here.
class PrivacySettingsScreen extends ConsumerWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    void apply(UserSettings Function(UserSettings s) update) =>
        applySetting(context, ref, update);

    return UserSettingsPage(
      title: l10n.settingsPrivacy,
      builder: (s) => [
        SettingsSection(
          children: [
            SettingsChoice<SearchVisibility>(
              key: const Key('privacy-search'),
              title: l10n.privacySearch,
              value: s.searchVisibility,
              options: SearchVisibility.values,
              label: (v) => searchVisibilityLabel(v, l10n),
              onChanged: (v) => apply((s) => s.copyWith(searchVisibility: v)),
            ),
            SettingsChoice<RequestPolicy>(
              key: const Key('privacy-requests'),
              title: l10n.privacyRequests,
              value: s.requestPolicy,
              options: RequestPolicy.values,
              label: (v) => requestPolicyLabel(v, l10n),
              onChanged: (v) => apply((s) => s.copyWith(requestPolicy: v)),
            ),
            SettingsChoice<MoodAudience>(
              key: const Key('privacy-mood'),
              title: l10n.privacyMood,
              value: s.moodAudience,
              options: MoodAudience.values,
              label: (v) => switch (v) {
                MoodAudience.closeOrbit => l10n.audienceCloseOrbit,
                MoodAudience.friends => l10n.audienceFriends,
                MoodAudience.nobody => l10n.audienceNobody,
              },
              onChanged: (v) => apply((s) => s.copyWith(moodAudience: v)),
            ),
          ],
        ),
        SettingsSection(
          children: [
            SettingsLink(
              key: const Key('privacy-blocked'),
              icon: Icons.block_rounded,
              title: l10n.settingsBlocked,
              onTap: () => context.push(AppRoutes.settingsBlocked),
            ),
            SettingsLink(
              key: const Key('privacy-quiet-orbit'),
              icon: Icons.notifications_paused_outlined,
              title: l10n.settingsQuietOrbit,
              onTap: () => context.push(AppRoutes.settingsQuietOrbit),
            ),
          ],
        ),
        // Saved now; they start working together with the features.
        SettingsSection(
          title: l10n.privacyComingSoon,
          children: [
            SettingsChoice<MomentsAudience>(
              title: l10n.privacyMoments,
              value: s.momentsAudience,
              options: MomentsAudience.values,
              label: (v) => switch (v) {
                MomentsAudience.closeOrbit => l10n.audienceCloseOrbit,
                MomentsAudience.friends => l10n.audienceFriends,
                MomentsAudience.custom => l10n.audienceCustom,
              },
              onChanged: (v) => apply((s) => s.copyWith(momentsAudience: v)),
            ),
            SettingsSwitch(
              key: const Key('privacy-last-seen'),
              title: l10n.privacyLastSeen,
              value: s.showLastSeen,
              onChanged: (v) => apply((s) => s.copyWith(showLastSeen: v)),
            ),
            SettingsSwitch(
              title: l10n.privacyReadReceipts,
              subtitle: l10n.privacyReadReceiptsHint,
              value: s.readReceipts,
              onChanged: (v) => apply((s) => s.copyWith(readReceipts: v)),
            ),
            SettingsSwitch(
              title: l10n.privacyTyping,
              value: s.typingIndicator,
              onChanged: (v) => apply((s) => s.copyWith(typingIndicator: v)),
            ),
            SettingsSwitch(
              title: l10n.privacyGalaxy,
              subtitle: l10n.privacyGalaxyHint,
              value: s.galaxyVisible,
              onChanged: (v) => apply((s) => s.copyWith(galaxyVisible: v)),
            ),
          ],
        ),
      ],
    );
  }
}

String searchVisibilityLabel(SearchVisibility v, AppLocalizations l10n) =>
    switch (v) {
      SearchVisibility.everyone => l10n.audienceEveryone,
      SearchVisibility.friendsOfFriends => l10n.audienceFriendsOfFriends,
      SearchVisibility.nobody => l10n.audienceNobody,
    };

String requestPolicyLabel(RequestPolicy v, AppLocalizations l10n) =>
    switch (v) {
      RequestPolicy.everyone => l10n.audienceEveryone,
      RequestPolicy.friendsOfFriends => l10n.audienceFriendsOfFriends,
      RequestPolicy.inviteOnly => l10n.audienceInviteOnly,
    };
