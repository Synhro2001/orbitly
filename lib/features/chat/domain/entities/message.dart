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

  /// Snap: a photo/video that can be viewed once.
  const factory Message.snap({
    required String id,
    required bool isMine,
    required DateTime sentAt,
    required bool opened,
  }) = SnapMessage;

  /// Time capsule: a message that opens only at [opensAt]. [text] is `null`
  /// while the capsule is sealed: the server does not send the text to the
  /// recipient early, so there is no way to peek.
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
