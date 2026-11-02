import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_image_cache.dart';

void main() {
  PlanetAppearance planet(int seed) =>
      PlanetAppearance(type: PlanetType.ocean, seed: seed, hue: 200);

  testWidgets('memory stays within the byte budget', (tester) async {
    const pixels = 64;
    const oneImage = pixels * pixels * 4;
    // Exactly two images fit.
    final cache = PlanetImageCache.withBudget(oneImage * 2);

    await tester.runAsync(() async {
      await cache.render(planet(1), pixels);
      await cache.render(planet(2), pixels);
      await cache.render(planet(3), pixels);
    });

    expect(cache.bytes, lessThanOrEqualTo(oneImage * 2));
    expect(cache.get(planet(1), pixels), isNull, reason: 'oldest evicted');
    expect(cache.get(planet(3), pixels), isNotNull);
  });

  testWidgets('a recently shown planet is kept', (tester) async {
    const pixels = 64;
    final cache = PlanetImageCache.withBudget(pixels * pixels * 4 * 2);

    await tester.runAsync(() async {
      await cache.render(planet(1), pixels);
      await cache.render(planet(2), pixels);
      cache.get(planet(1), pixels); // снова на экране
      await cache.render(planet(3), pixels);
    });

    expect(cache.get(planet(1), pixels), isNotNull);
    expect(cache.get(planet(2), pixels), isNull);
  });
}
