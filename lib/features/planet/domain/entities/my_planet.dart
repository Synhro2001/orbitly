import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';

part 'my_planet.freezed.dart';

@freezed
abstract class MyPlanet with _$MyPlanet {
  const factory MyPlanet({
    required String name,
    required PlanetAppearance appearance,
    required int level,
    required int xp,
    required int xpForNextLevel,
    required int bestStreakDays,
    required Mood mood,
    required List<Award> awards,
    Shadow? shadow,
  }) = _MyPlanet;

  const MyPlanet._();

  /// Прогресс до следующего уровня, 0–1.
  double get levelProgress =>
      xpForNextLevel <= 0 ? 1 : (xp / xpForNextLevel).clamp(0, 1);
}
