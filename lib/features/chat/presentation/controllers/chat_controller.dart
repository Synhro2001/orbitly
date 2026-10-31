import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/system/presentation/controllers/system_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

@riverpod
Future<List<ChatPreview>> chats(Ref ref) =>
    ref.watch(chatRepositoryProvider).getChats();

@riverpod
class ChatController extends _$ChatController {
  @override
  Future<ChatThread> build(String friendId) =>
      ref.watch(chatRepositoryProvider).getThread(friendId);

  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final message = await ref
        .read(chatRepositoryProvider)
        .sendText(friendId, trimmed);
    final current = state.value;
    if (!ref.mounted || current == null) return;
    state = AsyncData(
      current.copyWith(messages: [...current.messages, message]),
    );
    _refreshLists();
  }

  Future<void> openSnap(String messageId) async {
    await ref.read(chatRepositoryProvider).openSnap(friendId, messageId);
    final current = state.value;
    if (!ref.mounted || current == null) return;
    final messages = [
      for (final m in current.messages)
        switch (m) {
          SnapMessage(:final id) when id == messageId => m.copyWith(
            opened: true,
          ),
          _ => m,
        },
    ];
    final hasUnread = messages.any(
      (m) => m is SnapMessage && !m.isMine && !m.opened,
    );
    state = AsyncData(
      current.copyWith(
        messages: messages,
        friend: current.friend.copyWith(hasUnreadSnaps: hasUnread),
      ),
    );
    _refreshLists();
  }

  /// Список чатов и система показывают последнее сообщение и свечение
  /// непрочитанного — после изменений их нужно перечитать.
  void _refreshLists() => ref
    ..invalidate(chatsProvider)
    ..invalidate(systemControllerProvider);
}
