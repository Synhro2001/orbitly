// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'award_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AwardModel _$AwardModelFromJson(Map<String, dynamic> json) => _AwardModel(
  id: json['id'] as String,
  title: json['title'] as String,
  emoji: json['emoji'] as String,
  unlocked: json['unlocked'] as bool,
);

Map<String, dynamic> _$AwardModelToJson(_AwardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'emoji': instance.emoji,
      'unlocked': instance.unlocked,
    };
