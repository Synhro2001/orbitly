// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessageModel _$TextMessageModelFromJson(Map<String, dynamic> json) =>
    TextMessageModel(
      id: json['id'] as String,
      isMine: json['is_mine'] as bool,
      sentAt: DateTime.parse(json['sent_at'] as String),
      text: json['text'] as String,
      $type: json['kind'] as String?,
    );

Map<String, dynamic> _$TextMessageModelToJson(TextMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_mine': instance.isMine,
      'sent_at': instance.sentAt.toIso8601String(),
      'text': instance.text,
      'kind': instance.$type,
    };

SnapMessageModel _$SnapMessageModelFromJson(Map<String, dynamic> json) =>
    SnapMessageModel(
      id: json['id'] as String,
      isMine: json['is_mine'] as bool,
      sentAt: DateTime.parse(json['sent_at'] as String),
      opened: json['opened'] as bool,
      $type: json['kind'] as String?,
    );

Map<String, dynamic> _$SnapMessageModelToJson(SnapMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_mine': instance.isMine,
      'sent_at': instance.sentAt.toIso8601String(),
      'opened': instance.opened,
      'kind': instance.$type,
    };

CapsuleMessageModel _$CapsuleMessageModelFromJson(Map<String, dynamic> json) =>
    CapsuleMessageModel(
      id: json['id'] as String,
      isMine: json['is_mine'] as bool,
      sentAt: DateTime.parse(json['sent_at'] as String),
      opensAt: DateTime.parse(json['opens_at'] as String),
      text: json['text'] as String?,
      $type: json['kind'] as String?,
    );

Map<String, dynamic> _$CapsuleMessageModelToJson(
  CapsuleMessageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'is_mine': instance.isMine,
  'sent_at': instance.sentAt.toIso8601String(),
  'opens_at': instance.opensAt.toIso8601String(),
  'text': instance.text,
  'kind': instance.$type,
};
