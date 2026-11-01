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

/// Моя планета в центре, друзья на эллиптических орбитах, вокруг — пылевой
/// диск. Сцена занимает весь экран; [padding] — то, что закрыто шапкой и
/// нижней панелью: орбиты друзей помещаются в оставшуюся часть.
///
/// Пинч-зум и перетаскивание; с «уменьшить движение» система стоит.
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

/// Размер зоны касания планеты друга: не меньше 48 dp, даже если сама
/// планета меньше.
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
    final unread = friend.hasUnreadSnaps;
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
            if (unread)
              Container(
                width: bodySize,
                height: bodySize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mint.withValues(alpha: 0.7),
                      blurRadius: bodySize * 0.6,
                      spreadRadius: bodySize * 0.1,
                    ),
                  ],
                ),
              ),
            // Друг в тени — планета в полутени, как при затмении.
            Opacity(
              opacity: inShadow ? 0.45 : 1,
              child: PlanetView(
                appearance: friend.appearance,
                size: orbit.planetSize,
              ),
            ),
            Positioned(
              top: _tapBoxOf(orbit) / 2 + bodySize / 2,
              child: Text(
                inShadow ? '🌘 ${friend.name}' : friend.name,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: unread ? AppColors.mint : AppColors.textPrimary,
                  shadows: const [
                    Shadow(color: AppColors.spaceDeep, blurRadius: 4),
                    Shadow(color: AppColors.spaceDeep, blurRadius: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Двигает планеты без перестройки виджетов и сортирует их по глубине:
/// те, что на дальней стороне орбиты, рисуются за солнцем и чуть меньше.
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
