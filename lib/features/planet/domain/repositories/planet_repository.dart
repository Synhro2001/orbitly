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

    /// The user confirmed being 18 or older; the server refuses otherwise.
    required bool isAdult,
  });

  Future<void> setMood(Mood mood);

  /// The shadow starts now and lasts [duration] (the server allows 1–7 days).
  Future<void> enterShadow(Duration duration);

  /// Leave early: the shadow ends now.
  Future<void> leaveShadow();
}
