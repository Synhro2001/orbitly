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
  // Do not hit the server on every keystroke: if the query has changed,
  // this provider is already disposed.
  await Future<void>.delayed(_searchDebounce);
  if (!ref.mounted) return const [];
  return await ref.read(friendsRepositoryProvider).searchByHandle(query);
}

@riverpod
Future<String> inviteLink(Ref ref) =>
    ref.watch(friendsRepositoryProvider).getInviteLink();

/// Which of the found users already have a request from me.
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
      // The new friend must appear on the orbit and in chats.
      ref
        ..invalidate(systemControllerProvider)
        ..invalidate(chatsProvider);
    }
  }
}
