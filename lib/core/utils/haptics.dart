import 'package:flutter/services.dart';

/// Haptic feedback that respects the "Haptics" setting. OrbitlyApp keeps
/// [enabled] in step with it, so call sites stay one line.
abstract final class AppHaptics {
  static bool enabled = true;

  static Future<void> light() =>
      enabled ? HapticFeedback.lightImpact() : Future.value();

  static Future<void> medium() =>
      enabled ? HapticFeedback.mediumImpact() : Future.value();

  static Future<void> heavy() =>
      enabled ? HapticFeedback.heavyImpact() : Future.value();
}
