import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';

part 'planet_appearance_model.freezed.dart';
part 'planet_appearance_model.g.dart';

@freezed
abstract class PlanetAppearanceModel with _$PlanetAppearanceModel {
  const factory PlanetAppearanceModel({
    // Неизвестный тип (новая версия сервера) не ломает список друзей.
    @JsonKey(unknownEnumValue: PlanetType.ocean) required PlanetType type,
    required int seed,
    required double hue,
    @Default(0) int moons,
    @Default(false) bool hasRings,
    @JsonKey(unknownEnumValue: GlowStyle.none)
    @Default(GlowStyle.none)
    GlowStyle glow,
    @JsonKey(unknownEnumValue: MoonSkin.plain)
    @Default(MoonSkin.plain)
    MoonSkin moonSkin,
    @Default(false) bool hasCometTrail,
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
        glow: e.glow,
        moonSkin: e.moonSkin,
        hasCometTrail: e.hasCometTrail,
      );
}

extension PlanetAppearanceModelX on PlanetAppearanceModel {
  PlanetAppearance toEntity() => PlanetAppearance(
    type: type,
    seed: seed,
    hue: hue,
    moons: moons,
    hasRings: hasRings,
    glow: glow,
    moonSkin: moonSkin,
    hasCometTrail: hasCometTrail,
  );
}
