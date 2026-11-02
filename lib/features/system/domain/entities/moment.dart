import 'package:freezed_annotation/freezed_annotation.dart';

part 'moment.freezed.dart';

/// A friend's moment: a circle in the top row of the main screen.
@freezed
abstract class Moment with _$Moment {
  const factory Moment({
    required String id,
    required String friendId,
    required bool seen,
    required DateTime postedAt,
  }) = _Moment;
}
