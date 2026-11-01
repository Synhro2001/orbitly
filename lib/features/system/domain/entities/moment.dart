import 'package:freezed_annotation/freezed_annotation.dart';

part 'moment.freezed.dart';

/// Момент друга — кружок в верхнем ряду главного экрана.
@freezed
abstract class Moment with _$Moment {
  const factory Moment({
    required String id,
    required String friendId,
    required bool seen,
    required DateTime postedAt,
  }) = _Moment;
}
