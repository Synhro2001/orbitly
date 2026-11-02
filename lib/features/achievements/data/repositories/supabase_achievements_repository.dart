import 'dart:async';

import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/cosmetic_model.dart';
import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/core/data/supabase/rpc_rows.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/features/achievements/domain/repositories/achievements_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAchievementsRepository implements AchievementsRepository {
  const SupabaseAchievementsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Award>> getAchievements() async {
    return parseValid(
      await _client.rpcRows('get_my_achievements'),
      (json) => AwardModel.fromJson(json).toEntity(),
    );
  }

  /// Realtime: сервер вставляет/обновляет мои строки в user_achievements;
  /// RLS пропускает только мои.
  @override
  Stream<String> watchUnlocks() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return const Stream.empty();

    final controller = StreamController<String>();
    void onChange(PostgresChangePayload payload) {
      final record = payload.newRecord;
      if (record['unlocked_at'] != null &&
          record['seen_at'] == null &&
          record['achievement_id'] is String) {
        controller.add(record['achievement_id'] as String);
      }
    }

    final filter = PostgresChangeFilter(
      type: PostgresChangeFilterType.eq,
      column: 'user_id',
      value: userId,
    );
    final channel = _client
        .channel('achievements-$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'user_achievements',
          filter: filter,
          callback: onChange,
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'user_achievements',
          filter: filter,
          callback: onChange,
        )
        .subscribe();
    controller.onCancel = () => _client.removeChannel(channel);
    return controller.stream;
  }

  @override
  Future<void> markSeen(String achievementId) => _client.rpc<void>(
    'mark_achievement_seen',
    params: {'p_achievement_id': achievementId},
  );

  @override
  Future<List<Cosmetic>> getOwnedCosmetics() async {
    final rows = await _client
        .from('user_cosmetics')
        .select('equipped, cosmetics(*)')
        .eq('user_id', _client.auth.currentUser!.id);
    return [
      for (final row in rows)
        if (row['cosmetics'] case final Map<String, dynamic> cosmetic)
          ?_tryCosmetic({...cosmetic, 'equipped': row['equipped']}),
    ];
  }

  @override
  Future<void> equip(String cosmeticId) => _client.rpc<void>(
    'equip_cosmetic',
    params: {'p_cosmetic_id': cosmeticId},
  );

  @override
  Future<void> unequip(CosmeticKind kind) => _client.rpc<void>(
    'unequip_cosmetic',
    params: {'p_kind': cosmeticKindToDb(kind)},
  );

  Cosmetic? _tryCosmetic(Map<String, dynamic> json) =>
      parseValid([json], CosmeticModel.fromJson).firstOrNull?.toEntity();
}
