import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/data/models/friend_model.dart';
import 'package:orbitly/features/report/domain/entities/weekly_report.dart';

part 'report_entry_model.freezed.dart';
part 'report_entry_model.g.dart';

@freezed
abstract class ReportEntryModel with _$ReportEntryModel {
  const factory ReportEntryModel({
    required FriendModel friend,
    required int delta,
  }) = _ReportEntryModel;

  factory ReportEntryModel.fromJson(Map<String, Object?> json) =>
      _$ReportEntryModelFromJson(json);
}

extension ReportEntryModelX on ReportEntryModel {
  ReportEntry toEntity() =>
      ReportEntry(friend: friend.toEntity(), closenessDelta: delta);
}
