import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';

abstract interface class PlanetRepository {
  Future<bool> hasPlanet();

  Future<MyPlanet> getMyPlanet();

  Future<void> createPlanet({
    required String name,
    required PlanetAppearance appearance,
  });

  Future<void> setMood(Mood mood);

  /// Уйти в тень или изменить её срок (досрочный выход — `until` = сейчас).
  Future<void> setShadow(Shadow? shadow);
}
