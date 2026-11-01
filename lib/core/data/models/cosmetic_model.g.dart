// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'cosmetic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CosmeticModel _$CosmeticModelFromJson(Map<String, dynamic> json) =>
    _CosmeticModel(
      id: json['id'] as String,
      title: json['title'] as String,
      kind: json['kind'] as String,
      rarity:
          $enumDecodeNullable(
            _$RarityEnumMap,
            json['rarity'],
            unknownValue: Rarity.common,
          ) ??
          Rarity.common,
      params:
          json['params'] as Map<String, dynamic>? ?? const <String, Object?>{},
      equipped: json['equipped'] as bool? ?? false,
    );

Map<String, dynamic> _$CosmeticModelToJson(_CosmeticModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'kind': instance.kind,
      'rarity': _$RarityEnumMap[instance.rarity]!,
      'params': instance.params,
      'equipped': instance.equipped,
    };

const _$RarityEnumMap = {
  Rarity.common: 'common',
  Rarity.rare: 'rare',
  Rarity.epic: 'epic',
  Rarity.legendary: 'legendary',
};
