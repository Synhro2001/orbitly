import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/system/presentation/controllers/system_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friends_controller.g.dart';

const _searchDebounce = Duration(milliseconds: 300);

@riverpod
Future<List<UserSummary>> userSearch(Ref ref, String query) async {
  if (query.trim().isEmpty) return const [];
  // Не дёргаем сервер на каждую букву: если запрос сменился, этот
  // провайдер уже уничтожен.
  await Future<void>.delayed(_searchDebounce);
  if (!ref.mounted) return const [];
  return await ref.read(friendsRepositoryProvider).searchByHandle(query);
}

@riverpod
Future<String> inviteLink(Ref ref) =>
    ref.watch(friendsRepositoryProvider).getInviteLink();

/// Кому из найденных уже отправлена заявка.
@riverpod
class SentRequests extends _$SentRequests {
  @override
  Set<String> build() => const {};

  Future<void> send(String userId) async {
    await ref.read(friendsRepositoryProvider).sendRequest(userId);
    if (ref.mounted) state = {...state, userId};
  }
}

@riverpod
class IncomingRequests extends _$IncomingRequests {
  @override
  Future<List<FriendRequest>> build() =>
      ref.watch(friendsRepositoryProvider).getIncomingRequests();

  Future<void> respond(String requestId, {required bool accept}) async {
    await ref
        .read(friendsRepositoryProvider)
        .respondToRequest(requestId, accept: accept);
    final current = state.value;
    if (!ref.mounted || current == null) return;
    state = AsyncData([
      for (final r in current)
        if (r.id != requestId) r,
    ]);
    if (accept) {
      // Новый друг должен появиться на орбите и в чатах.
      ref
        ..invalidate(systemControllerProvider)
        ..invalidate(chatsProvider);
    }
  }
}
