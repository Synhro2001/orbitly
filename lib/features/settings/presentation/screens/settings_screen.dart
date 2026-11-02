import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';

/// Settings: a profile card on top, then one row per section.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SettingsPage(
      title: l10n.settingsTitle,
      children: [
        const _ProfileCard(),
        const SizedBox(height: AppSpacing.l),
        SettingsLink(
          key: const Key('settings-appearance'),
          icon: Icons.palette_outlined,
          title: l10n.settingsAppearance,
          onTap: () => context.push(AppRoutes.settingsAppearance),
        ),
        SettingsLink(
          key: const Key('settings-account'),
          icon: Icons.manage_accounts_outlined,
          title: l10n.settingsAccount,
          onTap: () => context.push(AppRoutes.settingsAccount),
        ),
      ],
    );
  }
}

/// My planet, its name and my handle, with a shortcut to the wardrobe.
class _ProfileCard extends ConsumerWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planet = ref.watch(myPlanetControllerProvider).value;
    if (planet == null) return const SizedBox.shrink();
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.l),
      ),
      child: Row(
        children: [
          PlanetView(appearance: planet.appearance, size: AppSizes.listAvatar),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planet.name,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '@${planet.handle}',
                  style: textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => context.push(AppRoutes.wardrobe),
            child: Text(context.l10n.wardrobeTitle),
          ),
        ],
      ),
    );
  }
}
