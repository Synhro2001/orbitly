import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/domain/usecases/apply_cosmetics.dart';

part 'my_planet.freezed.dart';

@freezed
abstract class MyPlanet with _$MyPlanet {
  const factory MyPlanet({
    required String name,
    required String handle,

    /// Вид, выбранный при создании: тип, seed, оттенок.
    required PlanetAppearance baseAppearance,
    required int level,
    required int xp,
    required int xpForNextLevel,
    required int bestStreakDays,
    required Mood mood,

    /// Надетые награды.
    @Default([]) List<Cosmetic> equipped,
    Shadow? shadow,
  }) = _MyPlanet;

  const MyPlanet._();

  /// Как планета выглядит на самом деле: база + надетые награды.
  PlanetAppearance get appearance =>
      const ApplyCosmetics()(baseAppearance, equipped);

  /// Прогресс до следующего уровня, 0–1.
  double get levelProgress =>
      xpForNextLevel <= 0 ? 1 : (xp / xpForNextLevel).clamp(0, 1);
}
