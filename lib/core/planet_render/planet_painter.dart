import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/seeded_random.dart';

part 'rare_planets.dart';

/// Draws a planet from its description. Colours do not come from the theme:
/// they are derived from the planet's hue and type as part of procedural
/// generation.
///
/// The planet sits in the middle of a square; the margins are for rings,
/// moons and glow.
class PlanetPainter extends CustomPainter {
  const PlanetPainter(this.appearance);

  final PlanetAppearance appearance;

  /// Radius of the planet body relative to the side of the square.
  static const bodyRadiusFactor = 0.29;

  static const _ringTilt = -0.35;
  static const _ringFlatten = 0.28;

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final center = size.center(Offset.zero);
    final r = side * bodyRadiusFactor;
    final a = appearance;
    final rnd = SeededRandom(a.seed);

    // Layers behind the planet.
    if (a.hasCometTrail) _paintCometTrail(canvas, center, r);
    switch (a.glow) {
      case GlowStyle.none:
        break;
      case GlowStyle.soft:
      case GlowStyle.doubleStar:
        _paintGlow(canvas, center, r);
      case GlowStyle.aurora:
        _paintAuroraGlow(canvas, center, r);
    }
    if (a.type == PlanetType.solarCorona) _paintCorona(canvas, center, r, rnd);
    if (a.type == PlanetType.blackHole) {
      _paintAccretionDisk(canvas, center, r, front: false);
    }
    if (a.type == PlanetType.ringWorld) {
      _paintRingWorldRings(canvas, center, r, rnd, front: false);
    }
    if (a.hasRings) _paintRing(canvas, center, r, front: false);

    // Body.
    if (a.type == PlanetType.gemini) {
      _paintGemini(canvas, center, r, rnd);
    } else {
      canvas
        ..save()
        ..clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: r)));
      _paintBase(canvas, center, r);
      _paintSurface(canvas, center, r, rnd);
      if (a.type != PlanetType.blackHole && a.type != PlanetType.solarCorona) {
        _paintShading(canvas, center, r);
      }
      canvas.restore();
    }

    // Layers in front of the planet.
    if (_hasAtmosphere) _paintAtmosphere(canvas, center, r);
    if (a.type == PlanetType.blackHole) {
      _paintPhotonRing(canvas, center, r);
      _paintAccretionDisk(canvas, center, r, front: true);
    }
    if (a.type == PlanetType.ringWorld) {
      _paintRingWorldRings(canvas, center, r, rnd, front: true);
    }
    if (a.hasRings) _paintRing(canvas, center, r, front: true);
    _paintMoons(canvas, center, r, rnd);
    if (a.glow == GlowStyle.doubleStar) _paintCompanionStar(canvas, center, r);
  }

  void _paintSurface(Canvas canvas, Offset center, double r, SeededRandom rnd) {
    switch (appearance.type) {
      case PlanetType.gas:
        _paintBands(canvas, center, r, rnd);
      case PlanetType.candy:
        _paintCandy(canvas, center, r, rnd);
      case PlanetType.ocean:
        _paintContinents(canvas, center, r, rnd, count: 6, blob: 0.22);
        _paintClouds(canvas, center, r, rnd);
      case PlanetType.jungle:
        _paintContinents(canvas, center, r, rnd, count: 14, blob: 0.14);
        _paintClouds(canvas, center, r, rnd);
      case PlanetType.lava:
        _paintCracks(canvas, center, r, rnd, glowing: true);
        _paintCraters(canvas, center, r, rnd, count: 5);
      case PlanetType.ice:
        _paintPolarCaps(canvas, center, r);
        _paintCracks(canvas, center, r, rnd, glowing: false);
        _paintCraters(canvas, center, r, rnd, count: 3);
      case PlanetType.crystal:
        _paintFacets(canvas, center, r, rnd);
        _paintCraters(canvas, center, r, rnd, count: 2);
      case PlanetType.nebula:
        _paintNebula(canvas, center, r, rnd);
      case PlanetType.blackHole:
        break;
      case PlanetType.aurora:
        _paintAuroraSurface(canvas, center, r, rnd);
      case PlanetType.solarCorona:
        _paintSolarSurface(canvas, center, r, rnd);
      case PlanetType.ringWorld:
        _paintFacets(canvas, center, r, rnd);
        _paintCracks(canvas, center, r, rnd, glowing: true);
      case PlanetType.gemini:
        break;
    }
  }

  bool get _hasAtmosphere => switch (appearance.type) {
    PlanetType.ocean ||
    PlanetType.jungle ||
    PlanetType.ice ||
    PlanetType.gas ||
    PlanetType.candy ||
    PlanetType.nebula ||
    PlanetType.aurora => true,
    PlanetType.lava ||
    PlanetType.crystal ||
    PlanetType.blackHole ||
    PlanetType.solarCorona ||
    PlanetType.gemini ||
    PlanetType.ringWorld => false,
  };

  Color _hsl(double hueShift, double s, double l, [double alpha = 1]) =>
      HSLColor.fromAHSL(
        alpha,
        (appearance.hue + hueShift) % 360,
        s.clamp(0, 1),
        l.clamp(0, 1),
      ).toColor();

  /// Warm colour for the "Solar corona": not taken from the user's hue.
  Color _sun(double hueShift, double s, double l, [double alpha = 1]) =>
      HSLColor.fromAHSL(
        alpha,
        (40 + hueShift) % 360,
        s.clamp(0, 1),
        l.clamp(0, 1),
      ).toColor();

  /// Main (light, dark) surface colour for the type.
  (Color, Color) get _baseColors => switch (appearance.type) {
    PlanetType.ocean => (_hsl(0, 0.7, 0.55), _hsl(10, 0.75, 0.3)),
    PlanetType.jungle => (_hsl(0, 0.5, 0.4), _hsl(-10, 0.55, 0.2)),
    PlanetType.lava => (_hsl(0, 0.45, 0.2), _hsl(0, 0.5, 0.07)),
    PlanetType.ice => (_hsl(0, 0.45, 0.92), _hsl(10, 0.4, 0.7)),
    PlanetType.candy => (_hsl(0, 0.85, 0.85), _hsl(20, 0.7, 0.68)),
    PlanetType.crystal => (_hsl(0, 0.65, 0.7), _hsl(25, 0.6, 0.4)),
    PlanetType.gas => (_hsl(0, 0.6, 0.72), _hsl(-15, 0.55, 0.42)),
    PlanetType.nebula => (_hsl(0, 0.55, 0.18), _hsl(40, 0.6, 0.05)),
    PlanetType.blackHole => (const Color(0xFF050308), const Color(0xFF000000)),
    PlanetType.aurora => (_hsl(0, 0.5, 0.24), _hsl(15, 0.6, 0.07)),
    // The sun is always golden, whatever hue was picked.
    PlanetType.solarCorona => (_sun(10, 1, 0.82), _sun(-15, 1, 0.5)),
    PlanetType.gemini => (_hsl(0, 0.6, 0.68), _hsl(20, 0.6, 0.35)),
    PlanetType.ringWorld => (_hsl(0, 0.35, 0.62), _hsl(15, 0.4, 0.28)),
  };

  void _paintBase(Canvas canvas, Offset c, double r) {
    final (light, dark) = _baseColors;
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.35, -0.4),
          colors: [light, dark],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );
  }

  void _paintBands(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    var y = c.dy - r;
    while (y < c.dy + r) {
      final height = r * rnd.range(0.08, 0.22);
      final amp = r * rnd.range(0.01, 0.05);
      final phase = rnd.range(0, math.pi * 2);
      final color = _hsl(
        rnd.range(-20, 20),
        rnd.range(0.4, 0.7),
        rnd.range(0.4, 0.8),
        rnd.range(0.35, 0.7),
      );
      final path = Path()..moveTo(c.dx - r, y);
      for (var x = -r; x <= r; x += r / 8) {
        path.lineTo(c.dx + x, y + math.sin(x / r * 6 + phase) * amp);
      }
      path
        ..lineTo(c.dx + r, y + height)
        ..lineTo(c.dx - r, y + height)
        ..close();
      canvas.drawPath(path, Paint()..color = color);
      y += height;
    }
    // A big "storm".
    final storm = Offset(
      c.dx + r * rnd.range(-0.4, 0.4),
      c.dy + r * rnd.range(-0.3, 0.4),
    );
    canvas.drawOval(
      Rect.fromCenter(center: storm, width: r * 0.42, height: r * 0.2),
      Paint()..color = _hsl(30, 0.7, 0.55, 0.85),
    );
  }

  void _paintCandy(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    canvas
      ..save()
      ..translate(c.dx, c.dy)
      ..rotate(rnd.range(0.3, 0.9));
    final stripe = r * 0.2;
    final paint = Paint()..color = _hsl(40, 0.8, 0.72, 0.8);
    for (var x = -r * 1.5; x < r * 1.5; x += stripe * 2) {
      canvas.drawRect(Rect.fromLTWH(x, -r * 1.5, stripe, r * 3), paint);
    }
    canvas.restore();
    final sprinkle = Paint()..color = _hsl(180, 0.6, 0.95, 0.9);
    for (var i = 0; i < 14; i++) {
      canvas.drawCircle(
        c + Offset(r * rnd.range(-0.9, 0.9), r * rnd.range(-0.9, 0.9)),
        r * 0.035,
        sprinkle,
      );
    }
  }

  void _paintContinents(
    Canvas canvas,
    Offset c,
    double r,
    SeededRandom rnd, {
    required int count,
    required double blob,
  }) {
    final land = appearance.type == PlanetType.ocean
        ? _hsl(-70, 0.45, 0.42)
        : _hsl(25, 0.6, 0.5);
    final paint = Paint()..color = land;
    for (var i = 0; i < count; i++) {
      final origin =
          c + Offset(r * rnd.range(-0.85, 0.85), r * rnd.range(-0.85, 0.85));
      final parts = 4 + rnd.nextInt(4);
      for (var j = 0; j < parts; j++) {
        canvas.drawCircle(
          origin +
              Offset(r * rnd.range(-blob, blob), r * rnd.range(-blob, blob)),
          r * blob * rnd.range(0.5, 1),
          paint,
        );
      }
    }
  }

  void _paintClouds(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    final paint = Paint()
      ..color = const Color(0x59FFFFFF)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.03);
    for (var i = 0; i < 5; i++) {
      final center =
          c + Offset(r * rnd.range(-0.8, 0.8), r * rnd.range(-0.8, 0.8));
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: r * rnd.range(0.35, 0.7),
          height: r * rnd.range(0.06, 0.12),
        ),
        paint,
      );
    }
  }

  void _paintCracks(
    Canvas canvas,
    Offset c,
    double r,
    SeededRandom rnd, {
    required bool glowing,
  }) {
    final color = glowing ? _hsl(25, 1, 0.55) : _hsl(10, 0.4, 0.62, 0.8);
    final line = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = r * (glowing ? 0.035 : 0.02);
    final glow = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.09
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.05);

    for (var i = 0; i < 7; i++) {
      var p = c + Offset(r * rnd.range(-0.9, 0.9), r * rnd.range(-0.9, 0.9));
      final path = Path()..moveTo(p.dx, p.dy);
      var angle = rnd.range(0, math.pi * 2);
      final steps = 3 + rnd.nextInt(4);
      for (var s = 0; s < steps; s++) {
        angle += rnd.range(-0.9, 0.9);
        p +=
            Offset(math.cos(angle), math.sin(angle)) * r * rnd.range(0.1, 0.25);
        path.lineTo(p.dx, p.dy);
      }
      if (glowing) canvas.drawPath(path, glow);
      canvas.drawPath(path, line);
    }
  }

  void _paintPolarCaps(Canvas canvas, Offset c, double r) {
    final paint = Paint()..color = const Color(0xE6FFFFFF);
    canvas
      ..drawOval(
        Rect.fromCenter(
          center: c - Offset(0, r * 0.95),
          width: r * 1.3,
          height: r * 0.5,
        ),
        paint,
      )
      ..drawOval(
        Rect.fromCenter(
          center: c + Offset(0, r * 0.98),
          width: r * 1.1,
          height: r * 0.4,
        ),
        paint,
      );
  }

  void _paintFacets(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    for (var i = 0; i < 16; i++) {
      final points = [
        for (var p = 0; p < 3; p++)
          c + Offset(r * rnd.range(-1.1, 1.1), r * rnd.range(-1.1, 1.1)),
      ];
      final path = Path()..addPolygon(points, true);
      canvas.drawPath(
        path,
        Paint()
          ..color = _hsl(
            rnd.range(-25, 25),
            0.6,
            rnd.range(0.35, 0.85),
            rnd.range(0.25, 0.55),
          ),
      );
    }
    final sparkle = Paint()..color = const Color(0xCCFFFFFF);
    for (var i = 0; i < 6; i++) {
      canvas.drawCircle(
        c + Offset(r * rnd.range(-0.8, 0.8), r * rnd.range(-0.8, 0.8)),
        r * 0.025,
        sparkle,
      );
    }
  }

  void _paintCraters(
    Canvas canvas,
    Offset c,
    double r,
    SeededRandom rnd, {
    required int count,
  }) {
    final shadow = Paint()..color = const Color(0x40000000);
    final rim = Paint()
      ..color = const Color(0x33FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.015;
    for (var i = 0; i < count; i++) {
      final center =
          c + Offset(r * rnd.range(-0.75, 0.75), r * rnd.range(-0.75, 0.75));
      final radius = r * rnd.range(0.05, 0.14);
      canvas
        ..drawCircle(center, radius, shadow)
        ..drawArc(
          Rect.fromCircle(center: center, radius: radius),
          math.pi * 0.1,
          math.pi * 0.9,
          false,
          rim,
        );
    }
  }

  /// Terminator: light from the top left, shade towards the bottom right.
  void _paintShading(Canvas canvas, Offset c, double r) {
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.45, -0.5),
          radius: 1.25,
          colors: [Color(0x26FFFFFF), Color(0x00000000), Color(0xB3000000)],
          stops: [0, 0.45, 1],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );
  }

  void _paintAtmosphere(Canvas canvas, Offset c, double r) {
    final outer = r * 1.08;
    canvas.drawCircle(
      c,
      outer,
      Paint()
        ..shader = RadialGradient(
          colors: [
            _hsl(0, 0.8, 0.75, 0),
            _hsl(0, 0.8, 0.75, 0.45),
            _hsl(0, 0.8, 0.75, 0),
          ],
          stops: const [0.85, 0.93, 1],
        ).createShader(Rect.fromCircle(center: c, radius: outer)),
    );
  }

  void _paintGlow(Canvas canvas, Offset c, double r) {
    final outer = r * 1.6;
    canvas.drawCircle(
      c,
      outer,
      Paint()
        ..shader = RadialGradient(
          colors: [_hsl(0, 0.9, 0.65, 0.55), _hsl(0, 0.9, 0.65, 0)],
          stops: const [0.55, 1],
        ).createShader(Rect.fromCircle(center: c, radius: outer)),
    );
  }

  /// The ring is drawn in two halves: the back one under the planet, the
  /// front one over it.
  void _paintRing(Canvas canvas, Offset c, double r, {required bool front}) {
    canvas
      ..save()
      ..translate(c.dx, c.dy)
      ..rotate(_ringTilt)
      ..scale(1, _ringFlatten)
      ..clipRect(
        front
            ? Rect.fromLTRB(-r * 2, 0, r * 2, r * 2)
            : Rect.fromLTRB(-r * 2, -r * 2, r * 2, 0),
      );
    final rnd = SeededRandom(appearance.seed + 1);
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset.zero,
        r * (1.3 + i * 0.13),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = r * rnd.range(0.06, 0.16) / _ringFlatten
          ..color = _hsl(40, 0.5, rnd.range(0.65, 0.85), rnd.range(0.35, 0.7)),
      );
    }
    canvas.restore();
  }

  void _paintMoons(Canvas canvas, Offset c, double r, SeededRandom rnd) {
    for (var i = 0; i < appearance.moons.clamp(0, 3); i++) {
      final angle = rnd.range(0, math.pi * 2);
      final dist = r * (1.3 + i * 0.12);
      final moonR = r * rnd.range(0.09, 0.15);
      final center =
          c + Offset(math.cos(angle) * dist, math.sin(angle) * dist * 0.45);
      if (appearance.moonSkin == MoonSkin.hourglass) {
        _paintHourglassMoon(canvas, center, moonR * 1.3);
        continue;
      }
      canvas.drawCircle(
        center,
        moonR,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.4, -0.4),
            colors: [_hsl(0, 0.12, 0.85), _hsl(0, 0.15, 0.35)],
          ).createShader(Rect.fromCircle(center: center, radius: moonR)),
      );
    }
  }

  @override
  bool shouldRepaint(PlanetPainter oldDelegate) =>
      oldDelegate.appearance != appearance;
}
