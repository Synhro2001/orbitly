/// Детерминированный генератор (xorshift32): одинаковая последовательность
/// на Android, iOS и в вебе. `dart:math` `Random(seed)` такого не обещает.
class SeededRandom {
  SeededRandom(int seed) : _state = seed & _mask {
    if (_state == 0) _state = 0x9E3779B9;
    // Первые значения xorshift для маленьких seed похожи — прогреваем.
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

  /// Число в диапазоне [0, 1).
  double nextDouble() => nextUint32() / 4294967296;

  double range(double min, double max) => min + (max - min) * nextDouble();

  int nextInt(int max) => nextUint32() % max;
}
