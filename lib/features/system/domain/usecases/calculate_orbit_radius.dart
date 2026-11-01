/// Радиус орбиты друга: чем ближе общение, тем ближе орбита.
///
/// `radius = rMin + (1 - closeness / 100) * (rMax - rMin)`
class CalculateOrbitRadius {
  const CalculateOrbitRadius();

  double call({
    required int closeness,
    required double rMin,
    required double rMax,
  }) {
    assert(rMin <= rMax, 'rMin must not exceed rMax');
    // Данные приходят с сервера — за пределы 0–100 не выходим.
    final c = closeness.clamp(0, 100);
    return rMin + (1 - c / 100) * (rMax - rMin);
  }
}
