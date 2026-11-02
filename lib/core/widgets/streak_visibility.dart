import 'package:flutter/widgets.dart';

/// "Streaks without pressure": when [hidden], streak counters and cracks are
/// not shown anywhere. Streaks still count on the server.
class StreakVisibility extends InheritedWidget {
  const StreakVisibility({
    required this.hidden,
    required super.child,
    super.key,
  });

  final bool hidden;

  static bool hiddenOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StreakVisibility>()?.hidden ??
      false;

  @override
  bool updateShouldNotify(StreakVisibility oldWidget) =>
      hidden != oldWidget.hidden;
}
