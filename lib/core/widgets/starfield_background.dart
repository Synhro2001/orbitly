import 'package:flutter/material.dart';
import 'package:orbitly/core/planet_render/seeded_random.dart';
import 'package:orbitly/core/theme/app_colors.dart';

/// Dark space with stars. Static, painted once.
class StarfieldBackground extends StatelessWidget {
  const StarfieldBackground({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const RepaintBoundary(child: CustomPaint(painter: _StarfieldPainter())),
        ?child,
      ],
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  const _StarfieldPainter();

  static const _starCount = 160;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(0, -0.2),
          radius: 1.1,
          colors: [
            AppColors.spaceGlow,
            AppColors.spaceMid,
            AppColors.spaceDeep,
          ],
          stops: [0, 0.45, 1],
        ).createShader(rect),
    );
    final rnd = SeededRandom(42);
    final paint = Paint();
    for (var i = 0; i < _starCount; i++) {
      paint.color = AppColors.star.withValues(alpha: rnd.range(0.15, 0.9));
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        rnd.range(0.4, 1.4),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarfieldPainter oldDelegate) => false;
}
