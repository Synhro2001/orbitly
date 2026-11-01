import 'package:freezed_annotation/freezed_annotation.dart';

part 'shadow.freezed.dart';

/// «Тень»: человек на время ушёл из сети (экзамены, отпуск). Пока он в
/// тени, его серии с друзьями не сгорают.
@freezed
abstract class Shadow with _$Shadow {
  const factory Shadow({required DateTime from, required DateTime until}) =
      _Shadow;

  const Shadow._();

  bool isActiveAt(DateTime now) => !now.isBefore(from) && now.isBefore(until);
}
