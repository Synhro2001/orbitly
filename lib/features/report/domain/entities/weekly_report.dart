import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/friend.dart';

part 'weekly_report.freezed.dart';

@freezed
abstract class WeeklyReport with _$WeeklyReport {
  const factory WeeklyReport({
    required List<ReportEntry> closer,
    required List<ReportEntry> drifting,
  }) = _WeeklyReport;
}

@freezed
abstract class ReportEntry with _$ReportEntry {
  const factory ReportEntry({
    required Friend friend,

    /// Change in closeness over the week, in points.
    required int closenessDelta,
  }) = _ReportEntry;
}
