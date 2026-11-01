import 'package:freezed_annotation/freezed_annotation.dart';

part 'planet_appearance.freezed.dart';

enum PlanetType { ocean, lava, ice, jungle, candy, crystal, gas }

/// Внешний вид планеты. По одному и тому же описанию всегда рисуется
/// одна и та же планета.
@freezed
abstract class PlanetAppearance with _$PlanetAppearance {
  const factory PlanetAppearance({
    required PlanetType type,
    required int seed,

    /// Основной оттенок, градусы 0–360.
    required double hue,
    @Default(0) int moons,
    @Default(false) bool hasRings,
    @Default(false) bool glows,
  }) = _PlanetAppearance;
}
