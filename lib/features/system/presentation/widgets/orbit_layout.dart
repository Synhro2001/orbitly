import 'dart:math' as math;
import 'dart:ui';

import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/features/system/domain/usecases/calculate_orbit_radius.dart';

class FriendOrbit {
  const FriendOrbit({
    required this.friend,
    required this.radius,
    required this.phase,
    required this.turnsPerCycle,
    required this.planetSize,
  });

  final Friend friend;
  final double radius;
  final double phase;

  /// Целое число оборотов за цикл анимации — чтобы цикл замыкался без скачка.
  final int turnsPerCycle;
  final double planetSize;
}

/// Геометрия системы: где находится каждый друг в момент `t` (0–1 цикла).
class OrbitLayout {
  OrbitLayout({required Size size, required List<Friend> friends})
    : center = size.center(Offset.zero),
      // На узком экране планеты меньше, чтобы не налезали друг на друга.
      _scale = (size.shortestSide / AppSizes.systemReferenceSide).clamp(
        AppSizes.systemMinScale,
        1,
      ),
      // На вертикальном экране орбиты меньше сплющены, чтобы занять высоту.
      tilt = (size.height / size.width * AppSizes.orbitTiltPerAspect).clamp(
        AppSizes.orbitTiltMin,
        AppSizes.orbitTiltMax,
      ) {
    final friendMax = AppSizes.friendPlanetMax * _scale;
    final edgePadding = friendMax / 2;
    final rMax = math.min(
      size.width / 2 - edgePadding,
      (size.height / 2 - edgePadding) / tilt,
    );
    final rMin = mySize * PlanetPainter.bodyRadiusFactor + friendMax / 2;
    const calculateRadius = CalculateOrbitRadius();

    orbits = [
      for (final (i, friend) in friends.indexed)
        FriendOrbit(
          friend: friend,
          radius: calculateRadius(
            closeness: friend.closeness,
            rMin: rMin,
            rMax: math.max(rMin, rMax),
          ),
          phase: 2 * math.pi * i / friends.length,
          // Ближние орбиты обращаются быстрее, как в настоящей системе.
          turnsPerCycle: switch (friend.closeness) {
            >= 75 => 3,
            >= 40 => 2,
            _ => 1,
          },
          planetSize:
              lerpDouble(
                AppSizes.friendPlanetMin,
                AppSizes.friendPlanetMax,
                friend.closeness / 100,
              )! *
              _scale,
        ),
    ];
  }

  final Offset center;
  final double _scale;

  /// Сжатие орбит по вертикали — имитация наклона плоскости системы.
  final double tilt;
  late final List<FriendOrbit> orbits;

  double get mySize => AppSizes.myPlanetInSystem * _scale;

  double angleOf(FriendOrbit orbit, double t) =>
      orbit.phase + 2 * math.pi * orbit.turnsPerCycle * t;

  Offset positionOf(FriendOrbit orbit, double t) {
    final angle = angleOf(orbit, t);
    return center +
        Offset(
          math.cos(angle) * orbit.radius,
          math.sin(angle) * orbit.radius * tilt,
        );
  }

  /// −1 — дальний край орбиты (за солнцем), 1 — ближний.
  double depthOf(FriendOrbit orbit, double t) => math.sin(angleOf(orbit, t));
}
