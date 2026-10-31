import 'package:flutter/material.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/system/presentation/widgets/orbit_layout.dart';

/// Моя планета в центре, друзья на эллиптических орбитах.
/// Пинч-зум и перетаскивание; с «уменьшить движение» система стоит.
class OrbitSystemView extends StatefulWidget {
  const OrbitSystemView({
    required this.me,
    required this.friends,
    required this.onFriendTap,
    super.key,
  });

  final PlanetAppearance me;
  final List<Friend> friends;
  final ValueChanged<Friend> onFriendTap;

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
        final layout = OrbitLayout(size: size, friends: widget.friends);
        return InteractiveViewer(
          minScale: 0.6,
          maxScale: 3,
          boundaryMargin: EdgeInsets.all(size.shortestSide / 2),
          child: SizedBox.fromSize(
            size: size,
            child: Stack(
              children: [
                RepaintBoundary(
                  child: CustomPaint(
                    size: size,
                    painter: _OrbitsPainter(layout),
                  ),
                ),
                if (!_reduceMotion)
                  CustomPaint(
                    size: size,
                    painter: _CometsPainter(layout, _clock),
                  ),
                Flow(
                  delegate: _OrbitFlowDelegate(layout, _clock),
                  children: [
                    PlanetView(
                      appearance: widget.me,
                      size: AppSizes.myPlanetInSystem,
                    ),
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

class _FriendPlanet extends StatelessWidget {
  const _FriendPlanet({required this.orbit, required this.onTap});

  final FriendOrbit orbit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final friend = orbit.friend;
    final l10n = context.l10n;
    final bodySize = orbit.planetSize * PlanetPainter.bodyRadiusFactor * 2;
    return Semantics(
      button: true,
      label: friend.hasUnreadSnaps
          ? l10n.systemFriendPlanetUnread(friend.name)
          : l10n.systemFriendPlanet(friend.name),
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (friend.hasUnreadSnaps)
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
            PlanetView(appearance: friend.appearance, size: orbit.planetSize),
            Positioned(
              bottom: 0,
              child: Text(
                friend.name,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: AppColors.textPrimary),
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

  double _sizeOf(int index) => index == 0
      ? AppSizes.myPlanetInSystem
      : layout.orbits[index - 1].planetSize;

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

class _OrbitsPainter extends CustomPainter {
  const _OrbitsPainter(this.layout);

  final OrbitLayout layout;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.orbitLine
      ..style = PaintingStyle.stroke;
    for (final orbit in layout.orbits) {
      canvas.drawOval(
        Rect.fromCenter(
          center: layout.center,
          width: orbit.radius * 2,
          height: orbit.radius * 2 * AppSizes.orbitTilt,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_OrbitsPainter oldDelegate) =>
      oldDelegate.layout != layout;
}

/// Кометы летят от моей планеты к друзьям, у которых есть непрочитанное.
class _CometsPainter extends CustomPainter {
  _CometsPainter(this.layout, this.clock) : super(repaint: clock);

  final OrbitLayout layout;
  final Animation<double> clock;

  /// Сколько раз комета долетает за цикл (целое — цикл без скачка).
  static const _tripsPerCycle = 12;
  static const _tailLength = 0.18;

  @override
  void paint(Canvas canvas, Size size) {
    final t = clock.value;
    for (final orbit in layout.orbits) {
      if (!orbit.friend.hasUnreadSnaps) continue;
      final target = layout.positionOf(orbit, t);
      final progress = (t * _tripsPerCycle + orbit.phase) % 1;
      final head = Offset.lerp(layout.center, target, progress)!;
      final tail = Offset.lerp(
        layout.center,
        target,
        (progress - _tailLength).clamp(0, 1),
      )!;
      // Комета гаснет у цели.
      final fade = progress < 0.85 ? 1.0 : (1 - progress) / 0.15;

      canvas
        ..drawLine(
          tail,
          head,
          Paint()
            ..strokeWidth = 2
            ..strokeCap = StrokeCap.round
            ..shader = LinearGradient(
              colors: [
                AppColors.mint.withValues(alpha: 0),
                AppColors.mint.withValues(alpha: 0.8 * fade),
              ],
            ).createShader(Rect.fromPoints(tail, head)),
        )
        ..drawCircle(
          head,
          3,
          Paint()
            ..color = AppColors.mint.withValues(alpha: fade)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
        );
    }
  }

  @override
  bool shouldRepaint(_CometsPainter oldDelegate) =>
      oldDelegate.layout != layout;
}
