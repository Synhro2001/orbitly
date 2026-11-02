import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/achievements/presentation/controllers/achievements_controller.dart';

/// All achievements by category. The border shows rarity, locked ones show
/// progress, secrets show "???" until unlocked.
class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final tabs = <(String, AwardCategory?)>[
      (l10n.categoryAll, null),
      for (final category in AwardCategory.values)
        (category.label(l10n), category),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.collectionTitle),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppColors.sun,
            labelColor: AppColors.sun,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [for (final (label, _) in tabs) Tab(text: label)],
          ),
        ),
        body: StarfieldBackground(
          child: AsyncView(
            value: ref.watch(achievementsControllerProvider),
            onRetry: () => ref.invalidate(achievementsControllerProvider),
            builder: (awards) => TabBarView(
              children: [
                for (final (_, category) in tabs)
                  _AwardList(
                    awards: [
                      for (final a in awards)
                        if (category == null || a.category == category) a,
                    ],
                    showProgress: category == null,
                    total: awards.length,
                    unlocked: awards.where((a) => a.unlocked).length,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AwardList extends StatelessWidget {
  const _AwardList({
    required this.awards,
    required this.showProgress,
    required this.total,
    required this.unlocked,
  });

  final List<Award> awards;
  final bool showProgress;
  final int total;
  final int unlocked;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.l),
      children: [
        if (showProgress) ...[
          Text(
            context.l10n.collectionProgress(unlocked, total),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.s),
          LinearProgressIndicator(
            value: total == 0 ? 0 : unlocked / total,
            minHeight: AppSpacing.s,
            color: AppColors.sun,
            backgroundColor: AppColors.surfaceHigh,
            borderRadius: BorderRadius.circular(AppRadii.pill),
          ),
          const SizedBox(height: AppSpacing.l),
        ],
        for (final award in awards) ...[
          AwardCard(award: award),
          const SizedBox(height: AppSpacing.m),
        ],
      ],
    );
  }
}

class AwardCard extends StatelessWidget {
  const AwardCard({required this.award, super.key});

  final Award award;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final color = AppColors.forRarity(award.rarity);
    final secret = award.isSecretLocked;
    final title = secret
        ? l10n.achievementSecretTitle
        : award.title?.of(context) ?? '';
    final description = secret
        ? l10n.achievementSecretDescription
        : award.description?.of(context) ?? '';

    return Semantics(
      label: '$title. $description. ${award.rarity.label(l10n)}',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadii.m),
          border: Border.all(
            color: award.unlocked ? color : color.withValues(alpha: 0.35),
            width: award.unlocked ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Badge(award: award, color: color),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text(description, style: textTheme.bodySmall),
                  if (!award.unlocked && !secret) ...[
                    const SizedBox(height: AppSpacing.s),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: award.progressFraction,
                            color: color,
                            backgroundColor: AppColors.surfaceHigh,
                            borderRadius: BorderRadius.circular(AppRadii.pill),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s),
                        Text(
                          '${award.progress} / ${award.target}',
                          style: textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: AppSpacing.s),
                  Wrap(
                    spacing: AppSpacing.s,
                    runSpacing: AppSpacing.xs,
                    children: [
                      _Chip(text: award.rarity.label(l10n), color: color),
                      if (award.pair)
                        _Chip(
                          text: l10n.achievementPair,
                          color: AppColors.mint,
                        ),
                      if (award.unlocked)
                        _Chip(
                          text: l10n.achievementUnlocked,
                          color: AppColors.textSecondary,
                        ),
                    ],
                  ),
                  if (award.rewardTitle case final reward? when !secret) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.achievementReward(reward.of(context)),
                      style: textTheme.labelSmall?.copyWith(color: color),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.award, required this.color});

  final Award award;
  final Color color;

  static const _size = 52.0;

  @override
  Widget build(BuildContext context) {
    final emoji = award.isSecretLocked ? '?' : award.emoji ?? '?';
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: award.unlocked ? 0.2 : 0.06),
      ),
      child: Opacity(
        opacity: award.unlocked ? 1 : 0.4,
        child: Text(emoji, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s,
          vertical: AppSpacing.xs / 2,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
        ),
      ),
    );
  }
}
