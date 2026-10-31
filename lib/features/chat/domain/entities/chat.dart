import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';

part 'chat.freezed.dart';

@freezed
abstract class ChatThread with _$ChatThread {
  const factory ChatThread({
    required Friend friend,
    required List<Message> messages,
    required List<Award> sharedTrophies,
  }) = _ChatThread;
}

/// Строка в списке чатов.
@freezed
abstract class ChatPreview with _$ChatPreview {
  const factory ChatPreview({
    required Friend friend,
    required Message? lastMessage,
  }) = _ChatPreview;
}
