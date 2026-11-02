import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/friend_model.dart';
import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/features/chat/data/models/message_model.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/domain/message_rules.dart';
import 'package:orbitly/features/chat/domain/repositories/chat_repository.dart';

class MockChatRepository implements ChatRepository {
  const MockChatRepository(this._store);

  final MockStore _store;

  List<Message> _messages(String friendId) => parseValid([
    for (final json in _store.messages[friendId] ?? const <Json>[])
      _sealed(json),
  ], (json) => MessageModel.fromJson(json).toEntity());

  /// Like the server: a friend's capsule text is not sent before it opens.
  Json _sealed(Json json) {
    if (json['kind'] != 'capsule' || json['is_mine'] == true) return json;
    final opensAt = DateTime.tryParse(json['opens_at'] as String? ?? '');
    if (opensAt != null && !DateTime.now().isBefore(opensAt)) return json;
    return {...json}..remove('text');
  }

  @override
  Future<List<ChatPreview>> getChats() async {
    await _store.delay();
    final chats = parseValid(
      _store.friendsJson(),
      (json) => ChatPreview(
        friend: FriendModel.fromJson(json).toEntity(),
        lastMessage: _messages(json['id']! as String).lastOrNull,
      ),
    );
    return newestFirst(chats);
  }

  @override
  Future<ChatThread> getThread(String friendId) async {
    await _store.delay();
    final trophyIds = _store.sharedTrophyIds[friendId] ?? const [];
    final friend = FriendModel.fromJson(_store.friendJson(friendId)).toEntity();
    return ChatThread(
      friend: friend,
      messages: _messages(friendId),
      sharedTrophies: [
        for (final json in _store.achievements)
          if (trophyIds.contains(json['id']))
            AwardModel.fromJson(json).toEntity(),
      ],
      suggestOpeners: _store.isDrifting(friendId),
    );
  }

  @override
  Future<Message> sendText(String friendId, String text) async {
    await _store.delay();
    if (!MessageRules.isValid(text)) {
      throw ArgumentError.value(text.length, 'text', 'Invalid message length');
    }
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
    if (!MessageRules.isValid(text)) {
      throw ArgumentError.value(text.length, 'text', 'Invalid message length');
    }
    if (!MessageRules.isValidCapsuleDate(opensAt, now: DateTime.now())) {
      throw ArgumentError.value(opensAt, 'opensAt', 'Out of allowed range');
    }
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

  /// Mocks have no one on the other side, so no new messages arrive.
  @override
  Stream<String> watchIncoming() => const Stream.empty();

  @override
  Future<void> openSnap(String friendId, String messageId) async {
    await _store.delay();
    _store.messages[friendId]!.firstWhere(
      (m) => m['id'] == messageId,
    )['opened'] = true;
  }
}
