// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'moment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MomentModel _$MomentModelFromJson(Map<String, dynamic> json) => _MomentModel(
  id: json['id'] as String,
  friendId: json['friend_id'] as String,
  seen: json['seen'] as bool,
  postedAt: DateTime.parse(json['posted_at'] as String),
);

Map<String, dynamic> _$MomentModelToJson(_MomentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'friend_id': instance.friendId,
      'seen': instance.seen,
      'posted_at': instance.postedAt.toIso8601String(),
    };
