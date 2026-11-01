import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/domain/entities/streak.dart';
import 'package:orbitly/core/domain/usecases/evaluate_streak.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';

/// Серия дней с состоянием: активна / трещина / сгорела / на паузе.
class StreakBadge extends ConsumerWidget {
  const StreakBadge({
    required this.streak,
    this.shadows = const [],
    this.compact = false,
    super.key,
  });

  final Streak streak;

  /// Тени обоих друзей: пока кто-то в тени, серия на паузе.
  final List<Shadow> shadows;

  /// Только иконка и число — для списков.
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final now = ref.watch(clockProvider)();
    final status = const EvaluateStreak()(streak, now, shadows: shadows);
    final (icon, color, label) = switch (status) {
      StreakStatus.active => (
        '🔥',
        AppColors.sun,
        l10n.streakDays(streak.days),
      ),
      StreakStatus.cracked => (
        '🧊',
        AppColors.streakCracked,
        l10n.streakCracked(streak.days),
      ),
      StreakStatus.burnt => ('💨', AppColors.textMuted, l10n.streakBurnt),
      StreakStatus.paused => (
        '🌘',
        AppColors.textSecondary,
        l10n.streakPaused(streak.days),
      ),
    };
    final textStyle = Theme.of(context).textTheme.labelMedium
        ?.copyWith(color: color);

    if (compact) {
      if (status == StreakStatus.burnt) return const SizedBox.shrink();
      return Text('$icon ${streak.days}', style: textStyle);
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.xs,
        ),
        child: Text('$icon $label', style: textStyle),
      ),
    );
  }
}
