import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';

/// Turns worn cosmetics into the planet's final appearance.
///
/// The base (type, seed, hue) is chosen when the planet is created; the rest
/// comes from rewards. At most one item of each kind is worn; if several
/// arrive, the last one wins. Unknown parameters (from a newer server) are
/// skipped, and the planet stays as it was.
class ApplyCosmetics {
  const ApplyCosmetics();

  static const maxMoons = 3;

  PlanetAppearance call(PlanetAppearance base, Iterable<Cosmetic> equipped) {
    var result = base;
    for (final cosmetic in equipped) {
      final params = cosmetic.params;
      result = switch (cosmetic.kind) {
        CosmeticKind.planetType => switch (_byName(
          PlanetType.values,
          params['type'],
        )) {
          final type? => result.copyWith(type: type),
          null => result,
        },
        CosmeticKind.moon => result.copyWith(
          moons: switch (params['moons']) {
            final num n => n.toInt().clamp(0, maxMoons),
            _ => 1,
          },
          moonSkin: _byName(MoonSkin.values, params['skin']) ?? MoonSkin.plain,
        ),
        CosmeticKind.ring => result.copyWith(hasRings: true),
        CosmeticKind.glow => result.copyWith(
          glow: _byName(GlowStyle.values, params['style']) ?? GlowStyle.soft,
        ),
        CosmeticKind.cometTrail => result.copyWith(hasCometTrail: true),
      };
    }
    return result;
  }

  static T? _byName<T extends Enum>(List<T> values, Object? name) {
    for (final value in values) {
      if (value.name == name) return value;
    }
    return null;
  }
}
