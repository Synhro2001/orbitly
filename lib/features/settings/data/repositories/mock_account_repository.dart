import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/domain/repositories/account_repository.dart';

class MockAccountRepository implements AccountRepository {
  const MockAccountRepository(this._store);

  final MockStore _store;

  static const _grace = Duration(days: 7);

  @override
  Future<DateTime> requestDeletion() async {
    await _store.delay();
    final requested = _store.deletionRequestedAt ??= DateTime.now();
    return requested.add(_grace);
  }

  @override
  Future<bool> cancelDeletion() async {
    await _store.delay();
    final waiting = _store.deletionRequestedAt != null;
    _store.deletionRequestedAt = null;
    return waiting;
  }

  @override
  Future<Map<String, Object?>> exportData() async {
    await _store.delay();
    return {
      'exported_at': DateTime.now().toIso8601String(),
      'profile': _store.myPlanet,
      'settings': _store.settings,
      'friends': [
        for (final f in _store.friends)
          {'handle': f['handle'], 'name': f['name']},
      ],
    };
  }
}
