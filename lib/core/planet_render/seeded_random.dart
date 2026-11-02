/// Deterministic generator (xorshift32): the same sequence on Android, iOS
/// and web. `dart:math` `Random(seed)` does not promise that.
class SeededRandom {
  SeededRandom(int seed) : _state = seed & _mask {
    if (_state == 0) _state = 0x9E3779B9;
    // The first xorshift values for small seeds are similar, so warm it up.
    for (var i = 0; i < 8; i++) {
      nextUint32();
    }
  }

  static const _mask = 0xFFFFFFFF;
  int _state;

  int nextUint32() {
    var x = _state;
    x ^= (x << 13) & _mask;
    x ^= x >> 17;
    x ^= (x << 5) & _mask;
    return _state = x & _mask;
  }

  /// A number in [0, 1).
  double nextDouble() => nextUint32() / 4294967296;

  double range(double min, double max) => min + (max - min) * nextDouble();

  int nextInt(int max) => nextUint32() % max;
}
