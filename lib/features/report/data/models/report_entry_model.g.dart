// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'report_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportEntryModel _$ReportEntryModelFromJson(Map<String, dynamic> json) =>
    _ReportEntryModel(
      friend: FriendModel.fromJson(json['friend'] as Map<String, dynamic>),
      delta: (json['delta'] as num).toInt(),
    );

Map<String, dynamic> _$ReportEntryModelToJson(_ReportEntryModel instance) =>
    <String, dynamic>{
      'friend': instance.friend.toJson(),
      'delta': instance.delta,
    };
