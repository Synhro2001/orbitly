import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// Source of the current time; tests replace it with a fixed one.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;
