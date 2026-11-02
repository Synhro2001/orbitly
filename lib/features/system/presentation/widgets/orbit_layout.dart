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

  /// Whole number of turns per animation cycle, so the loop has no jump.
  final int turnsPerCycle;
  final double planetSize;
}

/// System geometry: where each friend is at time `t` (0–1 of a cycle).
///
/// `area` is the visible part of the screen between the header and the
/// bottom bar; friend orbits fit inside it. The dust disk goes beyond it.
class OrbitLayout {
  OrbitLayout({required Rect area, required List<Friend> friends})
    : center = area.center,
      // Smaller planets on narrow screens so they do not overlap.
      _scale = (area.shortestSide / AppSizes.systemReferenceSide).clamp(
        AppSizes.systemMinScale,
        1,
      ),
      // On tall screens the orbits are less squashed to use the height.
      tilt = (area.height / area.width * AppSizes.orbitTiltPerAspect).clamp(
        AppSizes.orbitTiltMin,
        AppSizes.orbitTiltMax,
      ) {
    final friendMax = AppSizes.friendPlanetMax * _scale;
    final edgePadding = friendMax / 2;
    innerRadius = mySize * PlanetPainter.bodyRadiusFactor + friendMax / 2;
    outerRadius = math.max(
      innerRadius,
      math.min(
        area.width / 2 - edgePadding,
        (area.height / 2 - edgePadding) / tilt,
      ),
    );
    const calculateRadius = CalculateOrbitRadius();

    orbits = [
      for (final (i, friend) in friends.indexed)
        FriendOrbit(
          friend: friend,
          radius: calculateRadius(
            closeness: friend.closeness,
            rMin: innerRadius,
            rMax: outerRadius,
          ),
          phase: 2 * math.pi * i / friends.length,
          // Inner orbits move faster, as in a real planetary system.
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

  /// Vertical squash of the orbits: fakes the tilt of the system plane.
  final double tilt;
  late final double innerRadius;
  late final double outerRadius;
  late final List<FriendOrbit> orbits;

  double get mySize => AppSizes.myPlanetInSystem * _scale;

  /// A point on the tilted system plane.
  Offset pointAt(double angle, double radius) =>
      center +
      Offset(math.cos(angle) * radius, math.sin(angle) * radius * tilt);

  double angleOf(FriendOrbit orbit, double t) =>
      orbit.phase + 2 * math.pi * orbit.turnsPerCycle * t;

  Offset positionOf(FriendOrbit orbit, double t) =>
      pointAt(angleOf(orbit, t), orbit.radius);

  /// −1 is the far side of the orbit (behind the sun), 1 the near side.
  double depthOf(FriendOrbit orbit, double t) => math.sin(angleOf(orbit, t));
}
