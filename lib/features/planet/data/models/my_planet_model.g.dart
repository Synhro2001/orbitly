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
    };

const _$MoodEnumMap = {
  Mood.happy: 'happy',
  Mood.calm: 'calm',
  Mood.inLove: 'inLove',
  Mood.excited: 'excited',
  Mood.tired: 'tired',
  Mood.sad: 'sad',
};
