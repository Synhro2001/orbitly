import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/report/domain/entities/weekly_report.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_controller.g.dart';

@riverpod
Future<WeeklyReport> weeklyReport(Ref ref) =>
    ref.watch(reportRepositoryProvider).getWeeklyReport();
