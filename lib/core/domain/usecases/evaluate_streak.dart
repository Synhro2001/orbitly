import 'package:orbitly/core/domain/entities/streak.dart';

/// Мягкая серия: сутки без обмена — «трещина», ещё сутки — «сгорела».
class EvaluateStreak {
  const EvaluateStreak();

  static const activeWindow = Duration(hours: 24);
  static const recoveryWindow = Duration(hours: 24);

  StreakStatus call(Streak streak, DateTime now) {
    if (streak.days <= 0) return StreakStatus.burnt;
    final sinceLast = now.difference(streak.lastExchangeAt);
    if (sinceLast < activeWindow) return StreakStatus.active;
    if (sinceLast < activeWindow + recoveryWindow) return StreakStatus.cracked;
    return StreakStatus.burnt;
  }
}
