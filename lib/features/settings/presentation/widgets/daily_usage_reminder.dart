import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/presentation/controllers/user_settings_controller.dart';

/// The soft daily limit: counts minutes while the app is on screen and,
/// once a day, gently says how long it has been. A reminder, never a lock.
class DailyUsageReminder extends ConsumerStatefulWidget {
  const DailyUsageReminder({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<DailyUsageReminder> createState() => _DailyUsageReminderState();
}

class _DailyUsageReminderState extends ConsumerState<DailyUsageReminder>
    with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _start();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  /// Only minutes on screen count.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _start();
    } else {
      _timer?.cancel();
      _timer = null;
    }
  }

  void _start() {
    _timer ??= Timer.periodic(const Duration(minutes: 1), (_) => _tick());
  }

  Future<void> _tick() async {
    final repository = ref.read(settingsRepositoryProvider);
    final limit = ref
        .read(userSettingsControllerProvider)
        .value
        ?.dailyLimitMinutes;
    var usage = repository.usage.addMinute(ref.read(clockProvider)());
    if (usage.shouldRemind(limitMinutes: limit) && mounted) {
      usage = usage.copyWith(reminded: true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 8),
          content: Text(context.l10n.wellbeingReminder(usage.minutes)),
        ),
      );
    }
    await repository.saveUsage(usage);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
