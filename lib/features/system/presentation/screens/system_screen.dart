import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/content_viewer.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';
import 'package:orbitly/features/system/presentation/controllers/system_controller.dart';
import 'package:orbitly/features/system/presentation/widgets/moments_row.dart';
import 'package:orbitly/features/system/presentation/widgets/orbit_system_view.dart';

class SystemScreen extends ConsumerWidget {
  const SystemScreen({super.key});

  /// Скорость свайпа от правого края, после которой открывается камера.
  static const _cameraSwipeVelocity = 250.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      body: StarfieldBackground(
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  _Header(
                    onReport: () => context.push(AppRoutes.report),
                    onFriends: () => context.push(AppRoutes.friends),
                    onCamera: () => context.push(AppRoutes.camera),
                  ),
                  Expanded(
                    child: AsyncView(
                      value: ref.watch(systemControllerProvider),
                      onRetry: () => ref.invalidate(systemControllerProvider),
                      builder: (system) => AsyncView(
                        value: ref.watch(myPlanetControllerProvider),
                        onRetry: () =>
                            ref.invalidate(myPlanetControllerProvider),
                        builder: (me) => Column(
                          children: [
                            MomentsRow(
                              moments: system.moments,
                              friends: system.friends,
                              onTap: (moment, friend) {
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
                            Expanded(
                              child: system.friends.isEmpty
                                  ? Center(child: Text(l10n.systemEmpty))
                                  : OrbitSystemView(
                                      me: me.appearance,
                                      friends: system.friends,
                                      onFriendTap: (friend) => context.push(
                                        AppRoutes.chat(friend.id),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Свайп влево от правого края — камера. Узкая зона, чтобы
              // не мешать перетаскиванию системы.
              Positioned(
                top: 0,
                bottom: 0,
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
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onReport,
    required this.onFriends,
    required this.onCamera,
  });

  final VoidCallback onReport;
  final VoidCallback onFriends;
  final VoidCallback onCamera;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.s,
        AppSpacing.s,
        AppSpacing.s,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.systemTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          IconButton(
            tooltip: l10n.systemReport,
            onPressed: onReport,
            icon: const Icon(Icons.insights_rounded),
          ),
          IconButton(
            tooltip: l10n.systemFriends,
            onPressed: onFriends,
            icon: const Icon(Icons.person_add_alt_1_rounded),
          ),
          IconButton(
            tooltip: l10n.systemCamera,
            onPressed: onCamera,
            icon: const Icon(Icons.photo_camera_rounded),
          ),
        ],
      ),
    );
  }
}
