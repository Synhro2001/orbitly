import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/system/presentation/widgets/orbit_layout.dart';
import 'package:orbitly/features/system/presentation/widgets/orbit_painters.dart';

/// My planet in the centre, friends on elliptical orbits, a dust disk around.
/// The scene fills the screen; [padding] is what the header and the bottom
/// bar cover, and friend orbits fit into the rest.
///
/// Pinch to zoom and drag; with "reduce motion" the system stands still.
class OrbitSystemView extends StatefulWidget {
  const OrbitSystemView({
    required this.me,
    required this.friends,
    required this.onFriendTap,
    this.padding = EdgeInsets.zero,
    this.onInteractionStart,
    super.key,
  });

  final PlanetAppearance me;
  final List<Friend> friends;
  final ValueChanged<Friend> onFriendTap;
  final EdgeInsets padding;
  final VoidCallback? onInteractionStart;

  @override
  State<OrbitSystemView> createState() => _OrbitSystemViewState();
}

class _OrbitSystemViewState extends State<OrbitSystemView>
    with SingleTickerProviderStateMixin {
  late final _clock = AnimationController(
    vsync: this,
    duration: AppDurations.systemCycle,
  );
  bool _reduceMotion = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (_reduceMotion) {
      _clock.stop();
    } else if (!_clock.isAnimating) {
      _clock.repeat();
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final layout = OrbitLayout(
          area: widget.padding.deflateRect(Offset.zero & size),
          friends: widget.friends,
        );
        return InteractiveViewer(
          minScale: 0.5,
          maxScale: 3,
          boundaryMargin: EdgeInsets.all(size.shortestSide),
          onInteractionStart: (_) => widget.onInteractionStart?.call(),
          child: SizedBox.fromSize(
            size: size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomPaint(size: size, painter: DustPainter(layout, _clock)),
                RepaintBoundary(
                  child: CustomPaint(
                    size: size,
                    painter: OrbitsPainter(layout),
                  ),
                ),
                if (!_reduceMotion)
                  CustomPaint(
                    size: size,
                    painter: CometsPainter(layout, _clock),
                  ),
                Flow(
                  delegate: _OrbitFlowDelegate(layout, _clock),
                  children: [
                    PlanetView(appearance: widget.me, size: layout.mySize),
                    for (final orbit in layout.orbits)
                      _FriendPlanet(
                        orbit: orbit,
                        onTap: () => widget.onFriendTap(orbit.friend),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Touch target of a friend's planet: at least 48 dp even if the planet
/// itself is smaller.
double _tapBoxOf(FriendOrbit orbit) =>
    math.max(orbit.planetSize, AppSizes.minTapTarget);

class _FriendPlanet extends ConsumerWidget {
  const _FriendPlanet({required this.orbit, required this.onTap});

  final FriendOrbit orbit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friend = orbit.friend;
    final l10n = context.l10n;
    final bodySize = orbit.planetSize * PlanetPainter.bodyRadiusFactor * 2;
    final unread = friend.glows;
    final now = ref.watch(clockProvider)();
    final inShadow = friend.shadow?.isActiveAt(now) ?? false;
    return Semantics(
      button: true,
      label: switch ((unread, inShadow)) {
        (true, _) => l10n.systemFriendPlanetUnread(friend.name),
        (false, true) => l10n.systemFriendPlanetShadow(friend.name),
        _ => l10n.systemFriendPlanet(friend.name),
      },
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // A gradient glow instead of a blurred shadow: a blur is
            // recomputed every frame and slows the map down.
            if (unread)
              SizedBox.square(
                dimension: bodySize * 2.2,
                child: const DecoratedBox(decoration: _unreadGlow),
              ),
            // A friend in shadow: the planet is half-dark, like an eclipse.
            PlanetView(
              appearance: friend.appearance,
              size: orbit.planetSize,
              opacity: inShadow ? 0.45 : 1,
            ),
            // Shared friendship trophy: the icon of the latest one.
            if (friend.sharedTrophies.lastOrNull?.emoji case final emoji?)
              Positioned(
                right: _tapBoxOf(orbit) / 2 - bodySize / 2 - AppSpacing.s,
                top: _tapBoxOf(orbit) / 2 - bodySize / 2 - AppSpacing.s,
                child: Text(
                  emoji,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            Positioned(
              top: _tapBoxOf(orbit) / 2 + bodySize / 2,
              child: Text(
                inShadow ? '🌘 ${friend.name}' : friend.name,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: unread ? AppColors.mint : AppColors.textPrimary,
                  shadows: _labelOutline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _unreadGlow = BoxDecoration(
  shape: BoxShape.circle,
  gradient: RadialGradient(
    colors: [Color(0xB37CF2D0), Color(0x597CF2D0), Color(0x007CF2D0)],
    stops: [0.3, 0.55, 1],
  ),
);

/// A dark outline around the name without blur: readable on any background.
const _labelOutline = [
  Shadow(color: AppColors.spaceDeep, offset: Offset(1, 1)),
  Shadow(color: AppColors.spaceDeep, offset: Offset(-1, -1)),
  Shadow(color: AppColors.spaceDeep, offset: Offset(1, -1)),
  Shadow(color: AppColors.spaceDeep, offset: Offset(-1, 1)),
];

/// Moves planets without rebuilding widgets and sorts them by depth: those
/// on the far side of the orbit are painted behind the sun and a bit smaller.
class _OrbitFlowDelegate extends FlowDelegate {
  _OrbitFlowDelegate(this.layout, this.clock) : super(repaint: clock);

  final OrbitLayout layout;
  final Animation<double> clock;

  static const _farScale = 0.82;

  double _sizeOf(int index) =>
      index == 0 ? layout.mySize : _tapBoxOf(layout.orbits[index - 1]);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) =>
      BoxConstraints.tight(Size.square(_sizeOf(i)));

  @override
  void paintChildren(FlowPaintingContext context) {
    final t = clock.value;
    final items = <(double depth, int index, Offset position, double scale)>[
      (0, 0, layout.center, 1),
      for (final (i, orbit) in layout.orbits.indexed)
        (
          layout.depthOf(orbit, t),
          i + 1,
          layout.positionOf(orbit, t),
          _farScale + (1 - _farScale) * (layout.depthOf(orbit, t) + 1) / 2,
        ),
    ]..sort((a, b) => a.$1.compareTo(b.$1));

    for (final (_, index, position, scale) in items) {
      final half = _sizeOf(index) * scale / 2;
      context.paintChild(
        index,
        transform: Matrix4.identity()
          ..setEntry(0, 0, scale)
          ..setEntry(1, 1, scale)
          ..setTranslationRaw(position.dx - half, position.dy - half, 0),
      );
    }
  }

  @override
  bool shouldRepaint(_OrbitFlowDelegate oldDelegate) =>
      oldDelegate.layout != layout;

  @override
  bool shouldRelayout(_OrbitFlowDelegate oldDelegate) =>
      oldDelegate.layout != layout;
}
