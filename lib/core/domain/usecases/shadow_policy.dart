import 'package:orbitly/core/domain/entities/shadow.dart';

/// Какую тень можно поставить. Проверяет сервер: тень спасает серии, поэтому
/// поддельная тень (на год или задним числом) — способ жульничать.
class ShadowPolicy {
  const ShadowPolicy();

  static const maxDuration = Duration(days: 7);

  /// Допуск на расхождение часов телефона и сервера.
  static const clockSkew = Duration(minutes: 5);

  /// [current] — тень, которая уже стоит: её можно только закончить раньше.
  bool isAllowed(Shadow shadow, {required DateTime now, Shadow? current}) {
    if (!shadow.until.isAfter(shadow.from)) return false;
    if (shadow.until.difference(shadow.from) > maxDuration) return false;

    // Досрочный выход: начало прежнее, конец не позже прежнего.
    if (current != null && shadow.from == current.from) {
      return !shadow.until.isAfter(current.until);
    }
    // Новая тень начинается сейчас: задним числом она оживила бы
    // уже сгоревшие серии.
    return shadow.from.difference(now).abs() <= clockSkew;
  }
}
