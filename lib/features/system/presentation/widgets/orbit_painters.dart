import 'dart:math' as math;
import 'dart:ui' show PointMode;

import 'package:flutter/material.dart';
import 'package:orbitly/core/planet_render/seeded_random.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/features/system/presentation/widgets/orbit_layout.dart';

// Слои фона системы. Рисуются под планетами в OrbitSystemView.

/// Статичная часть: внешние кольца диска, свечение солнца, орбиты друзей.
class OrbitsPainter extends CustomPainter {
  const OrbitsPainter(this.layout);

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
  bool shouldRepaint(OrbitsPainter oldDelegate) => oldDelegate.layout != layout;
}

/// Медленно вращающийся пылевой диск: сотни точек на плоскости системы.
/// Точки за солнцем тусклее — так видна глубина.
class DustPainter extends CustomPainter {
  DustPainter(this.layout, this.clock) : super(repaint: clock);

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
  bool shouldRepaint(DustPainter oldDelegate) => oldDelegate.layout != layout;
}

/// Кометы летят от моей планеты к друзьям, у которых есть непрочитанное.
class CometsPainter extends CustomPainter {
  CometsPainter(this.layout, this.clock) : super(repaint: clock);

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
        // Голова — градиент, а не размытие: дешевле на каждом кадре.
        ..drawCircle(
          head,
          5,
          Paint()
            ..shader = RadialGradient(
              colors: [
                AppColors.mint.withValues(alpha: fade),
                AppColors.mint.withValues(alpha: 0),
              ],
            ).createShader(Rect.fromCircle(center: head, radius: 5)),
        );
    }
  }

  @override
  bool shouldRepaint(CometsPainter oldDelegate) => oldDelegate.layout != layout;
}
