// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'award_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AwardModel _$AwardModelFromJson(Map<String, dynamic> json) => _AwardModel(
  id: json['id'] as String,
  category:
      $enumDecodeNullable(
        _$AwardCategoryEnumMap,
        json['category'],
        unknownValue: AwardCategory.collection,
      ) ??
      AwardCategory.collection,
  rarity:
      $enumDecodeNullable(
        _$RarityEnumMap,
        json['rarity'],
        unknownValue: Rarity.common,
      ) ??
      Rarity.common,
  title: _$JsonConverterFromJson<Object, LocalizedText>(
    json['title'],
    const LocalizedTextConverter().fromJson,
  ),
  description: _$JsonConverterFromJson<Object, LocalizedText>(
    json['description'],
    const LocalizedTextConverter().fromJson,
  ),
  icon: json['icon'] as String?,
  hidden: json['hidden'] as bool? ?? false,
  pair: json['pair'] as bool? ?? false,
  progress: (json['progress'] as num?)?.toInt(),
  target: (json['target'] as num?)?.toInt(),
  unlockedAt: json['unlocked_at'] == null
      ? null
      : DateTime.parse(json['unlocked_at'] as String),
  seenAt: json['seen_at'] == null
      ? null
      : DateTime.parse(json['seen_at'] as String),
  rewardCosmeticId: json['reward_cosmetic_id'] as String?,
  rewardTitle: _$JsonConverterFromJson<Object, LocalizedText>(
    json['reward_title'],
    const LocalizedTextConverter().fromJson,
  ),
);

Map<String, dynamic> _$AwardModelToJson(_AwardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': _$AwardCategoryEnumMap[instance.category]!,
      'rarity': _$RarityEnumMap[instance.rarity]!,
      'title': _$JsonConverterToJson<Object, LocalizedText>(
        instance.title,
        const LocalizedTextConverter().toJson,
      ),
      'description': _$JsonConverterToJson<Object, LocalizedText>(
        instance.description,
        const LocalizedTextConverter().toJson,
      ),
      'icon': instance.icon,
      'hidden': instance.hidden,
      'pair': instance.pair,
      'progress': instance.progress,
      'target': instance.target,
      'unlocked_at': instance.unlockedAt?.toIso8601String(),
      'seen_at': instance.seenAt?.toIso8601String(),
      'reward_cosmetic_id': instance.rewardCosmeticId,
      'reward_title': _$JsonConverterToJson<Object, LocalizedText>(
        instance.rewardTitle,
        const LocalizedTextConverter().toJson,
      ),
    };

const _$AwardCategoryEnumMap = {
  AwardCategory.friendship: 'friendship',
  AwardCategory.streak: 'streak',
  AwardCategory.closeness: 'closeness',
  AwardCategory.collection: 'collection',
  AwardCategory.secret: 'secret',
  AwardCategory.photo: 'photo',
};

const _$RarityEnumMap = {
  Rarity.common: 'common',
  Rarity.rare: 'rare',
  Rarity.epic: 'epic',
  Rarity.legendary: 'legendary',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
