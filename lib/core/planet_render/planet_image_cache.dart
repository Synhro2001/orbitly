import 'dart:async';
import 'dart:ui' as ui;

import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';

typedef _Key = (PlanetAppearance, int);

/// Кэш уже отрисованных планет: планета рисуется один раз, дальше
/// показывается готовая картинка.
class PlanetImageCache {
  PlanetImageCache._();

  static final instance = PlanetImageCache._();

  static const _maxEntries = 100;

  // Map в Dart хранит порядок вставки — используем как LRU.
  final _images = <_Key, ui.Image>{};
  final _pending = <_Key, Future<ui.Image>>{};

  /// Размер в пикселях округляется вверх до кратного 16, чтобы близкие
  /// размеры делили одну картинку.
  static int bucket(double physicalPixels) =>
      ((physicalPixels / 16).ceil() * 16).clamp(16, 2048);

  ui.Image? get(PlanetAppearance appearance, int pixels) {
    final key = (appearance, pixels);
    final image = _images.remove(key);
    if (image != null) _images[key] = image;
    return image;
  }

  Future<ui.Image> render(PlanetAppearance appearance, int pixels) {
    final key = (appearance, pixels);
    final cached = get(appearance, pixels);
    if (cached != null) return Future.value(cached);
    return _pending[key] ??= _drawAndStore(key);
  }

  Future<ui.Image> _drawAndStore(_Key key) async {
    final image = await _draw(key.$1, key.$2);
    unawaited(_pending.remove(key));
    _images[key] = image;
    // Вытесненные картинки не освобождаем вручную: они могут ещё быть
    // на экране. Их освободит сборщик мусора.
    if (_images.length > _maxEntries) _images.remove(_images.keys.first);
    return image;
  }

  Future<ui.Image> _draw(PlanetAppearance appearance, int pixels) {
    final recorder = ui.PictureRecorder();
    final size = ui.Size.square(pixels.toDouble());
    PlanetPainter(appearance).paint(ui.Canvas(recorder), size);
    final picture = recorder.endRecording();
    return picture.toImage(pixels, pixels).whenComplete(picture.dispose);
  }
}
