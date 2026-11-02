import 'package:flutter/material.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';

/// Full-screen snap/moment viewer. No real content yet: a gradient, a
/// caption and a progress bar. Closes on tap or after 5 seconds.
Future<void> showContentViewer(BuildContext context, {required String title}) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: AppColors.scrim,
    transitionDuration: AppDurations.fast,
    pageBuilder: (context, _, _) => _ContentViewer(title: title),
  );
}

class _ContentViewer extends StatefulWidget {
  const _ContentViewer({required this.title});

  final String title;

  @override
  State<_ContentViewer> createState() => _ContentViewerState();
}

class _ContentViewerState extends State<_ContentViewer>
    with SingleTickerProviderStateMixin {
  late final _progress = AnimationController(
    vsync: this,
    duration: AppDurations.viewerAutoClose,
  );

  @override
  void initState() {
    super.initState();
    _progress
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _close();
      })
      ..forward();
  }

  void _close() {
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: _close,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.viewerGradient,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: _progress,
                  builder: (context, _) => LinearProgressIndicator(
                    value: _progress.value,
                    color: AppColors.textPrimary,
                    backgroundColor: AppColors.outline,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                Text(widget.title, style: textTheme.titleMedium),
                const Spacer(),
                Center(
                  child: Text(
                    context.l10n.viewerTapToClose,
                    style: textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
