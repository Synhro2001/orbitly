import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/domain/entities/streak.dart';
import 'package:orbitly/core/domain/usecases/evaluate_streak.dart';

void main() {
  const evaluate = EvaluateStreak();
  final now = DateTime(2026, 10, 31, 12);

  Streak streakAgo(Duration ago, {int days = 5}) =>
      Streak(days: days, lastExchangeAt: now.subtract(ago));

  group('EvaluateStreak', () {
    test('active when the last exchange was under 24 hours ago', () {
      expect(evaluate(streakAgo(Duration.zero), now), StreakStatus.active);
      expect(
        evaluate(streakAgo(const Duration(hours: 23, minutes: 59)), now),
        StreakStatus.active,
      );
    });

    test('cracked from 24 to 48 hours — time to recover', () {
      expect(
        evaluate(streakAgo(const Duration(hours: 24)), now),
        StreakStatus.cracked,
      );
      expect(
        evaluate(streakAgo(const Duration(hours: 47, minutes: 59)), now),
        StreakStatus.cracked,
      );
    });

    test('burnt after 48 hours', () {
      expect(
        evaluate(streakAgo(const Duration(hours: 48)), now),
        StreakStatus.burnt,
      );
      expect(
        evaluate(streakAgo(const Duration(days: 10)), now),
        StreakStatus.burnt,
      );
    });

    test('burnt when there is no streak at all', () {
      expect(
        evaluate(streakAgo(Duration.zero, days: 0), now),
        StreakStatus.burnt,
      );
    });
  });

  group('EvaluateStreak with shadow', () {
    Shadow shadow(Duration startedAgo, Duration endsIn) =>
        Shadow(from: now.subtract(startedAgo), until: now.add(endsIn));

    test('paused while a friend is in shadow, even past 48 hours', () {
      expect(
        evaluate(
          streakAgo(const Duration(days: 4)),
          now,
          shadows: [shadow(const Duration(days: 3), const Duration(days: 1))],
        ),
        StreakStatus.paused,
      );
    });

    test('after the shadow the countdown restarts from its end', () {
      // The exchange was 5 days ago, the shadow ended 2 hours ago.
      final ended = Shadow(
        from: now.subtract(const Duration(days: 4, hours: 12)),
        until: now.subtract(const Duration(hours: 2)),
      );
      expect(
        evaluate(streakAgo(const Duration(days: 5)), now, shadows: [ended]),
        StreakStatus.active,
      );
    });

    test('cracks a day after returning from the shadow', () {
      final ended = Shadow(
        from: now.subtract(const Duration(days: 4)),
        until: now.subtract(const Duration(hours: 30)),
      );
      expect(
        evaluate(streakAgo(const Duration(days: 5)), now, shadows: [ended]),
        StreakStatus.cracked,
      );
    });

    test('does not revive a streak that burnt before the shadow began', () {
      expect(
        evaluate(
          streakAgo(const Duration(days: 5)),
          now,
          shadows: [shadow(const Duration(days: 1), const Duration(days: 2))],
        ),
        StreakStatus.burnt,
      );
    });

    test('a planned shadow does not pause the streak yet', () {
      final planned = Shadow(
        from: now.add(const Duration(days: 1)),
        until: now.add(const Duration(days: 3)),
      );
      expect(
        evaluate(streakAgo(const Duration(hours: 30)), now, shadows: [planned]),
        StreakStatus.cracked,
      );
    });

    test('shadows of both friends are taken into account', () {
      final mine = Shadow(
        from: now.subtract(const Duration(days: 6)),
        until: now.subtract(const Duration(days: 4)),
      );
      final theirs = shadow(const Duration(days: 5), const Duration(hours: 5));
      expect(
        evaluate(
          streakAgo(const Duration(days: 7)),
          now,
          shadows: [theirs, mine],
        ),
        StreakStatus.paused,
      );
    });
  });
}
