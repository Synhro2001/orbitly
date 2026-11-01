import 'package:freezed_annotation/freezed_annotation.dart';

part 'award.freezed.dart';

/// Награда/трофей. Название и значок приходят с сервера как контент.
@freezed
abstract class Award with _$Award {
  const factory Award({
    required String id,
    required String title,
    required String emoji,
    required bool unlocked,
  }) = _Award;
}
