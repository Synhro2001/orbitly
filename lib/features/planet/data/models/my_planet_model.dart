import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/core/data/models/shadow_json.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';

part 'my_planet_model.freezed.dart';
part 'my_planet_model.g.dart';

/// A `profiles` row (the mock keeps it in the same shape).
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
    @Default('') String displayName,
    DateTime? handleChangedAt,
    DateTime? shadowFrom,
    DateTime? shadowUntil,
  }) = _MyPlanetModel;

  factory MyPlanetModel.fromJson(Map<String, Object?> json) =>
      _$MyPlanetModelFromJson(json);
}

/// XP at which level `level + 1` starts. The inverse of the server's
/// `level = floor(sqrt(xp / 50)) + 1`: level 4 spans 450…800.
int xpForLevel(int level) => 50 * level * level;

extension MyPlanetModelX on MyPlanetModel {
  MyPlanet toEntity({required List<Cosmetic> equipped}) {
    final levelStart = xpForLevel(level - 1);
    final levelSpan = xpForLevel(level) - levelStart;
    return MyPlanet(
      name: planetName,
      handle: handle,
      displayName: displayName,
      handleChangedAt: handleChangedAt,
      baseAppearance: appearance.toEntity(),
      level: level,
      // The screen shows XP within the current level.
      xp: (xp - levelStart).clamp(0, levelSpan),
      xpForNextLevel: levelSpan,
      bestStreakDays: bestStreakDays,
      mood: mood,
      equipped: equipped,
      shadow: shadowFromFields(shadowFrom, shadowUntil),
    );
  }
}
