part of 'planet_painter.dart';

/// Редкие планеты и эффекты наград. Как и всё остальное, рисуются
/// детерминированно: всё случайное берётся из [SeededRandom] по seed.
extension _RarePlanets on PlanetPainter {
  // --- Туманность: облака газа и звёзды внутри

  void _paintNebula(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    // Яркие облака газа трёх оттенков и светящееся ядро.
    for (var i = 0; i < 10; i++) {
      canvas.drawCircle(
        c + Offset(r * rnd.range(-0.7, 0.7), r * rnd.range(-0.7, 0.7)),
        r * rnd.range(0.22, 0.5),
        Paint()
          ..color = _hsl(
            const [-70.0, 0.0, 80.0][i % 3] + rnd.range(-15, 15),
            0.95,
            rnd.range(0.5, 0.68),
            0.6,
          )
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.16),
      );
    }
    canvas.drawCircle(
      c,
      r * 0.35,
      Paint()
        ..color = _hsl(20, 1, 0.85, 0.55)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.2),
    );
    final star = Paint()..color = const Color(0xE6FFFFFF);
    for (var i = 0; i < 22; i++) {
      canvas.drawCircle(
        c + Offset(r * rnd.range(-0.85, 0.85), r * rnd.range(-0.85, 0.85)),
        r * rnd.range(0.008, 0.025),
        star,
      );
    }
  }

  // --- Чёрная дыра: тёмное ядро и наклонный аккреционный диск

  static const _diskTilt = -0.3;
  static const _diskFlatten = 0.3;

  void _paintAccretionDisk(
    Canvas canvas,
    Offset c,
    double r, {
    required bool front,
  }) {
    canvas
      ..save()
      ..translate(c.dx, c.dy)
      ..rotate(_diskTilt)
      ..scale(1, _diskFlatten)
      ..clipRect(
        front
            ? Rect.fromLTRB(-r * 2, 0, r * 2, r * 2)
            : Rect.fromLTRB(-r * 2, -r * 2, r * 2, 0),
      );
    const steps = 7;
    for (var i = 0; i < steps; i++) {
      final t = i / (steps - 1);
      canvas.drawCircle(
        Offset.zero,
        r * (1.15 + t * 0.55),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = r * 0.09 / _diskFlatten
          ..color = _hsl(30 - t * 20, 1, 0.88 - t * 0.38, 0.85 - t * 0.55)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.04),
      );
    }
    canvas.restore();
  }

  void _paintPhotonRing(Canvas canvas, Offset c, double r) {
    canvas
      ..drawCircle(
        c,
        r * 1.02,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = r * 0.12
          ..color = _hsl(35, 1, 0.7, 0.5)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.08),
      )
      ..drawCircle(
        c,
        r * 1.01,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = r * 0.03
          ..color = _hsl(40, 1, 0.92),
      );
  }

  // --- Аврора: ночная сторона с полярным сиянием

  void _paintAuroraSurface(
    Canvas canvas,
    Offset c,
    double r,
    SeededRandom rnd,
  ) {
    // Огни городов на ночной стороне.
    final lights = Paint()..color = const Color(0xCCFFD27A);
    for (var i = 0; i < 14; i++) {
      canvas.drawCircle(
        c + Offset(r * rnd.range(-0.6, 0.6), r * rnd.range(0.05, 0.75)),
        r * 0.02,
        lights,
      );
    }
    // Занавеси сияния у полюса.
    final phase = rnd.range(0, math.pi * 2);
    for (var band = 0; band < 3; band++) {
      final top = c.dy - r * (0.75 - band * 0.12);
      final color = band.isEven
          ? const Color(0xFF7CF2B0)
          : const Color(0xFFB18CFF);
      for (var x = -r; x <= r; x += r / 22) {
        final y = top + math.sin(x / r * 5 + phase + band) * r * 0.06;
        final length = r * rnd.range(0.18, 0.38);
        canvas.drawLine(
          Offset(c.dx + x, y),
          Offset(c.dx + x, y + length),
          Paint()
            ..strokeWidth = r * 0.05
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.02)
            ..shader = LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withValues(alpha: 0.7),
                color.withValues(alpha: 0),
              ],
            ).createShader(Rect.fromLTWH(c.dx + x, y, 1, length)),
        );
      }
    }
  }

  void _paintAuroraGlow(Canvas canvas, Offset c, double r) {
    canvas.drawCircle(
      c,
      r * 1.25,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.45
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.18)
        ..shader = const SweepGradient(
          colors: [
            Color(0x8C7CF2B0),
            Color(0x73B18CFF),
            Color(0x806EC8FF),
            Color(0x8C7CF2B0),
          ],
        ).createShader(Rect.fromCircle(center: c, radius: r * 1.5)),
    );
  }

  // --- Солнечная корона: раскалённое тело и лучи

  void _paintCorona(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    final outer = r * 1.7;
    canvas.drawCircle(
      c,
      outer,
      Paint()
        ..shader = RadialGradient(
          colors: [_sun(0, 1, 0.7, 0.65), _sun(-10, 1, 0.6, 0)],
          stops: const [0.5, 1],
        ).createShader(Rect.fromCircle(center: c, radius: outer)),
    );
    const rays = 24;
    for (var i = 0; i < rays; i++) {
      final angle = i / rays * math.pi * 2 + rnd.range(-0.08, 0.08);
      final direction = Offset(math.cos(angle), math.sin(angle));
      canvas.drawLine(
        c + direction * r * 0.95,
        c + direction * r * rnd.range(1.4, 1.68),
        Paint()
          ..strokeWidth = r * rnd.range(0.03, 0.07)
          ..strokeCap = StrokeCap.round
          ..color = _sun(10, 1, 0.75, 0.6)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.03),
      );
    }
  }

  void _paintSolarSurface(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    for (var i = 0; i < 40; i++) {
      canvas.drawCircle(
        c + Offset(r * rnd.range(-0.95, 0.95), r * rnd.range(-0.95, 0.95)),
        r * rnd.range(0.04, 0.1),
        Paint()..color = _sun(rnd.range(-15, 10), 1, rnd.range(0.55, 0.9), 0.3),
      );
    }
    final spot = Paint()..color = _sun(-20, 0.8, 0.25, 0.7);
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
        c + Offset(r * rnd.range(-0.5, 0.5), r * rnd.range(-0.5, 0.5)),
        r * rnd.range(0.04, 0.08),
        spot,
      );
    }
  }

  // --- Близнецы: две сцепленные планеты

  void _paintGemini(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    _paintSphere(canvas, c + Offset(r * 0.55, -r * 0.32), r * 0.5, 45, rnd);
    _paintSphere(canvas, c + Offset(-r * 0.3, r * 0.12), r * 0.78, 0, rnd);
  }

  void _paintSphere(
    Canvas canvas,
    Offset center,
    double radius,
    double hueShift,
    SeededRandom rnd,
  ) {
    final bounds = Rect.fromCircle(center: center, radius: radius);
    canvas
      ..save()
      ..clipPath(Path()..addOval(bounds))
      ..drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.35, -0.4),
            colors: [_hsl(hueShift, 0.6, 0.7), _hsl(hueShift + 20, 0.6, 0.32)],
          ).createShader(bounds),
      );
    _paintBands(canvas, center, radius, rnd);
    _paintShading(canvas, center, radius);
    canvas
      ..restore()
      ..drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius * 0.05
          ..color = _hsl(hueShift, 0.8, 0.8, 0.5),
      );
  }

  // --- Кольцевой мир: много тонких колец

  void _paintRingWorldRings(
    Canvas canvas,
    Offset c,
    double r,
    SeededRandom rnd, {
    required bool front,
  }) {
    const tilt = -0.5;
    const flatten = 0.22;
    canvas
      ..save()
      ..translate(c.dx, c.dy)
      ..rotate(tilt)
      ..scale(1, flatten)
      ..clipRect(
        front
            ? Rect.fromLTRB(-r * 2, 0, r * 2, r * 2)
            : Rect.fromLTRB(-r * 2, -r * 2, r * 2, 0),
      );
    // Свой генератор: передние и задние половины колец должны совпасть.
    final ringRnd = SeededRandom(appearance.seed + 7);
    for (var i = 0; i < 6; i++) {
      canvas.drawCircle(
        Offset.zero,
        r * (1.15 + i * 0.1),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = r * ringRnd.range(0.015, 0.045) / flatten
          ..color = _hsl(
            ringRnd.range(-30, 60),
            0.6,
            ringRnd.range(0.6, 0.85),
            ringRnd.range(0.5, 0.9),
          ),
      );
    }
    canvas.restore();
  }

  // --- Эффекты наград

  /// След кометы за планетой.
  void _paintCometTrail(Canvas canvas, Offset c, double r) {
    const direction = Offset(-0.85, 0.53);
    const perpendicular = Offset(0.53, 0.85);
    final tip = c + direction * r * 1.7;
    Path wedge(double halfWidth) => Path()
      ..moveTo(
        c.dx + perpendicular.dx * halfWidth,
        c.dy + perpendicular.dy * halfWidth,
      )
      ..lineTo(tip.dx, tip.dy)
      ..lineTo(
        c.dx - perpendicular.dx * halfWidth,
        c.dy - perpendicular.dy * halfWidth,
      )
      ..close();

    // Ледяной хвост: широкий мягкий слой и яркая сердцевина.
    for (final (halfWidth, alpha, blur) in const [
      (0.85, 0.55, 0.1),
      (0.4, 0.9, 0.04),
    ]) {
      canvas.drawPath(
        wedge(r * halfWidth),
        Paint()
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * blur)
          ..shader = LinearGradient(
            colors: [
              const Color(0xFFCFF6FF).withValues(alpha: alpha),
              const Color(0x00CFF6FF),
            ],
          ).createShader(Rect.fromPoints(c, tip)),
      );
    }
  }

  /// «Двойная звезда»: маленькая яркая звезда-компаньон.
  void _paintCompanionStar(Canvas canvas, Offset c, double r) {
    final star = c + Offset(r * 1.25, -r * 1.1);
    final glowRadius = r * 0.35;
    canvas.drawCircle(
      star,
      glowRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [_hsl(40, 1, 0.9, 0.9), _hsl(40, 1, 0.9, 0)],
        ).createShader(Rect.fromCircle(center: star, radius: glowRadius)),
    );
    final flare = Paint()
      ..strokeWidth = r * 0.02
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xE6FFFFFF);
    canvas
      ..drawLine(star - Offset(r * 0.45, 0), star + Offset(r * 0.45, 0), flare)
      ..drawLine(star - Offset(0, r * 0.45), star + Offset(0, r * 0.45), flare)
      ..drawCircle(star, r * 0.08, Paint()..color = const Color(0xFFFFFFFF));
  }

  /// Спутник-скин «Песочные часы».
  void _paintHourglassMoon(Canvas canvas, Offset center, double size) {
    final w = size * 0.6;
    final path = Path()
      ..moveTo(center.dx - w, center.dy - size)
      ..lineTo(center.dx + w, center.dy - size)
      ..lineTo(center.dx, center.dy)
      ..lineTo(center.dx + w, center.dy + size)
      ..lineTo(center.dx - w, center.dy + size)
      ..lineTo(center.dx, center.dy)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFE19A), Color(0xFFB8862E)],
        ).createShader(Rect.fromCircle(center: center, radius: size)),
    );
  }
}
