import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// Источник текущего времени; в тестах подменяется фиксированным.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;
