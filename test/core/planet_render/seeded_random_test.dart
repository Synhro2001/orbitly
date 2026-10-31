import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/planet_render/seeded_random.dart';

void main() {
  List<int> sequence(int seed) {
    final rnd = SeededRandom(seed);
    return [for (var i = 0; i < 5; i++) rnd.nextUint32()];
  }

  test('same seed gives the same planet', () {
    expect(sequence(42), sequence(42));
  });

  test('different seeds give different planets', () {
    expect(sequence(1), isNot(sequence(2)));
  });

  test('nextDouble stays within [0, 1)', () {
    final rnd = SeededRandom(7);
    for (var i = 0; i < 1000; i++) {
      expect(rnd.nextDouble(), inInclusiveRange(0, 0.9999999999));
    }
  });
}
