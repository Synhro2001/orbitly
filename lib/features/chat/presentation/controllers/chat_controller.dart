import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/domain/message_rules.dart';
import 'package:orbitly/features/system/presentation/controllers/system_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

/// Who has just sent a message (Realtime). The subscription is tied to the
/// user and reconnects after signing in again.
@Riverpod(keepAlive: true)
Stream<String> incomingMessages(Ref ref) {
  ref.watch(signedInProvider);
  return ref.watch(chatRepositoryProvider).watchIncoming();
}

@riverpod
Future<List<ChatPreview>> chats(Ref ref) {
  // A new message changes the chat order and the last line.
  ref.listen(incomingMessagesProvider, (_, _) => ref.invalidateSelf());
  return ref.watch(chatRepositoryProvider).getChats();
}

@riverpod
class ChatController extends _$ChatController {
  @override
  Future<ChatThread> build(String friendId) {
    // A friend wrote: reload the conversation (old messages stay on screen
    // while the new ones load).
    ref.listen(incomingMessagesProvider, (_, next) {
      if (next.value == friendId) ref.invalidateSelf();
    });
    return ref.watch(chatRepositoryProvider).getThread(friendId);
  }

  Future<void> send(String text) async {
    if (!MessageRules.isValid(text)) return;
    final trimmed = text.trim();
    _append(await ref.read(chatRepositoryProvider).sendText(friendId, trimmed));
  }

  /// Time capsule: the friend can read it only after [delay].
  Future<void> sendCapsule(String text, Duration delay) async {
    if (!MessageRules.isValid(text)) return;
    final trimmed = text.trim();
    final opensAt = ref.read(clockProvider)().add(delay);
    _append(
      await ref
          .read(chatRepositoryProvider)
          .sendCapsule(friendId, trimmed, opensAt: opensAt),
    );
  }

  void _append(Message message) {
    final current = state.value;
    if (!ref.mounted || current == null) return;
    // After my own message the conversation openers are no longer needed.
    state = AsyncData(
      current.copyWith(
        messages: [...current.messages, message],
        conversationStarters: const [],
      ),
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

  /// The chat list and the system show the last message and the unread
  /// glow, so they must be reloaded after a change.
  void _refreshLists() => ref
    ..invalidate(chatsProvider)
    ..invalidate(systemControllerProvider);
}
