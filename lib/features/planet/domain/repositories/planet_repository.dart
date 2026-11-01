import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';

abstract interface class PlanetRepository {
  Future<bool> hasPlanet();

  Future<MyPlanet> getMyPlanet();

  Future<void> createPlanet({
    required String displayName,
    required String name,
    required PlanetAppearance appearance,
  });

  Future<void> setMood(Mood mood);

  /// Тень начинается сейчас и длится [duration] (сервер разрешает 1–7 дней).
  Future<void> enterShadow(Duration duration);

  /// Досрочный выход: тень заканчивается сейчас.
  Future<void> leaveShadow();
}
