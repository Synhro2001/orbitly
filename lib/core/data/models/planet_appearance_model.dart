import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';

part 'planet_appearance_model.freezed.dart';
part 'planet_appearance_model.g.dart';

@freezed
abstract class PlanetAppearanceModel with _$PlanetAppearanceModel {
  const factory PlanetAppearanceModel({
    required PlanetType type,
    required int seed,
    required double hue,
    @Default(0) int moons,
    @Default(false) bool hasRings,
    @Default(false) bool glows,
  }) = _PlanetAppearanceModel;

  factory PlanetAppearanceModel.fromJson(Map<String, Object?> json) =>
      _$PlanetAppearanceModelFromJson(json);

  factory PlanetAppearanceModel.fromEntity(PlanetAppearance e) =>
      PlanetAppearanceModel(
        type: e.type,
        seed: e.seed,
        hue: e.hue,
        moons: e.moons,
        hasRings: e.hasRings,
        glows: e.glows,
      );
}

extension PlanetAppearanceModelX on PlanetAppearanceModel {
  PlanetAppearance toEntity() => PlanetAppearance(
    type: type,
    seed: seed,
    hue: hue,
    moons: moons,
    hasRings: hasRings,
    glows: glows,
  );
}
