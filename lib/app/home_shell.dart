import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/achievements/presentation/widgets/unlock_celebration.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';
import 'package:orbitly/features/friends/presentation/controllers/friends_controller.dart';

/// Shared space background for the tabs and the floating bottom bar:
/// System, Chats, camera in the middle (under the thumb), Friends, My planet.
class HomeShell extends ConsumerWidget {
  const HomeShell({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final unreadChats =
        ref
            .watch(chatsProvider)
            .value
            ?.where((chat) => chat.friend.hasUnreadSnaps)
            .length ??
        0;
    final requests = ref.watch(incomingRequestsProvider).value?.length ?? 0;

    void select(int index) => shell.goBranch(
      index,
      // Tapping the current tab again scrolls it back to the start.
      initialLocation: index == shell.currentIndex,
    );

    Widget item(int index, IconData icon, String label, [int badge = 0]) =>
        Expanded(
          child: _NavItem(
            icon: icon,
            label: label,
            badge: badge,
            selected: shell.currentIndex == index,
            onTap: () => select(index),
          ),
        );

    return Scaffold(
      // Content shows through the translucent bar.
      extendBody: true,
      body: UnlockCelebrationHost(child: StarfieldBackground(child: shell)),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(
          AppSpacing.m,
          0,
          AppSpacing.m,
          AppSpacing.s,
        ),
        child: Container(
          height: AppSizes.navBarHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.navBar,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(color: AppColors.outline),
          ),
          child: Row(
            children: [
              item(0, Icons.blur_circular_rounded, l10n.navSystem),
              item(1, Icons.chat_bubble_rounded, l10n.navChats, unreadChats),
              _CameraButton(
                label: l10n.navCamera,
                onTap: () => unawaited(context.push(AppRoutes.camera)),
              ),
              item(2, Icons.group_rounded, l10n.navFriends, requests),
              item(3, Icons.public_rounded, l10n.navPlanet),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.badge,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final int badge;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.sun : AppColors.textSecondary;
    return Semantics(
      button: true,
      selected: selected,
      label: badge > 0 ? '$label, $badge' : label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: AppDurations.fast,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.m,
                vertical: AppSpacing.xs / 2,
              ),
              decoration: BoxDecoration(
                color: selected ? AppColors.surfaceHigh : null,
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: Badge(
                isLabelVisible: badge > 0,
                label: Text('$badge'),
                backgroundColor: AppColors.mint,
                textColor: AppColors.onMint,
                child: Icon(icon, color: color),
              ),
            ),
            const SizedBox(height: AppSpacing.xs / 2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraButton extends StatelessWidget {
  const _CameraButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Semantics(
        button: true,
        label: label,
        excludeSemantics: true,
        child: Tooltip(
          message: label,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.sun.withValues(alpha: 0.45),
                  blurRadius: AppSpacing.l,
                ),
              ],
            ),
            child: Material(
              color: AppColors.sun,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onTap,
                child: const SizedBox.square(
                  dimension: AppSizes.navCenterButton,
                  child: Icon(
                    Icons.photo_camera_rounded,
                    color: AppColors.onSun,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
