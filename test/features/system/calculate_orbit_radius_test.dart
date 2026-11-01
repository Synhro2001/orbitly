import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/features/system/domain/usecases/calculate_orbit_radius.dart';

void main() {
  const calculate = CalculateOrbitRadius();

  double radius(int closeness) =>
      calculate(closeness: closeness, rMin: 100, rMax: 300);

  group('CalculateOrbitRadius', () {
    test('closest friend sits on the inner orbit', () {
      expect(radius(100), 100);
    });

    test('most distant friend sits on the outer orbit', () {
      expect(radius(0), 300);
    });

    test('follows rMin + (1 - closeness / 100) * (rMax - rMin)', () {
      expect(radius(50), 200);
      expect(radius(75), 150);
    });

    test('closer friends get smaller orbits', () {
      expect(radius(80), lessThan(radius(20)));
    });

    test('clamps closeness outside 0–100', () {
      expect(radius(150), 100);
      expect(radius(-20), 300);
    });
  });
}
