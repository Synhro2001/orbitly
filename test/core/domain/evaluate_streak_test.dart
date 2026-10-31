import 'package:flutter_test/flutter_test.dart';
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
}
