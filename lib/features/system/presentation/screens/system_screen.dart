import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/content_viewer.dart';
import 'package:orbitly/core/widgets/planet_disc.dart';
import 'package:orbitly/core/widgets/streak_visibility.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';
import 'package:orbitly/features/system/presentation/controllers/system_controller.dart';
import 'package:orbitly/features/system/presentation/widgets/moments_row.dart';
import 'package:orbitly/features/system/presentation/widgets/orbit_system_view.dart';

class SystemScreen extends ConsumerStatefulWidget {
  const SystemScreen({super.key});

  @override
  ConsumerState<SystemScreen> createState() => _SystemScreenState();
}

class _SystemScreenState extends ConsumerState<SystemScreen> {
  /// Velocity of a swipe from the right edge that opens the camera.
  static const _cameraSwipeVelocity = 250.0;

  static const _headerHeight = 56.0;
  static const double _momentsHeight = AppSizes.momentAvatar + AppSpacing.xl;

  bool _hintVisible = true;
  Timer? _hintTimer;

  @override
  void initState() {
    super.initState();
    _hintTimer = Timer(AppDurations.gestureHint, _hideHint);
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    super.dispose();
  }

  void _hideHint() {
    if (mounted && _hintVisible) setState(() => _hintVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final insets = MediaQuery.paddingOf(context);
    final me = ref.watch(myPlanetControllerProvider).value;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AsyncView(
        value: ref.watch(systemControllerProvider),
        onRetry: () => ref.invalidate(systemControllerProvider),
        builder: (system) {
          final hasMoments = system.moments.isNotEmpty;
          final topCovered =
              insets.top + _headerHeight + (hasMoments ? _momentsHeight : 0);
          return Stack(
            children: [
              // Full-screen scene under the header and the bottom bar.
              if (system.friends.isEmpty)
                Center(child: Text(l10n.systemEmpty))
              else if (me != null)
                Positioned.fill(
                  child: OrbitSystemView(
                    me: me.appearance,
                    friends: system.friends,
                    padding: EdgeInsets.only(
                      top: topCovered,
                      bottom: insets.bottom,
                    ),
                    onInteractionStart: _hideHint,
                    onFriendTap: (friend) =>
                        context.push(AppRoutes.chat(friend.id)),
                  ),
                ),
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    SizedBox(
                      height: _headerHeight,
                      child: _Header(
                        me: me,
                        onReport: () => context.push(AppRoutes.report),
                        onPlanet: () => context.go(AppRoutes.planet),
                      ),
                    ),
                    MomentsRow(
                      moments: system.moments,
                      friends: system.friends,
                      onTap: (moment, friend) {
                        _hideHint();
                        unawaited(
                          showContentViewer(
                            context,
                            title: l10n.momentOf(friend.name),
                          ),
                        );
                        unawaited(
                          ref
                              .read(systemControllerProvider.notifier)
                              .markMomentSeen(moment.id),
                        );
                      },
                    ),
                    _GestureHint(visible: _hintVisible),
                  ],
                ),
              ),
              // Swipe left from the right edge opens the camera. A narrow zone
              // so it does not get in the way of dragging the system.
              Positioned(
                top: topCovered,
                bottom: insets.bottom,
                right: 0,
                width: AppSizes.edgeSwipeZone,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragEnd: (details) {
                    if ((details.primaryVelocity ?? 0) <
                        -_cameraSwipeVelocity) {
                      unawaited(context.push(AppRoutes.camera));
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.me,
    required this.onReport,
    required this.onPlanet,
  });

  final MyPlanet? me;
  final VoidCallback onReport;
  final VoidCallback onPlanet;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final me = this.me;
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.l, right: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              label: l10n.systemTitle,
              excludeSemantics: true,
              child: Text.rich(
                TextSpan(
                  text: l10n.brandStart,
                  children: [
                    TextSpan(
                      text: l10n.brandAccent,
                      style: const TextStyle(color: AppColors.sun),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          if (me != null) _LevelChip(me: me, onTap: onPlanet),
          IconButton(
            tooltip: l10n.systemReport,
            onPressed: onReport,
            icon: const Icon(Icons.insights_rounded),
          ),
        ],
      ),
    );
  }
}

/// Level and best streak; tapping opens "My planet".
class _LevelChip extends ConsumerWidget {
  const _LevelChip({required this.me, required this.onTap});

  final MyPlanet me;
  final VoidCallback onTap;

  static const _planetIcon = 24.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final now = ref.watch(clockProvider)();
    final label = (me.shadow?.isActiveAt(now) ?? false)
        ? l10n.systemShadowChip
        : StreakVisibility.hiddenOf(context)
        ? l10n.systemLevelOnly(me.level)
        : l10n.systemLevelChip(me.level, me.bestStreakDays);
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: AppColors.navBar,
        shape: const StadiumBorder(side: BorderSide(color: AppColors.outline)),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: AppSizes.iconButton),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PlanetDisc(appearance: me.appearance, diameter: _planetIcon),
                  const SizedBox(width: AppSpacing.s),
                  Text(label, style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Gesture hint. Disappears after the first touch on the scene or on a timer.
class _GestureHint extends StatelessWidget {
  const _GestureHint({required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: AppDurations.medium,
        child: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.s),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.navBar,
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(color: AppColors.outline),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.s,
              ),
              child: Text(
                context.l10n.systemHint,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
