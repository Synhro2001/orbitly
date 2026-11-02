import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
sealed class Message with _$Message {
  const factory Message.text({
    required String id,
    required bool isMine,
    required DateTime sentAt,
    required String text,
  }) = TextMessage;

  /// Снап: фото/видео, которое можно посмотреть один раз.
  const factory Message.snap({
    required String id,
    required bool isMine,
    required DateTime sentAt,
    required bool opened,
  }) = SnapMessage;

  /// Капсула времени: послание, которое откроется только в [opensAt].
  /// [text] — `null`, пока капсула запечатана: сервер не отдаёт текст
  /// получателю раньше срока, так что подсмотреть его нельзя.
  const factory Message.capsule({
    required String id,
    required bool isMine,
    required DateTime sentAt,
    required DateTime opensAt,
    String? text,
  }) = CapsuleMessage;
}

extension CapsuleMessageX on CapsuleMessage {
  bool isOpenAt(DateTime now) => !now.isBefore(opensAt);
}
