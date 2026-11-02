import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/models/cosmetic_model.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/core/data/models/shadow_json.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/domain/usecases/shadow_policy.dart';
import 'package:orbitly/features/planet/data/models/my_planet_model.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/planet/domain/repositories/planet_repository.dart';

class MockPlanetRepository implements PlanetRepository {
  const MockPlanetRepository(this._store);

  final MockStore _store;

  @override
  Future<bool> hasPlanet() async {
    await _store.delay();
    return _store.myPlanet != null;
  }

  @override
  Future<MyPlanet> getMyPlanet() async {
    await _store.delay();
    final json = _store.myPlanet;
    if (json == null) throw StateError('Planet is not created yet');
    return MyPlanetModel.fromJson(json).toEntity(
      equipped: [
        for (final c in _store.cosmetics)
          if (_store.equipped.contains(c['id']))
            ?CosmeticModel.fromJson({...c, 'equipped': true}).toEntity(),
      ],
    );
  }

  @override
  Future<void> createPlanet({
    required String displayName,
    required String name,
    required PlanetAppearance appearance,
  }) async {
    await _store.delay();
    _store.createPlanet(
      name,
      PlanetAppearanceModel.fromEntity(appearance).toJson(),
      displayName: displayName,
    );
  }

  @override
  Future<void> setMood(Mood mood) async {
    await _store.delay();
    _store.myPlanet?['mood'] = mood.name;
  }

  @override
  Future<void> enterShadow(Duration duration) async {
    await _store.delay();
    final json = _store.myPlanet;
    if (json == null) return;
    final now = DateTime.now();
    final shadow = Shadow(from: now, until: now.add(duration));
    // Same rule as the server: no new shadow on top of the current one.
    if ((_currentShadow(json)?.isActiveAt(now) ?? false) ||
        !const ShadowPolicy().isAllowed(shadow, now: now)) {
      throw ArgumentError.value(duration, 'duration', 'Not allowed');
    }
    json
      ..['shadow_from'] = shadow.from.toIso8601String()
      ..['shadow_until'] = shadow.until.toIso8601String();
  }

  @override
  Future<void> leaveShadow() async {
    await _store.delay();
    final json = _store.myPlanet;
    final now = DateTime.now();
    if (json == null || !(_currentShadow(json)?.isActiveAt(now) ?? false)) {
      return;
    }
    json['shadow_until'] = now.toIso8601String();
  }

  Shadow? _currentShadow(Json json) => shadowFromFields(
    DateTime.tryParse('${json['shadow_from']}'),
    DateTime.tryParse('${json['shadow_until']}'),
  );
}
