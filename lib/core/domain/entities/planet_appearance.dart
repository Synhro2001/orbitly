import 'package:freezed_annotation/freezed_annotation.dart';

part 'planet_appearance.freezed.dart';

enum PlanetType {
  ocean,
  lava,
  ice,
  jungle,
  candy,
  crystal,
  gas,

  // Редкие типы: открываются достижениями, при создании планеты недоступны.
  nebula,
  blackHole,
  aurora,
  solarCorona,
  gemini,
  ringWorld;

  bool get isRare => index >= nebula.index;

  /// Типы, которые можно выбрать при создании планеты.
  static List<PlanetType> get base => [
    for (final type in values)
      if (!type.isRare) type,
  ];
}

enum GlowStyle { none, soft, aurora, doubleStar }

enum MoonSkin { plain, hourglass }

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
    @Default(GlowStyle.none) GlowStyle glow,
    @Default(MoonSkin.plain) MoonSkin moonSkin,
    @Default(false) bool hasCometTrail,
  }) = _PlanetAppearance;
}
