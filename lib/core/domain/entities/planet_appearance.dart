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

  // Rare types: unlocked by achievements, not available when creating a planet.
  nebula,
  blackHole,
  aurora,
  solarCorona,
  gemini,
  ringWorld;

  bool get isRare => index >= nebula.index;

  /// Types that can be picked when creating a planet.
  static List<PlanetType> get base => [
    for (final type in values)
      if (!type.isRare) type,
  ];
}

enum GlowStyle { none, soft, aurora, doubleStar }

enum MoonSkin { plain, hourglass }

/// How a planet looks. The same description always draws the same planet.
@freezed
abstract class PlanetAppearance with _$PlanetAppearance {
  const factory PlanetAppearance({
    required PlanetType type,
    required int seed,

    /// Main hue, degrees 0–360.
    required double hue,
    @Default(0) int moons,
    @Default(false) bool hasRings,
    @Default(GlowStyle.none) GlowStyle glow,
    @Default(MoonSkin.plain) MoonSkin moonSkin,
    @Default(false) bool hasCometTrail,
  }) = _PlanetAppearance;
}
