import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';

typedef _Key = (PlanetAppearance, int);

/// Кэш уже отрисованных планет: планета рисуется один раз, дальше
/// показывается готовая картинка.
class PlanetImageCache {
  PlanetImageCache._(this._budgetBytes);

  /// Кэш с другим лимитом — для тестов.
  @visibleForTesting
  PlanetImageCache.withBudget(int bytes) : this._(bytes);

  static final PlanetImageCache instance = PlanetImageCache._(
    _defaultBudgetBytes,
  );

  /// Лимит по памяти, а не по числу картинок: крупная планета весит
  /// больше мегабайта, и сотня таких заняла бы сотни мегабайт.
  static const int _defaultBudgetBytes = 64 * 1024 * 1024;

  final int _budgetBytes;
  int _bytes = 0;

  /// Сколько памяти сейчас занимают картинки.
  int get bytes => _bytes;

  // Map в Dart хранит порядок вставки — используем как LRU.
  final _images = <_Key, ui.Image>{};
  final _pending = <_Key, Future<ui.Image>>{};

  /// Размер в пикселях округляется вверх до кратного 16, чтобы близкие
  /// размеры делили одну картинку.
  static int bucket(double physicalPixels) =>
      ((physicalPixels / 16).ceil() * 16).clamp(16, 2048);

  static int _sizeOf(int pixels) => pixels * pixels * 4;

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
    _bytes += _sizeOf(key.$2);
    // Вытесненные картинки не освобождаем вручную: они могут ещё быть
    // на экране. Их освободит сборщик мусора.
    while (_bytes > _budgetBytes && _images.length > 1) {
      final oldest = _images.keys.first;
      _images.remove(oldest);
      _bytes -= _sizeOf(oldest.$2);
    }
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
