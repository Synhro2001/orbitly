// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'my_planet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MyPlanetModel _$MyPlanetModelFromJson(Map<String, dynamic> json) =>
    _MyPlanetModel(
      name: json['name'] as String,
      appearance: PlanetAppearanceModel.fromJson(
        json['appearance'] as Map<String, dynamic>,
      ),
      level: (json['level'] as num).toInt(),
      xp: (json['xp'] as num).toInt(),
      xpForNextLevel: (json['xp_for_next_level'] as num).toInt(),
      bestStreakDays: (json['best_streak_days'] as num).toInt(),
      mood: $enumDecode(_$MoodEnumMap, json['mood']),
      shadowFrom: json['shadow_from'] == null
          ? null
          : DateTime.parse(json['shadow_from'] as String),
      shadowUntil: json['shadow_until'] == null
          ? null
          : DateTime.parse(json['shadow_until'] as String),
    );

Map<String, dynamic> _$MyPlanetModelToJson(_MyPlanetModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'appearance': instance.appearance.toJson(),
      'level': instance.level,
      'xp': instance.xp,
      'xp_for_next_level': instance.xpForNextLevel,
      'best_streak_days': instance.bestStreakDays,
      'mood': _$MoodEnumMap[instance.mood]!,
      'shadow_from': instance.shadowFrom?.toIso8601String(),
      'shadow_until': instance.shadowUntil?.toIso8601String(),
    };

const _$MoodEnumMap = {
  Mood.happy: 'happy',
  Mood.calm: 'calm',
  Mood.inLove: 'inLove',
  Mood.excited: 'excited',
  Mood.tired: 'tired',
  Mood.sad: 'sad',
};
