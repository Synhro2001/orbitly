import 'package:orbitly/core/domain/entities/shadow.dart';

/// Which shadow may be set. The server checks this too: a shadow saves
/// streaks, so a fake one (a year long or backdated) would be a way to cheat.
class ShadowPolicy {
  const ShadowPolicy();

  static const maxDuration = Duration(days: 7);

  /// Tolerance for clock drift between the phone and the server.
  static const clockSkew = Duration(minutes: 5);

  /// [current] is the shadow already set: it can only end earlier.
  bool isAllowed(Shadow shadow, {required DateTime now, Shadow? current}) {
    if (!shadow.until.isAfter(shadow.from)) return false;
    if (shadow.until.difference(shadow.from) > maxDuration) return false;

    // Leaving early: same start, end no later than before.
    if (current != null && shadow.from == current.from) {
      return !shadow.until.isAfter(current.until);
    }
    // A new shadow starts now: a backdated one would revive streaks that
    // are already lost.
    return shadow.from.difference(now).abs() <= clockSkew;
  }
}
