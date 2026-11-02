import 'package:flutter/material.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';
import 'package:orbitly/core/widgets/planet_view.dart';

/// Только диск планеты, без колец и спутников, вписанный в круг [diameter].
/// Для аватарок: моменты, чип уровня, заголовок чата.
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
    // Холст планеты больше её тела: тело — доля bodyRadiusFactor от стороны.
    // Чуть увеличиваем, чтобы диск заполнил круг без тёмных полей.
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
