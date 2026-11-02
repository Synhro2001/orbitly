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

    /// Подсказки, с чего начать разговор. Сервер присылает их, когда друг
    /// отдаляется или серия дала трещину; иначе список пуст.
    @Default([]) List<String> conversationStarters,
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

/// Chats with the freshest message first; chats without messages go last.
List<ChatPreview> newestFirst(List<ChatPreview> chats) {
  final epoch = DateTime.fromMillisecondsSinceEpoch(0);
  return chats..sort(
    (a, b) => (b.lastMessage?.sentAt ?? epoch).compareTo(
      a.lastMessage?.sentAt ?? epoch,
    ),
  );
}
