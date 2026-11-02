import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/domain/repositories/safety_repository.dart';
import 'package:orbitly/features/system/presentation/controllers/system_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'safety_controller.g.dart';

@riverpod
Future<List<UserSummary>> blockedUsers(Ref ref) =>
    ref.watch(safetyRepositoryProvider).getBlocked();

@riverpod
Future<List<UserSummary>> mutedFriends(Ref ref) =>
    ref.watch(safetyRepositoryProvider).getMuted();

/// Block, quiet orbit and reports, with the lists and screens they change
/// reloaded afterwards. Kept alive: nothing watches it, and an action must
/// not lose its ref halfway.
@Riverpod(keepAlive: true)
class SafetyActions extends _$SafetyActions {
  @override
  void build() {}

  SafetyRepository get _repository => ref.read(safetyRepositoryProvider);

  Future<void> block(String userId) async {
    await _repository.block(userId);
    _refresh();
  }

  Future<void> unblock(String userId) async {
    await _repository.unblock(userId);
    _refresh();
  }

  Future<void> mute(String friendId) async {
    await _repository.mute(friendId);
    _refresh();
  }

  Future<void> unmute(String friendId) async {
    await _repository.unmute(friendId);
    _refresh();
  }

  Future<void> report(String userId, ReportReason reason, {String? details}) =>
      _repository.report(userId, reason, details: details);

  /// The orbit, the chats and both lists depend on blocks and mutes.
  void _refresh() => ref
    ..invalidate(blockedUsersProvider)
    ..invalidate(mutedFriendsProvider)
    ..invalidate(systemControllerProvider)
    ..invalidate(chatsProvider);
}
