import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/utils/time.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/achievements/presentation/controllers/achievements_controller.dart';
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
                  Expanded(
                    child: Text(
                      l10n.planetLevel(planet.level),
                      style: textTheme.titleMedium,
                    ),
                  ),
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
                  Expanded(
                    child: Text(
                      l10n.planetBestStreak,
                      style: textTheme.bodyMedium,
                    ),
                  ),
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
        _Section(title: l10n.planetShadowTitle, child: _ShadowControls(planet)),
        const SizedBox(height: AppSpacing.l),
        _Section(title: l10n.planetAwards, child: const _CollectionSummary()),
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

/// Сколько достижений открыто, последние значки и вход в коллекцию и
/// гардероб.
class _CollectionSummary extends ConsumerWidget {
  const _CollectionSummary();

  static const _recentCount = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final awards = ref.watch(achievementsControllerProvider).value ?? const [];
    final unlocked = [
      for (final a in awards)
        if (a.unlocked) a,
    ]..sort((a, b) => b.unlockedAt!.compareTo(a.unlockedAt!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.planetCollectionSummary(unlocked.length, awards.length),
          style: textTheme.bodyMedium,
        ),
        if (unlocked.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.s),
          Text(
            [for (final a in unlocked.take(_recentCount)) a.emoji ?? '']
                .join(' '),
            style: textTheme.headlineSmall,
          ),
        ],
        const SizedBox(height: AppSpacing.m),
        Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [
            FilledButton.tonal(
              onPressed: () => context.push(AppRoutes.collection),
              child: Text(l10n.collectionTitle),
            ),
            OutlinedButton(
              onPressed: () => context.push(AppRoutes.wardrobe),
              child: Text(l10n.wardrobeTitle),
            ),
          ],
        ),
      ],
    );
  }
}

/// Уйти в тень на время (серии замрут) или выйти из неё раньше срока.
class _ShadowControls extends ConsumerWidget {
  const _ShadowControls(this.planet);

  final MyPlanet planet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final controller = ref.read(myPlanetControllerProvider.notifier);
    final now = ref.watch(clockProvider)();
    final shadow = planet.shadow;

    if (shadow != null && shadow.isActiveAt(now)) {
      final daysLeft = daysUntil(shadow.until, now: now);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🌘 ${l10n.planetShadowActive(daysLeft)}',
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.planetShadowActiveHint, style: textTheme.bodySmall),
          const SizedBox(height: AppSpacing.m),
          OutlinedButton(
            onPressed: controller.leaveShadow,
            child: Text(l10n.planetShadowLeave),
          ),
        ],
      );
    }

    final options = [
      (l10n.planetShadowDay, const Duration(days: 1)),
      (l10n.planetShadow3Days, const Duration(days: 3)),
      (l10n.planetShadowWeek, const Duration(days: 7)),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.planetShadowHint, style: textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.m),
        Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [
            for (final (label, duration) in options)
              OutlinedButton(
                onPressed: () => controller.enterShadow(duration),
                child: Text(label),
              ),
          ],
        ),
      ],
    );
  }
}
