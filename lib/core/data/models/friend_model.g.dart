// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendModel _$FriendModelFromJson(Map<String, dynamic> json) => _FriendModel(
  id: json['id'] as String,
  name: json['name'] as String,
  handle: json['handle'] as String,
  appearance: PlanetAppearanceModel.fromJson(
    json['appearance'] as Map<String, dynamic>,
  ),
  closeness: (json['closeness'] as num).toInt(),
  streakDays: (json['streak_days'] as num).toInt(),
  lastExchangeAt: DateTime.parse(json['last_exchange_at'] as String),
  mood: $enumDecode(_$MoodEnumMap, json['mood']),
  hasUnreadSnaps: json['has_unread_snaps'] as bool,
  shadowFrom: json['shadow_from'] == null
      ? null
      : DateTime.parse(json['shadow_from'] as String),
  shadowUntil: json['shadow_until'] == null
      ? null
      : DateTime.parse(json['shadow_until'] as String),
);

Map<String, dynamic> _$FriendModelToJson(_FriendModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'handle': instance.handle,
      'appearance': instance.appearance.toJson(),
      'closeness': instance.closeness,
      'streak_days': instance.streakDays,
      'last_exchange_at': instance.lastExchangeAt.toIso8601String(),
      'mood': _$MoodEnumMap[instance.mood]!,
      'has_unread_snaps': instance.hasUnreadSnaps,
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
