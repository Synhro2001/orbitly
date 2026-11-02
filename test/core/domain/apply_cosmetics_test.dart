import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/localized_text.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/domain/usecases/apply_cosmetics.dart';

void main() {
  const apply = ApplyCosmetics();
  const base = PlanetAppearance(type: PlanetType.ocean, seed: 7, hue: 200);

  Cosmetic cosmetic(
    CosmeticKind kind, [
    Map<String, Object?> params = const {},
  ]) => Cosmetic(
    id: kind.name,
    title: LocalizedText({'en': kind.name}),
    kind: kind,
    rarity: Rarity.common,
    params: params,
    equipped: true,
  );

  test('nothing equipped — the base planet', () {
    expect(apply(base, const []), base);
  });

  test('a rare planet type replaces the base type but keeps seed and hue', () {
    final result = apply(base, [
      cosmetic(CosmeticKind.planetType, {'type': 'nebula'}),
    ]);
    expect(result.type, PlanetType.nebula);
    expect(result.seed, base.seed);
    expect(result.hue, base.hue);
  });

  test('moons: count from params, clamped, with a skin', () {
    expect(
      apply(base, [
        cosmetic(CosmeticKind.moon, {'moons': 2}),
      ]).moons,
      2,
    );
    expect(
      apply(base, [
        cosmetic(CosmeticKind.moon, {'moons': 99}),
      ]).moons,
      ApplyCosmetics.maxMoons,
    );
    final hourglass = apply(base, [
      cosmetic(CosmeticKind.moon, {'moons': 1, 'skin': 'hourglass'}),
    ]);
    expect(hourglass.moonSkin, MoonSkin.hourglass);
    expect(hourglass.moons, 1);
  });

  test('rings, glow and comet trail', () {
    final result = apply(base, [
      cosmetic(CosmeticKind.ring),
      cosmetic(CosmeticKind.glow, {'style': 'doubleStar'}),
      cosmetic(CosmeticKind.cometTrail),
    ]);
    expect(result.hasRings, isTrue);
    expect(result.glow, GlowStyle.doubleStar);
    expect(result.hasCometTrail, isTrue);
  });

  test('unknown values from a newer server are ignored safely', () {
    final result = apply(base, [
      cosmetic(CosmeticKind.planetType, {'type': 'quasar'}),
      cosmetic(CosmeticKind.glow, {'style': 'rainbow'}),
      cosmetic(CosmeticKind.moon, {'moons': 'many'}),
    ]);
    expect(result.type, PlanetType.ocean);
    expect(result.glow, GlowStyle.soft);
    expect(result.moons, 1);
  });

  test('the same input always gives the same planet', () {
    final equipped = [
      cosmetic(CosmeticKind.planetType, {'type': 'gemini'}),
      cosmetic(CosmeticKind.ring),
    ];
    expect(apply(base, equipped), apply(base, equipped));
  });

  test('rare types are not offered when creating a planet', () {
    expect(PlanetType.base, isNot(contains(PlanetType.nebula)));
    expect(PlanetType.base, hasLength(7));
  });
}
