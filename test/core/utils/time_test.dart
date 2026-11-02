import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/utils/time.dart';

void main() {
  final now = DateTime(2026, 11, 1, 12);

  test('rounds partial days up', () {
    expect(daysUntil(now.add(const Duration(hours: 2)), now: now), 1);
    expect(daysUntil(now.add(const Duration(days: 2, hours: 1)), now: now), 3);
  });

  test('a whole number of days stays as is', () {
    expect(daysUntil(now.add(const Duration(days: 7)), now: now), 7);
  });

  test('a moment in the past is zero days away', () {
    expect(daysUntil(now.subtract(const Duration(hours: 5)), now: now), 0);
  });
}
