// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'friends_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSummaryModel _$UserSummaryModelFromJson(Map<String, dynamic> json) =>
    _UserSummaryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      handle: json['handle'] as String,
      appearance: PlanetAppearanceModel.fromJson(
        json['appearance'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UserSummaryModelToJson(_UserSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'handle': instance.handle,
      'appearance': instance.appearance.toJson(),
    };

_FriendRequestModel _$FriendRequestModelFromJson(Map<String, dynamic> json) =>
    _FriendRequestModel(
      id: json['id'] as String,
      user: UserSummaryModel.fromJson(json['user'] as Map<String, dynamic>),
      sentAt: DateTime.parse(json['sent_at'] as String),
    );

Map<String, dynamic> _$FriendRequestModelToJson(_FriendRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user.toJson(),
      'sent_at': instance.sentAt.toIso8601String(),
    };
