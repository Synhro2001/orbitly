import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/presentation/controllers/safety_controller.dart';

/// People I blocked, each with "Unblock".
class BlockedUsersScreen extends ConsumerWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return _PeopleList(
      title: l10n.settingsBlocked,
      hint: l10n.settingsBlockedHint,
      empty: l10n.settingsBlockedEmpty,
      people: ref.watch(blockedUsersProvider),
      onRetry: () => ref.invalidate(blockedUsersProvider),
      actionLabel: l10n.unblock,
      onAction: (user) =>
          ref.read(safetyActionsProvider.notifier).unblock(user.id),
    );
  }
}

/// Friends in my quiet orbit, each with "Unmute".
class QuietOrbitScreen extends ConsumerWidget {
  const QuietOrbitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return _PeopleList(
      title: l10n.settingsQuietOrbit,
      hint: l10n.settingsQuietOrbitHint,
      empty: l10n.settingsQuietOrbitEmpty,
      people: ref.watch(mutedFriendsProvider),
      onRetry: () => ref.invalidate(mutedFriendsProvider),
      actionLabel: l10n.chatUnmute,
      onAction: (user) =>
          ref.read(safetyActionsProvider.notifier).unmute(user.id),
    );
  }
}

class _PeopleList extends StatelessWidget {
  const _PeopleList({
    required this.title,
    required this.hint,
    required this.empty,
    required this.people,
    required this.onRetry,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String hint;
  final String empty;
  final AsyncValue<List<UserSummary>> people;
  final VoidCallback onRetry;
  final String actionLabel;
  final Future<void> Function(UserSummary user) onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      extendBodyBehindAppBar: true,
      body: StarfieldBackground(
        child: SafeArea(
          child: AsyncView(
            value: people,
            onRetry: onRetry,
            builder: (people) => ListView(
              padding: const EdgeInsets.all(AppSpacing.l),
              children: [
                Text(hint, style: textTheme.bodySmall),
                const SizedBox(height: AppSpacing.m),
                if (people.isEmpty)
                  Text(empty, style: textTheme.bodyMedium)
                else
                  for (final user in people)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: PlanetView(
                        appearance: user.appearance,
                        size: AppSizes.listAvatar,
                      ),
                      title: Text(user.name),
                      subtitle: Text('@${user.handle}'),
                      trailing: OutlinedButton(
                        onPressed: () => onAction(user),
                        child: Text(actionLabel),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
