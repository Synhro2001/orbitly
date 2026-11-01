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
  title: json['title'] as String?,
  description: json['description'] as String?,
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
  rewardTitle: json['reward_title'] as String?,
);

Map<String, dynamic> _$AwardModelToJson(_AwardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': _$AwardCategoryEnumMap[instance.category]!,
      'rarity': _$RarityEnumMap[instance.rarity]!,
      'title': instance.title,
      'description': instance.description,
      'icon': instance.icon,
      'hidden': instance.hidden,
      'pair': instance.pair,
      'progress': instance.progress,
      'target': instance.target,
      'unlocked_at': instance.unlockedAt?.toIso8601String(),
      'seen_at': instance.seenAt?.toIso8601String(),
      'reward_cosmetic_id': instance.rewardCosmeticId,
      'reward_title': instance.rewardTitle,
    };

const _$AwardCategoryEnumMap = {
  AwardCategory.friendship: 'friendship',
  AwardCategory.streak: 'streak',
  AwardCategory.closeness: 'closeness',
  AwardCategory.collection: 'collection',
  AwardCategory.secret: 'secret',
};

const _$RarityEnumMap = {
  Rarity.common: 'common',
  Rarity.rare: 'rare',
  Rarity.epic: 'epic',
  Rarity.legendary: 'legendary',
};
