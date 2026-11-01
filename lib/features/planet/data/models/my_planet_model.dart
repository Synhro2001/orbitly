import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/core/data/models/shadow_json.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';

part 'my_planet_model.freezed.dart';
part 'my_planet_model.g.dart';

/// Строка `profiles` (мок хранит её в том же виде).
@freezed
abstract class MyPlanetModel with _$MyPlanetModel {
  const factory MyPlanetModel({
    required String planetName,
    required String handle,
    required PlanetAppearanceModel appearance,
    required int level,
    required int xp,
    required int bestStreakDays,
    @JsonKey(unknownEnumValue: Mood.calm) required Mood mood,
    DateTime? shadowFrom,
    DateTime? shadowUntil,
  }) = _MyPlanetModel;

  factory MyPlanetModel.fromJson(Map<String, Object?> json) =>
      _$MyPlanetModelFromJson(json);
}

/// Опыт, с которого начинается уровень `level + 1`. Обратная формула к
/// серверной `level = floor(sqrt(xp / 50)) + 1`: уровень 4 — это 450…800.
int xpForLevel(int level) => 50 * level * level;

extension MyPlanetModelX on MyPlanetModel {
  MyPlanet toEntity({required List<Cosmetic> equipped}) {
    final levelStart = xpForLevel(level - 1);
    final levelSpan = xpForLevel(level) - levelStart;
    return MyPlanet(
      name: planetName,
      handle: handle,
      baseAppearance: appearance.toEntity(),
      level: level,
      // На экране — опыт внутри текущего уровня.
      xp: (xp - levelStart).clamp(0, levelSpan),
      xpForNextLevel: levelSpan,
      bestStreakDays: bestStreakDays,
      mood: mood,
      equipped: equipped,
      shadow: shadowFromFields(shadowFrom, shadowUntil),
    );
  }
}
