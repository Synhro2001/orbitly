import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
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
      awards: [
        for (final award in _store.awards)
          AwardModel.fromJson(award).toEntity(),
      ],
    );
  }

  @override
  Future<void> createPlanet({
    required String name,
    required PlanetAppearance appearance,
  }) async {
    await _store.delay();
    _store.createPlanet(
      name,
      PlanetAppearanceModel.fromEntity(appearance).toJson(),
    );
  }

  @override
  Future<void> setMood(Mood mood) async {
    await _store.delay();
    _store.myPlanet?['mood'] = mood.name;
  }
}
