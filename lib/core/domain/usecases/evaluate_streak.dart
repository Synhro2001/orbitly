import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/domain/entities/streak.dart';

/// Мягкая серия: сутки без обмена — «трещина», ещё сутки — «сгорела».
///
/// Тень любого из двух друзей ставит серию на паузу. После выхода из тени
/// отсчёт начинается заново с момента её окончания, чтобы вернувшийся
/// не попадал сразу в «трещину». Тень не спасает серию, которая сгорела
/// ещё до её начала.
class EvaluateStreak {
  const EvaluateStreak();

  static const activeWindow = Duration(hours: 24);
  static const recoveryWindow = Duration(hours: 24);

  StreakStatus call(
    Streak streak,
    DateTime now, {
    List<Shadow> shadows = const [],
  }) {
    if (streak.days <= 0) return StreakStatus.burnt;

    var reference = streak.lastExchangeAt;
    final byStart = [...shadows]..sort((a, b) => a.from.compareTo(b.from));
    for (final shadow in byStart) {
      final burnsAt = reference.add(activeWindow + recoveryWindow);
      if (!shadow.from.isBefore(burnsAt)) continue;
      if (shadow.isActiveAt(now)) return StreakStatus.paused;
      final ended = !shadow.until.isAfter(now);
      if (ended && shadow.until.isAfter(reference)) reference = shadow.until;
    }

    final sinceLast = now.difference(reference);
    if (sinceLast < activeWindow) return StreakStatus.active;
    if (sinceLast < activeWindow + recoveryWindow) return StreakStatus.cracked;
    return StreakStatus.burnt;
  }
}
