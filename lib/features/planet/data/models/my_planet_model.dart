import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';

part 'my_planet_model.freezed.dart';
part 'my_planet_model.g.dart';

@freezed
abstract class MyPlanetModel with _$MyPlanetModel {
  const factory MyPlanetModel({
    required String name,
    required PlanetAppearanceModel appearance,
    required int level,
    required int xp,
    required int xpForNextLevel,
    required int bestStreakDays,
    required Mood mood,
    DateTime? shadowFrom,
    DateTime? shadowUntil,
  }) = _MyPlanetModel;

  factory MyPlanetModel.fromJson(Map<String, Object?> json) =>
      _$MyPlanetModelFromJson(json);
}

extension MyPlanetModelX on MyPlanetModel {
  MyPlanet toEntity({required List<Award> awards}) => MyPlanet(
    name: name,
    appearance: appearance.toEntity(),
    level: level,
    xp: xp,
    xpForNextLevel: xpForNextLevel,
    bestStreakDays: bestStreakDays,
    mood: mood,
    awards: awards,
    shadow: shadowFrom != null && shadowUntil != null
        ? Shadow(from: shadowFrom!, until: shadowUntil!)
        : null,
  );
}
