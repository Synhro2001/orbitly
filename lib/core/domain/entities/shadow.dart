import 'package:freezed_annotation/freezed_annotation.dart';

part 'shadow.freezed.dart';

/// "Shadow": the person is offline for a while (exams, holiday). While they
/// are in shadow, their streaks with friends do not burn out.
@freezed
abstract class Shadow with _$Shadow {
  const factory Shadow({required DateTime from, required DateTime until}) =
      _Shadow;

  const Shadow._();

  bool isActiveAt(DateTime now) => !now.isBefore(from) && now.isBefore(until);
}
