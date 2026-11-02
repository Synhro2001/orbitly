import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';

abstract interface class ChatRepository {
  /// Чаты, свежие сверху.
  Future<List<ChatPreview>> getChats();

  Future<ChatThread> getThread(String friendId);

  Future<Message> sendText(String friendId, String text);

  Future<void> openSnap(String friendId, String messageId);

  Future<Message> sendCapsule(
    String friendId,
    String text, {
    required DateTime opensAt,
  });

  /// id друзей, от которых только что пришло сообщение. Без текста:
  /// это сигнал перечитать переписку.
  Stream<String> watchIncoming();
}
