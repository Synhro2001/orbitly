import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/features/friends/data/models/friends_models.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/domain/repositories/safety_repository.dart';

/// Blocks, mutes and reports in the mock store. Blocking removes the friend
/// and their chat, like the server does.
class MockSafetyRepository implements SafetyRepository {
  const MockSafetyRepository(this._store);

  final MockStore _store;

  @override
  Future<void> block(String userId) async {
    await _store.delay();
    final user =
        _store.friends.where((f) => f['id'] == userId).firstOrNull ??
        _store.directory.where((u) => u['id'] == userId).firstOrNull;
    if (user == null) return;
    _store.blocked.add({
      'id': userId,
      'name': user['name'],
      'handle': user['handle'],
      'appearance': user['appearance'],
    });
    _store.friends.removeWhere((f) => f['id'] == userId);
    _store.messages.remove(userId);
    _store.muted.remove(userId);
  }

  @override
  Future<void> unblock(String userId) async {
    await _store.delay();
    _store.blocked.removeWhere((u) => u['id'] == userId);
  }

  @override
  Future<List<UserSummary>> getBlocked() async {
    await _store.delay();
    return _users(_store.blocked);
  }

  @override
  Future<void> mute(String friendId) async {
    await _store.delay();
    _store.muted.add(friendId);
  }

  @override
  Future<void> unmute(String friendId) async {
    await _store.delay();
    _store.muted.remove(friendId);
  }

  @override
  Future<List<UserSummary>> getMuted() async {
    await _store.delay();
    return _users(_store.friends.where((f) => _store.muted.contains(f['id'])));
  }

  @override
  Future<void> report(
    String userId,
    ReportReason reason, {
    String? details,
  }) async {
    await _store.delay();
    _store.reports.add({
      'target': userId,
      'reason': reason.name,
      'details': details,
    });
  }

  List<UserSummary> _users(Iterable<Json> rows) =>
      parseValid(rows, (json) => UserSummaryModel.fromJson(json).toEntity());
}
