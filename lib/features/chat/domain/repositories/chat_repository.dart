import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';

abstract interface class ChatRepository {
  /// Chats, most recent first.
  Future<List<ChatPreview>> getChats();

  Future<ChatThread> getThread(String friendId);

  Future<Message> sendText(String friendId, String text);

  Future<void> openSnap(String friendId, String messageId);

  Future<Message> sendCapsule(
    String friendId,
    String text, {
    required DateTime opensAt,
  });

  /// Ids of friends who have just sent a message. No text: it is a signal
  /// to reload the conversation.
  Stream<String> watchIncoming();
}
