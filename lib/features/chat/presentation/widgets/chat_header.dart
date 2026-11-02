import 'package:flutter/material.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/streak_badge.dart';

/// Friend card at the start of the conversation: planet, streak, trophies.
class ChatHeader extends StatelessWidget {
  const ChatHeader({
    required this.friend,
    required this.trophies,
    required this.shadows,
    super.key,
  });

  final Friend friend;
  final List<Award> trophies;
  final List<Shadow> shadows;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        0,
        AppSpacing.l,
        AppSpacing.m,
      ),
      child: Column(
        children: [
          PlanetView(
            appearance: friend.appearance,
            size: AppSizes.chatHeaderPlanet,
          ),
          Text(
            '${friend.name} ${friend.mood.emoji()}',
            style: textTheme.titleLarge,
          ),
          Text('@${friend.handle}', style: textTheme.bodySmall),
          const SizedBox(height: AppSpacing.s),
          StreakBadge(streak: friend.streak, shadows: shadows),
          if (trophies.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.m),
            Text(l10n.chatSharedTrophies, style: textTheme.labelSmall),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.s,
              children: [
                for (final trophy in trophies)
                  Tooltip(
                    message: trophy.title?.of(context) ?? '',
                    child: Text(
                      trophy.emoji ?? '',
                      style: textTheme.titleLarge,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
