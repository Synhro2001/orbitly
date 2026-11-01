import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/report/data/models/report_entry_model.dart';
import 'package:orbitly/features/report/domain/entities/weekly_report.dart';
import 'package:orbitly/features/report/domain/repositories/report_repository.dart';

class MockReportRepository implements ReportRepository {
  const MockReportRepository(this._store);

  final MockStore _store;

  List<ReportEntry> _entries(String key) => [
    for (final row in _store.weeklyReport[key] ?? const <Json>[])
      ReportEntryModel.fromJson({
        'friend': _store.friendJson(row['friend_id']! as String),
        'delta': row['delta'],
      }).toEntity(),
  ];

  @override
  Future<WeeklyReport> getWeeklyReport() async {
    await _store.delay();
    return WeeklyReport(
      closer: _entries('closer'),
      drifting: _entries('drifting'),
    );
  }
}
