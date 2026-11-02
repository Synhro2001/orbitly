import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/features/planet/data/models/my_planet_model.dart';

/// The server computes the level: level = floor(sqrt(xp / 50)) + 1.
/// The app shows XP within the current level.
void main() {
  Map<String, Object?> profile({required int level, required int xp}) => {
    'planet_name': 'Лазурия',
    'handle': 'anya.sky',
    'appearance': {'type': 'ocean', 'seed': 1, 'hue': 190},
    'level': level,
    'xp': xp,
    'best_streak_days': 6,
    'mood': 'happy',
  };

  test('level 4 spans 450…800 XP', () {
    final planet = MyPlanetModel.fromJson(profile(level: 4, xp: 600))
        .toEntity(equipped: const []);

    expect(planet.xp, 150);
    expect(planet.xpForNextLevel, 350);
    expect(planet.levelProgress, closeTo(150 / 350, 1e-9));
  });

  test('a brand new planet starts at zero', () {
    final planet = MyPlanetModel.fromJson(profile(level: 1, xp: 0))
        .toEntity(equipped: const []);

    expect(planet.xp, 0);
    expect(planet.xpForNextLevel, 50);
  });

  test('inconsistent data never shows more XP than the level holds', () {
    final planet = MyPlanetModel.fromJson(profile(level: 4, xp: 1000))
        .toEntity(equipped: const []);

    expect(planet.xp, lessThanOrEqualTo(planet.xpForNextLevel));
  });
}
