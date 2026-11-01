import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/models/friend_model.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/features/system/data/models/moment_model.dart';
import 'package:orbitly/features/system/domain/entities/moment.dart';
import 'package:orbitly/features/system/domain/repositories/system_repository.dart';

class MockSystemRepository implements SystemRepository {
  const MockSystemRepository(this._store);

  final MockStore _store;

  @override
  Future<List<Friend>> getFriends() async {
    await _store.delay();
    return [
      for (final json in _store.friendsJson())
        FriendModel.fromJson(json).toEntity(),
    ];
  }

  @override
  Future<List<Moment>> getMoments() async {
    await _store.delay();
    return [
      for (final json in _store.moments) MomentModel.fromJson(json).toEntity(),
    ];
  }

  @override
  Future<void> markMomentSeen(String momentId) async {
    await _store.delay();
    _store.moments.firstWhere((m) => m['id'] == momentId)['seen'] = true;
  }
}
