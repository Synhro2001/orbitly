import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/friend_model.dart';
import 'package:orbitly/features/chat/data/models/message_model.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/domain/repositories/chat_repository.dart';

class MockChatRepository implements ChatRepository {
  const MockChatRepository(this._store);

  final MockStore _store;

  List<Message> _messages(String friendId) => [
    for (final json in _store.messages[friendId] ?? const <Json>[])
      MessageModel.fromJson(json).toEntity(),
  ];

  @override
  Future<List<ChatPreview>> getChats() async {
    await _store.delay();
    final chats = [
      for (final json in _store.friendsJson())
        ChatPreview(
          friend: FriendModel.fromJson(json).toEntity(),
          lastMessage: _messages(json['id']! as String).lastOrNull,
        ),
    ];
    final epoch = DateTime.fromMillisecondsSinceEpoch(0);
    return chats..sort(
      (a, b) => (b.lastMessage?.sentAt ?? epoch).compareTo(
        a.lastMessage?.sentAt ?? epoch,
      ),
    );
  }

  @override
  Future<ChatThread> getThread(String friendId) async {
    await _store.delay();
    final trophyIds = _store.sharedTrophyIds[friendId] ?? const [];
    return ChatThread(
      friend: FriendModel.fromJson(_store.friendJson(friendId)).toEntity(),
      messages: _messages(friendId),
      sharedTrophies: [
        for (final json in _store.awards)
          if (trophyIds.contains(json['id']))
            AwardModel.fromJson(json).toEntity(),
      ],
      conversationStarters: _store.conversationStarters(friendId),
    );
  }

  @override
  Future<Message> sendText(String friendId, String text) async {
    await _store.delay();
    final json = <String, Object?>{
      'kind': 'text',
      'id': _store.nextId('msg'),
      'is_mine': true,
      'sent_at': DateTime.now().toIso8601String(),
      'text': text,
    };
    (_store.messages[friendId] ??= []).add(json);
    return MessageModel.fromJson(json).toEntity();
  }

  @override
  Future<Message> sendCapsule(
    String friendId,
    String text, {
    required DateTime opensAt,
  }) async {
    await _store.delay();
    final json = <String, Object?>{
      'kind': 'capsule',
      'id': _store.nextId('msg'),
      'is_mine': true,
      'sent_at': DateTime.now().toIso8601String(),
      'opens_at': opensAt.toIso8601String(),
      'text': text,
    };
    (_store.messages[friendId] ??= []).add(json);
    return MessageModel.fromJson(json).toEntity();
  }

  @override
  Future<void> openSnap(String friendId, String messageId) async {
    await _store.delay();
    _store.messages[friendId]!.firstWhere(
      (m) => m['id'] == messageId,
    )['opened'] = true;
  }
}
