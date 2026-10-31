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
  const factory Message.capsule({
    required String id,
    required bool isMine,
    required DateTime sentAt,
    required DateTime opensAt,
    required String text,
  }) = CapsuleMessage;
}

extension CapsuleMessageX on CapsuleMessage {
  bool isOpenAt(DateTime now) => !now.isBefore(opensAt);
}
