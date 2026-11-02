// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'planet_appearance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanetAppearanceModel _$PlanetAppearanceModelFromJson(
  Map<String, dynamic> json,
) => _PlanetAppearanceModel(
  type: $enumDecode(
    _$PlanetTypeEnumMap,
    json['type'],
    unknownValue: PlanetType.ocean,
  ),
  seed: (json['seed'] as num).toInt(),
  hue: (json['hue'] as num).toDouble(),
  moons: (json['moons'] as num?)?.toInt() ?? 0,
  hasRings: json['has_rings'] as bool? ?? false,
  glow:
      $enumDecodeNullable(
        _$GlowStyleEnumMap,
        json['glow'],
        unknownValue: GlowStyle.none,
      ) ??
      GlowStyle.none,
  moonSkin:
      $enumDecodeNullable(
        _$MoonSkinEnumMap,
        json['moon_skin'],
        unknownValue: MoonSkin.plain,
      ) ??
      MoonSkin.plain,
  hasCometTrail: json['has_comet_trail'] as bool? ?? false,
);

Map<String, dynamic> _$PlanetAppearanceModelToJson(
  _PlanetAppearanceModel instance,
) => <String, dynamic>{
  'type': _$PlanetTypeEnumMap[instance.type]!,
  'seed': instance.seed,
  'hue': instance.hue,
  'moons': instance.moons,
  'has_rings': instance.hasRings,
  'glow': _$GlowStyleEnumMap[instance.glow]!,
  'moon_skin': _$MoonSkinEnumMap[instance.moonSkin]!,
  'has_comet_trail': instance.hasCometTrail,
};

const _$PlanetTypeEnumMap = {
  PlanetType.ocean: 'ocean',
  PlanetType.lava: 'lava',
  PlanetType.ice: 'ice',
  PlanetType.jungle: 'jungle',
  PlanetType.candy: 'candy',
  PlanetType.crystal: 'crystal',
  PlanetType.gas: 'gas',
  PlanetType.nebula: 'nebula',
  PlanetType.blackHole: 'blackHole',
  PlanetType.aurora: 'aurora',
  PlanetType.solarCorona: 'solarCorona',
  PlanetType.gemini: 'gemini',
  PlanetType.ringWorld: 'ringWorld',
};

const _$GlowStyleEnumMap = {
  GlowStyle.none: 'none',
  GlowStyle.soft: 'soft',
  GlowStyle.aurora: 'aurora',
  GlowStyle.doubleStar: 'doubleStar',
};

const _$MoonSkinEnumMap = {
  MoonSkin.plain: 'plain',
  MoonSkin.hourglass: 'hourglass',
};
