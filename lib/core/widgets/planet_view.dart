import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_image_cache.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';

/// A planet of [size] (including the margins for rings and moons).
///
/// Shows the cached image by default. `live: true` draws it directly every
/// frame, for previews where the appearance changes on the fly.
class PlanetView extends StatefulWidget {
  const PlanetView({
    required this.appearance,
    required this.size,
    this.live = false,
    this.opacity = 1,
    super.key,
  });

  final PlanetAppearance appearance;
  final double size;
  final bool live;

  /// Opacity without a separate layer (Opacity widget): cheaper every frame.
  final double opacity;

  @override
  State<PlanetView> createState() => _PlanetViewState();
}

class _PlanetViewState extends State<PlanetView> {
  ui.Image? _image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolve();
  }

  @override
  void didUpdateWidget(PlanetView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.appearance != widget.appearance ||
        oldWidget.size != widget.size ||
        oldWidget.live != widget.live) {
      _resolve();
    }
  }

  void _resolve() {
    if (widget.live) {
      _image = null;
      return;
    }
    final appearance = widget.appearance;
    final pixels = PlanetImageCache.bucket(
      widget.size * MediaQuery.devicePixelRatioOf(context),
    );
    final cache = PlanetImageCache.instance;
    _image = cache.get(appearance, pixels);
    if (_image != null) return;
    unawaited(
      cache.render(appearance, pixels).then((image) {
        if (mounted && widget.appearance == appearance && !widget.live) {
          setState(() => _image = image);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final image = _image;
    return RepaintBoundary(
      child: SizedBox.square(
        dimension: widget.size,
        // While the image is being prepared, draw directly: no blank frame.
        child: image != null
            ? RawImage(
                image: image,
                fit: BoxFit.contain,
                opacity: widget.opacity == 1
                    ? null
                    : AlwaysStoppedAnimation(widget.opacity),
              )
            : Opacity(
                opacity: widget.opacity,
                child: CustomPaint(painter: PlanetPainter(widget.appearance)),
              ),
      ),
    );
  }
}
