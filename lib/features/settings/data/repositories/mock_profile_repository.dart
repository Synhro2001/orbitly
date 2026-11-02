import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/domain/repositories/profile_repository.dart';

/// The same rules as the server: handles of friends and of the directory
/// are taken, and a handle changes at most once in 30 days.
class MockProfileRepository implements ProfileRepository {
  const MockProfileRepository(this._store);

  final MockStore _store;

  static const _changeEvery = Duration(days: 30);

  @override
  Future<void> rename({String? displayName, String? planetName}) async {
    await _store.delay();
    final planet = _store.myPlanet;
    if (planet == null) return;
    if (displayName != null) planet['display_name'] = displayName.trim();
    if (planetName != null) planet['planet_name'] = planetName.trim();
  }

  @override
  Future<HandleStatus> checkHandle(String handle) async {
    await _store.delay();
    return _status(normalizeHandle(handle));
  }

  @override
  Future<void> changeHandle(String handle) async {
    await _store.delay();
    final h = normalizeHandle(handle);
    final status = _status(h);
    if (status == HandleStatus.mine) return;
    final changedAt = DateTime.tryParse(
      '${_store.myPlanet?['handle_changed_at']}',
    );
    if (changedAt != null &&
        DateTime.now().difference(changedAt) < _changeEvery) {
      throw const HandleChangeException(HandleStatus.tooSoon);
    }
    if (status != HandleStatus.ok) throw HandleChangeException(status);
    _store.myPlanet
      ?..['handle'] = h
      ..['handle_changed_at'] = DateTime.now().toIso8601String();
  }

  HandleStatus _status(String h) {
    if (!handlePattern.hasMatch(h)) return HandleStatus.invalid;
    if (_store.myPlanet?['handle'] == h) return HandleStatus.mine;
    final taken = [
      ..._store.friends,
      ..._store.directory,
    ].any((user) => user['handle'] == h);
    return taken ? HandleStatus.taken : HandleStatus.ok;
  }
}
