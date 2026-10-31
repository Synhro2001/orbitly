// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'planet_appearance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanetAppearanceModel _$PlanetAppearanceModelFromJson(
  Map<String, dynamic> json,
) => _PlanetAppearanceModel(
  type: $enumDecode(_$PlanetTypeEnumMap, json['type']),
  seed: (json['seed'] as num).toInt(),
  hue: (json['hue'] as num).toDouble(),
  moons: (json['moons'] as num?)?.toInt() ?? 0,
  hasRings: json['has_rings'] as bool? ?? false,
  glows: json['glows'] as bool? ?? false,
);

Map<String, dynamic> _$PlanetAppearanceModelToJson(
  _PlanetAppearanceModel instance,
) => <String, dynamic>{
  'type': _$PlanetTypeEnumMap[instance.type]!,
  'seed': instance.seed,
  'hue': instance.hue,
  'moons': instance.moons,
  'has_rings': instance.hasRings,
  'glows': instance.glows,
};

const _$PlanetTypeEnumMap = {
  PlanetType.ocean: 'ocean',
  PlanetType.lava: 'lava',
  PlanetType.ice: 'ice',
  PlanetType.jungle: 'jungle',
  PlanetType.candy: 'candy',
  PlanetType.crystal: 'crystal',
  PlanetType.gas: 'gas',
};
