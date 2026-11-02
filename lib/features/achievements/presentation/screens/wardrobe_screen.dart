import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/domain/usecases/apply_cosmetics.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/achievements/presentation/controllers/achievements_controller.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';

/// Unlocked rewards: tap one to preview it on the planet at the top, "Wear"
/// to keep it.
class WardrobeScreen extends ConsumerStatefulWidget {
  const WardrobeScreen({super.key});

  @override
  ConsumerState<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends ConsumerState<WardrobeScreen> {
  Cosmetic? _preview;

  PlanetAppearance _previewAppearance(MyPlanet planet) {
    final preview = _preview;
    if (preview == null) return planet.appearance;
    return const ApplyCosmetics()(planet.baseAppearance, [
      for (final c in planet.equipped)
        if (c.kind != preview.kind) c,
      preview,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.wardrobeTitle)),
      body: StarfieldBackground(
        child: AsyncView(
          value: ref.watch(myPlanetControllerProvider),
          onRetry: () => ref.invalidate(myPlanetControllerProvider),
          builder: (planet) => AsyncView(
            value: ref.watch(ownedCosmeticsProvider),
            onRetry: () => ref.invalidate(ownedCosmeticsProvider),
            builder: (owned) => ListView(
              padding: const EdgeInsets.all(AppSpacing.l),
              children: [
                Center(
                  child: PlanetView(
                    appearance: _previewAppearance(planet),
                    size: AppSizes.wardrobePreview,
                    live: true,
                  ),
                ),
                if (owned.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Text(
                      l10n.wardrobeEmpty,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                for (final kind in CosmeticKind.values)
                  if (owned.where((c) => c.kind == kind).toList()
                      case final items when items.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.l,
                        bottom: AppSpacing.s,
                      ),
                      child: Text(
                        kind.label(l10n),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    for (final item in items)
                      _CosmeticTile(
                        cosmetic: item,
                        previewed: _preview?.id == item.id,
                        onPreview: () => setState(() => _preview = item),
                        onToggle: () {
                          final notifier = ref.read(
                            ownedCosmeticsProvider.notifier,
                          );
                          setState(() => _preview = null);
                          unawaited(
                            item.equipped
                                ? notifier.unequip(item.kind)
                                : notifier.equip(item.id),
                          );
                        },
                      ),
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CosmeticTile extends StatelessWidget {
  const _CosmeticTile({
    required this.cosmetic,
    required this.previewed,
    required this.onPreview,
    required this.onToggle,
  });

  final Cosmetic cosmetic;
  final bool previewed;
  final VoidCallback onPreview;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = AppColors.forRarity(cosmetic.rarity);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.m),
          side: BorderSide(
            color: cosmetic.equipped || previewed
                ? color
                : color.withValues(alpha: 0.35),
            width: cosmetic.equipped ? 2 : 1,
          ),
        ),
        child: ListTile(
          onTap: onPreview,
          title: Text(cosmetic.title.of(context)),
          subtitle: Text(
            cosmetic.rarity.label(l10n),
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: color),
          ),
          trailing: cosmetic.equipped
              ? OutlinedButton(
                  onPressed: onToggle,
                  child: Text(l10n.wardrobeUnequip),
                )
              : FilledButton(
                  onPressed: onToggle,
                  child: Text(l10n.wardrobeEquip),
                ),
        ),
      ),
    );
  }
}
