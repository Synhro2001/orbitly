import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/report/domain/entities/weekly_report.dart';
import 'package:orbitly/features/report/presentation/controllers/report_controller.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportTitle)),
      body: AsyncView(
        value: ref.watch(weeklyReportProvider),
        onRetry: () => ref.invalidate(weeklyReportProvider),
        builder: (report) {
          if (report.closer.isEmpty && report.drifting.isEmpty) {
            return Center(child: Text(l10n.reportEmpty));
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(weeklyReportProvider.future),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
              children: [
                if (report.closer.isNotEmpty) ...[
                  _SectionTitle('🚀 ${l10n.reportCloser}'),
                  for (final entry in report.closer) _EntryTile(entry),
                ],
                if (report.drifting.isNotEmpty) ...[
                  _SectionTitle('🌌 ${l10n.reportDrifting}'),
                  for (final entry in report.drifting) _EntryTile(entry),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.l,
      AppSpacing.l,
      AppSpacing.l,
      AppSpacing.s,
    ),
    child: Text(text, style: Theme.of(context).textTheme.titleLarge),
  );
}

class _EntryTile extends StatelessWidget {
  const _EntryTile(this.entry);

  final ReportEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final delta = entry.closenessDelta;
    final friend = entry.friend;
    return ListTile(
      leading: PlanetView(
        appearance: friend.appearance,
        size: AppSizes.listAvatar,
      ),
      title: Text(friend.name),
      subtitle: Text(
        l10n.reportDelta(delta > 0 ? '+$delta' : '$delta'),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: delta > 0 ? AppColors.mint : AppColors.streakCracked,
        ),
      ),
      trailing: FilledButton.tonal(
        onPressed: () => context.push(AppRoutes.chat(friend.id)),
        child: Text(l10n.reportWrite),
      ),
    );
  }
}
