import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';

class MyPlanetScreen extends ConsumerWidget {
  const MyPlanetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Фон-космос общий для вкладок — он в HomeShell.
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: AsyncView(
          value: ref.watch(myPlanetControllerProvider),
          onRetry: () => ref.invalidate(myPlanetControllerProvider),
          builder: (planet) => _PlanetContent(planet: planet),
        ),
      ),
    );
  }
}

class _PlanetContent extends ConsumerWidget {
  const _PlanetContent({required this.planet});

  final MyPlanet planet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.l),
      children: [
        Center(
          child: PlanetView(
            appearance: planet.appearance,
            size: AppSizes.myPlanetHero,
          ),
        ),
        Text(
          planet.name,
          style: textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        _Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    l10n.planetLevel(planet.level),
                    style: textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Text(
                    l10n.planetXp(planet.xp, planet.xpForNextLevel),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s),
              LinearProgressIndicator(
                value: planet.levelProgress,
                minHeight: AppSpacing.s,
                color: AppColors.mint,
                backgroundColor: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              const SizedBox(height: AppSpacing.l),
              Row(
                children: [
                  Text(l10n.planetBestStreak, style: textTheme.bodyMedium),
                  const Spacer(),
                  Text(
                    '🔥 ${l10n.streakDays(planet.bestStreakDays)}',
                    style: textTheme.titleSmall?.copyWith(color: AppColors.sun),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        _Section(
          title: l10n.planetMood,
          child: Wrap(
            spacing: AppSpacing.s,
            runSpacing: AppSpacing.s,
            children: [
              for (final mood in Mood.values)
                ChoiceChip(
                  label: Text('${mood.emoji()} ${mood.label(l10n)}'),
                  selected: planet.mood == mood,
                  onSelected: (_) => ref
                      .read(myPlanetControllerProvider.notifier)
                      .setMood(mood),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        _Section(
          title: l10n.planetAwards,
          child: GridView.extent(
            maxCrossAxisExtent: AppSizes.awardTile,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.s,
            crossAxisSpacing: AppSpacing.s,
            children: [for (final award in planet.awards) _AwardTile(award)],
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.child, this.title});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.m),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

class _AwardTile extends StatelessWidget {
  const _AwardTile(this.award);

  final Award award;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final unlocked = award.unlocked;
    return Semantics(
      label: unlocked
          ? award.title
          : '${award.title}. ${context.l10n.planetAwardLocked}',
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          borderRadius: BorderRadius.circular(AppRadii.m),
          border: Border.all(
            color: unlocked ? AppColors.sun : AppColors.outline,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: unlocked ? 1 : 0.3,
                child: Text(award.emoji, style: textTheme.headlineMedium),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                unlocked ? award.title : context.l10n.planetAwardLocked,
                style: textTheme.labelSmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
