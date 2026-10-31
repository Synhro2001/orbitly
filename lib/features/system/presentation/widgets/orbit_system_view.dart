import 'dart:math' as math;
import 'dart:ui' show PointMode;

import 'package:flutter/material.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';
import 'package:orbitly/core/planet_render/seeded_random.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/system/presentation/widgets/orbit_layout.dart';

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
                CustomPaint(size: size, painter: _DustPainter(layout, _clock)),
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

class _FriendPlanet extends StatelessWidget {
  const _FriendPlanet({required this.orbit, required this.onTap});

  final FriendOrbit orbit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final friend = orbit.friend;
    final l10n = context.l10n;
    final bodySize = orbit.planetSize * PlanetPainter.bodyRadiusFactor * 2;
    final unread = friend.hasUnreadSnaps;
    return Semantics(
      button: true,
      label: unread
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
            PlanetView(appearance: friend.appearance, size: orbit.planetSize),
            Positioned(
              top: _tapBoxOf(orbit) / 2 + bodySize / 2,
              child: Text(
                friend.name,
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

/// Статичная часть: внешние кольца диска, свечение солнца, орбиты друзей.
class _OrbitsPainter extends CustomPainter {
  const _OrbitsPainter(this.layout);

  final OrbitLayout layout;

  Rect _ellipse(double radius) => Rect.fromCenter(
    center: layout.center,
    width: radius * 2,
    height: radius * 2 * layout.tilt,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final edge = layout.outerRadius * AppSizes.dustOuterFactor;
    // Широкая светлая полоса по краю диска и тонкие кольца внутри.
    canvas.drawOval(
      _ellipse(edge),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = edge * 0.08
        ..color = AppColors.star.withValues(alpha: 0.05),
    );
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.orbitLine;
    for (final factor in const [1.35, 1.7, 2.1, 2.5, 2.8]) {
      canvas.drawOval(_ellipse(layout.outerRadius * factor), ring);
    }

    final glowRadius = layout.mySize * 0.95;
    canvas.drawCircle(
      layout.center,
      glowRadius,
      Paint()
        ..shader =
            RadialGradient(
              colors: [
                AppColors.sun.withValues(alpha: 0.45),
                AppColors.sun.withValues(alpha: 0.12),
                AppColors.sun.withValues(alpha: 0),
              ],
              stops: const [0, 0.45, 1],
            ).createShader(
              Rect.fromCircle(center: layout.center, radius: glowRadius),
            ),
    );

    final orbitPaint = Paint()
      ..color = AppColors.orbitLine
      ..style = PaintingStyle.stroke;
    for (final orbit in layout.orbits) {
      canvas.drawOval(_ellipse(orbit.radius), orbitPaint);
    }
  }

  @override
  bool shouldRepaint(_OrbitsPainter oldDelegate) =>
      oldDelegate.layout != layout;
}

/// Медленно вращающийся пылевой диск: сотни точек на плоскости системы.
/// Точки за солнцем тусклее — так видна глубина.
class _DustPainter extends CustomPainter {
  _DustPainter(this.layout, this.clock) : super(repaint: clock);

  final OrbitLayout layout;
  final Animation<double> clock;

  /// (доля радиуса 0–1, начальный угол, индекс цвета, крупная ли точка).
  static final List<(double, double, int, bool)> _particles = () {
    final rnd = SeededRandom(2026);
    return [
      for (var i = 0; i < AppSizes.dustParticles; i++)
        (
          // Больше точек ближе к центру.
          math.pow(rnd.nextDouble(), 1.4).toDouble(),
          rnd.range(0, 2 * math.pi),
          // Половина точек — белые звёзды, остальные цветные.
          rnd.nextDouble() < 0.5
              ? 0
              : 1 + rnd.nextInt(AppColors.dust.length - 1),
          rnd.nextDouble() < 0.25,
        ),
    ];
  }();

  @override
  void paint(Canvas canvas, Size size) {
    final rotation = 2 * math.pi * clock.value;
    final from = layout.innerRadius * 0.8;
    final to = layout.outerRadius * AppSizes.dustOuterFactor;

    // Группируем точки по цвету, размеру и стороне — несколько вызовов
    // drawPoints на кадр вместо сотен drawCircle.
    final groups = <(int, bool, bool), List<Offset>>{};
    for (final (r, angle, color, big) in _particles) {
      final a = angle + rotation;
      final far = math.sin(a) < 0;
      (groups[(color, big, far)] ??= []).add(
        layout.pointAt(a, from + r * (to - from)),
      );
    }
    final paint = Paint()..strokeCap = StrokeCap.round;
    for (final MapEntry(key: (color, big, far), value: points)
        in groups.entries) {
      paint
        ..strokeWidth = big ? 3 : 1.6
        ..color = AppColors.dust[color].withValues(alpha: far ? 0.4 : 0.85);
      canvas.drawPoints(PointMode.points, points, paint);
    }
  }

  @override
  bool shouldRepaint(_DustPainter oldDelegate) => oldDelegate.layout != layout;
}

/// Кометы летят от моей планеты к друзьям, у которых есть непрочитанное.
class _CometsPainter extends CustomPainter {
  _CometsPainter(this.layout, this.clock) : super(repaint: clock);

  final OrbitLayout layout;
  final Animation<double> clock;

  /// Сколько раз комета долетает за цикл (целое — цикл без скачка).
  static const _tripsPerCycle = 24;
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
