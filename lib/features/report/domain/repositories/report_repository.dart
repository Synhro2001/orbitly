import 'package:orbitly/features/report/domain/entities/weekly_report.dart';

abstract interface class ReportRepository {
  Future<WeeklyReport> getWeeklyReport();
}
