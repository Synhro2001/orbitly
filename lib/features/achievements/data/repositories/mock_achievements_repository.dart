import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/cosmetic_model.dart';
import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/features/achievements/domain/repositories/achievements_repository.dart';

class MockAchievementsRepository implements AchievementsRepository {
  const MockAchievementsRepository(this._store);

  final MockStore _store;

  @override
  Future<List<Award>> getAchievements() async {
    await _store.delay();
    return parseValid(
      _store.achievements,
      (json) => AwardModel.fromJson(json).toEntity(),
    );
  }

  @override
  Stream<String> watchUnlocks() => _store.unlocks.stream;

  @override
  Future<void> markSeen(String achievementId) async {
    await _store.delay();
    final row = _store.achievements.firstWhere((a) => a['id'] == achievementId);
    if (row['unlocked_at'] != null) {
      row['seen_at'] ??= DateTime.now().toIso8601String();
    }
  }

  @override
  Future<List<Cosmetic>> getOwnedCosmetics() async {
    await _store.delay();
    return [
      for (final json in _store.cosmetics)
        if (_store.owned.contains(json['id']))
          ?CosmeticModel.fromJson({
            ...json,
            'equipped': _store.equipped.contains(json['id']),
          }).toEntity(),
    ];
  }

  @override
  Future<void> equip(String cosmeticId) async {
    await _store.delay();
    // Как на сервере: надеть можно только своё.
    if (!_store.owned.contains(cosmeticId)) {
      throw ArgumentError.value(cosmeticId, 'cosmeticId', 'Not owned');
    }
    final kind = _kindOf(cosmeticId);
    _store.equipped
      ..removeWhere((id) => _kindOf(id) == kind)
      ..add(cosmeticId);
  }

  @override
  Future<void> unequip(CosmeticKind kind) async {
    await _store.delay();
    final dbKind = cosmeticKindToDb(kind);
    _store.equipped.removeWhere((id) => _kindOf(id) == dbKind);
  }

  String? _kindOf(String cosmeticId) => _store.cosmetics
      .where((c) => c['id'] == cosmeticId)
      .map((c) => c['kind'] as String?)
      .firstOrNull;
}
