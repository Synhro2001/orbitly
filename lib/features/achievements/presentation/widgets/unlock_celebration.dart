import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/usecases/apply_cosmetics.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/achievements/presentation/controllers/achievements_controller.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';

/// Plays the animation for every unlocked but not yet shown achievement,
/// one at a time. Listens to new unlocks from the server.
class UnlockCelebrationHost extends ConsumerWidget {
  const UnlockCelebrationHost({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(achievementUnlocksProvider, (_, next) {
      if (next.hasValue) {
        ref
          ..invalidate(achievementsControllerProvider)
          ..invalidate(ownedCosmeticsProvider)
          ..invalidate(myPlanetControllerProvider);
      }
    });
    final pending = ref.watch(pendingUnlocksProvider);
    return Stack(
      children: [
        child,
        if (pending.isNotEmpty)
          Positioned.fill(
            child: UnlockCelebration(
              key: ValueKey(pending.first.id),
              award: pending.first,
            ),
          ),
      ],
    );
  }
}

class UnlockCelebration extends ConsumerStatefulWidget {
  const UnlockCelebration({required this.award, super.key});

  final Award award;

  @override
  ConsumerState<UnlockCelebration> createState() => _UnlockCelebrationState();
}

class _UnlockCelebrationState extends ConsumerState<UnlockCelebration>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: AppDurations.unlock,
  );
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    unawaited(HapticFeedback.heavyImpact());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else if (!_controller.isAnimating && _controller.value == 0) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Cosmetic? _reward(List<Cosmetic> owned) =>
      owned.where((c) => c.id == widget.award.rewardId).firstOrNull;

  Future<void> _close({bool equip = false}) async {
    if (_busy) return;
    setState(() => _busy = true);
    final rewardId = widget.award.rewardId;
    if (equip && rewardId != null) {
      await ref.read(ownedCosmeticsProvider.notifier).equip(rewardId);
    }
    await ref
        .read(achievementsControllerProvider.notifier)
        .markSeen(widget.award.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final award = widget.award;
    final color = AppColors.forRarity(award.rarity);
    final planet = ref.watch(myPlanetControllerProvider).value;
    final reward = _reward(ref.watch(ownedCosmeticsProvider).value ?? const []);

    // The planet already wears the new reward.
    final appearance = planet == null
        ? null
        : const ApplyCosmetics()(planet.baseAppearance, [
            for (final c in planet.equipped)
              if (reward == null || c.kind != reward.kind) c,
            ?reward,
          ]);

    // A dense scrim: text over space must stay readable.
    return Material(
      color: AppColors.celebrationScrim,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = Curves.easeOutCubic.transform(_controller.value);
          return Stack(
            fit: StackFit.expand,
            children: [
              // A flash in the rarity colour.
              IgnorePointer(
                child: Opacity(
                  opacity: (1 - _controller.value).clamp(0, 1) * 0.9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.2 + t,
                        colors: [color, color.withValues(alpha: 0)],
                      ),
                    ),
                  ),
                ),
              ),
              Transform.scale(scale: 0.8 + 0.2 * t, child: child),
            ],
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.unlockTitle,
                  style: textTheme.titleMedium?.copyWith(color: color),
                ),
                const SizedBox(height: AppSpacing.m),
                if (appearance != null)
                  PlanetView(
                    appearance: appearance,
                    size: AppSizes.unlockPlanet,
                    live: true,
                  ),
                Text(
                  '${award.emoji ?? ''} ${award.title ?? ''}'.trim(),
                  style: textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  award.description ?? '',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.s),
                Text(
                  award.rarity.label(l10n),
                  style: textTheme.labelMedium?.copyWith(color: color),
                ),
                if (award.rewardTitle case final rewardTitle?) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.achievementReward(rewardTitle),
                    style: textTheme.labelMedium,
                  ),
                ],
                if (award.pair) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.unlockPairNote,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.mint,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                if (reward != null)
                  FilledButton(
                    onPressed: _busy ? null : () => _close(equip: true),
                    child: Text(l10n.unlockEquip),
                  ),
                const SizedBox(height: AppSpacing.s),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(
                            SnackBar(content: Text(l10n.unlockShareSoon)),
                          ),
                      child: Text(l10n.unlockShare),
                    ),
                    TextButton(
                      onPressed: _busy ? null : _close,
                      child: Text(l10n.unlockLater),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
