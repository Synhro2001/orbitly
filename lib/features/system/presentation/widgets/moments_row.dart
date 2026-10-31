import 'package:flutter/material.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/system/domain/entities/moment.dart';

/// Ряд кружков с моментами друзей. Непросмотренные — в цветном кольце.
class MomentsRow extends StatelessWidget {
  const MomentsRow({
    required this.moments,
    required this.friends,
    required this.onTap,
    super.key,
  });

  final List<Moment> moments;
  final List<Friend> friends;
  final void Function(Moment moment, Friend friend) onTap;

  @override
  Widget build(BuildContext context) {
    final byId = {for (final f in friends) f.id: f};
    final items = [
      for (final m in moments)
        if (byId[m.friendId] case final friend?) (m, friend),
    ];
    if (items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: AppSizes.momentAvatar + AppSpacing.xl,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.m),
        itemBuilder: (context, i) {
          final (moment, friend) = items[i];
          return _MomentCircle(
            moment: moment,
            friend: friend,
            onTap: () => onTap(moment, friend),
          );
        },
      ),
    );
  }
}

class _MomentCircle extends StatelessWidget {
  const _MomentCircle({
    required this.moment,
    required this.friend,
    required this.onTap,
  });

  final Moment moment;
  final Friend friend;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.momentOf(friend.name),
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: AppSizes.momentAvatar,
              height: AppSizes.momentAvatar,
              padding: const EdgeInsets.all(AppSpacing.xs / 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: moment.seen
                    ? null
                    : const SweepGradient(
                        colors: [AppColors.sun, AppColors.mint, AppColors.sun],
                      ),
                border: moment.seen
                    ? Border.all(color: AppColors.outline)
                    : null,
              ),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.spaceMid,
                ),
                child: ClipOval(
                  child: OverflowBox(
                    maxWidth: AppSizes.momentAvatar * 1.5,
                    maxHeight: AppSizes.momentAvatar * 1.5,
                    child: PlanetView(
                      appearance: friend.appearance,
                      size: AppSizes.momentAvatar * 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(friend.name, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
