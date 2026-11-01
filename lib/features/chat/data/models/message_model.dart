import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@Freezed(unionKey: 'kind')
sealed class MessageModel with _$MessageModel {
  const factory MessageModel.text({
    required String id,
    required bool isMine,
    required DateTime sentAt,
    required String text,
  }) = TextMessageModel;

  const factory MessageModel.snap({
    required String id,
    required bool isMine,
    required DateTime sentAt,
    required bool opened,
  }) = SnapMessageModel;

  const factory MessageModel.capsule({
    required String id,
    required bool isMine,
    required DateTime sentAt,
    required DateTime opensAt,
    String? text,
  }) = CapsuleMessageModel;

  factory MessageModel.fromJson(Map<String, Object?> json) =>
      _$MessageModelFromJson(json);
}

extension MessageModelX on MessageModel {
  Message toEntity() => switch (this) {
    TextMessageModel(:final id, :final isMine, :final sentAt, :final text) =>
      Message.text(id: id, isMine: isMine, sentAt: sentAt, text: text),
    SnapMessageModel(:final id, :final isMine, :final sentAt, :final opened) =>
      Message.snap(id: id, isMine: isMine, sentAt: sentAt, opened: opened),
    CapsuleMessageModel(
      :final id,
      :final isMine,
      :final sentAt,
      :final opensAt,
      :final text,
    ) =>
      Message.capsule(
        id: id,
        isMine: isMine,
        sentAt: sentAt,
        opensAt: opensAt,
        text: text,
      ),
  };
}
