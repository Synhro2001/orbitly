/// Radius of a friend's orbit: the closer you are, the closer the orbit.
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
    // The data comes from the server, so keep it within 0–100.
    final c = closeness.clamp(0, 100);
    return rMin + (1 - c / 100) * (rMax - rMin);
  }
}
