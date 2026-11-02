import 'package:flutter/material.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';
import 'package:orbitly/core/widgets/planet_view.dart';

/// Just the planet disc, without rings or moons, fitted into [diameter].
/// For avatars: moments, the level chip, the chat header.
class PlanetDisc extends StatelessWidget {
  const PlanetDisc({
    required this.appearance,
    required this.diameter,
    super.key,
  });

  final PlanetAppearance appearance;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    // The planet canvas is larger than its body (the body is
    // bodyRadiusFactor of the side). Scale up a little so the disc fills
    // the circle without dark edges.
    final canvas = diameter / (PlanetPainter.bodyRadiusFactor * 2) * 0.92;
    return ClipOval(
      child: SizedBox.square(
        dimension: diameter,
        child: OverflowBox(
          maxWidth: canvas,
          maxHeight: canvas,
          child: PlanetView(appearance: appearance, size: canvas),
        ),
      ),
    );
  }
}
