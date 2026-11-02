import 'dart:async';

import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/core/data/supabase/friend_rows.dart';
import 'package:orbitly/core/data/supabase/rpc_rows.dart';
import 'package:orbitly/features/chat/data/conversation_starters.dart';
import 'package:orbitly/features/chat/data/models/message_model.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/domain/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Чат через функции на сервере. Таблицу messages клиент не читает: сервер
/// сам прячет текст чужой капсулы до срока.
class SupabaseChatRepository implements ChatRepository {
  const SupabaseChatRepository(this._client);

  final SupabaseClient _client;

  /// Через сколько тишины подсказываем, с чего начать разговор.
  static const _quietFor = Duration(hours: 24);

  @override
  Future<List<ChatPreview>> getChats() async {
    final (friends, previews) = await (
      fetchMyFriends(_client),
      _client.rpcRows('get_chat_previews'),
    ).wait;
    final lastByFriend = <String, Message>{
      for (final row in previews)
        if ((row['friend_id'], _tryMessage(row)) case (
          final String id,
          final Message message,
        ))
          id: message,
    };
    return newestFirst([
      for (final friend in friends)
        ChatPreview(friend: friend, lastMessage: lastByFriend[friend.id]),
    ]);
  }

  @override
  Future<ChatThread> getThread(String friendId) async {
    final (friends, rows) = await (
      fetchMyFriends(_client),
      _client.rpcRows('get_thread', params: {'p_friend': friendId}),
    ).wait;
    final friend = friends.firstWhere(
      (f) => f.id == friendId,
      orElse: () => throw StateError('Not a friend: $friendId'),
    );
    final quiet =
        DateTime.now().difference(friend.streak.lastExchangeAt) > _quietFor;
    return ChatThread(
      friend: friend,
      messages: messagesFromRpcRows(rows),
      sharedTrophies: friend.sharedTrophies,
      conversationStarters: quiet
          ? conversationStarters(friend.name)
          : const [],
    );
  }

  @override
  Future<Message> sendText(String friendId, String text) async {
    final rows = await _client.rpcRows(
      'send_message',
      params: {'p_to': friendId, 'p_text': text},
    );
    return messagesFromRpcRows(rows).single;
  }

  @override
  Future<Message> sendCapsule(
    String friendId,
    String text, {
    required DateTime opensAt,
  }) async {
    final rows = await _client.rpcRows(
      'send_capsule',
      params: {
        'p_to': friendId,
        'p_text': text,
        'p_opens_at': opensAt.toUtc().toIso8601String(),
      },
    );
    return messagesFromRpcRows(rows).single;
  }

  @override
  Future<void> openSnap(String friendId, String messageId) =>
      _client.rpc<void>('open_snap', params: {'p_message': messageId});

  /// Realtime: сервер пишет в журнал interactions строку на каждое
  /// сообщение. В ней нет текста — только кто и кому; RLS пропускает
  /// только мои строки. По сигналу приложение перечитывает переписку.
  @override
  Stream<String> watchIncoming() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return const Stream.empty();

    final controller = StreamController<String>();
    final channel = _client
        .channel('chat-$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'interactions',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'to_user',
            value: userId,
          ),
          callback: (payload) {
            if (payload.newRecord['from_user'] case final String from) {
              controller.add(from);
            }
          },
        )
        .subscribe();
    controller.onCancel = () => _client.removeChannel(channel);
    return controller.stream;
  }
}

/// Строки get_thread / send_message → сообщения. Битые пропускаются.
List<Message> messagesFromRpcRows(List<Map<String, dynamic>> rows) => [
  for (final row in rows) ?_tryMessage(row),
];

Message? _tryMessage(Map<String, dynamic> row) => parseValid([
  row,
], (json) => MessageModel.fromJson(json).toEntity()).firstOrNull;
