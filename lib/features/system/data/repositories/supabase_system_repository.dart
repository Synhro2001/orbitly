import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/cosmetic_model.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/core/data/models/shadow_json.dart';
import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/streak.dart';
import 'package:orbitly/core/domain/usecases/apply_cosmetics.dart';
import 'package:orbitly/features/system/domain/entities/moment.dart';
import 'package:orbitly/features/system/domain/repositories/system_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSystemRepository implements SystemRepository {
  const SupabaseSystemRepository(this._client);

  final SupabaseClient _client;

  /// Друзья, близость, серия, надетая косметика и общие трофеи — одной
  /// функцией на сервере (get_my_friends).
  @override
  Future<List<Friend>> getFriends() async {
    final rows = await _client.rpc<List<dynamic>>('get_my_friends');
    return parseValid(rows.cast<Map<String, dynamic>>(), friendFromRpcRow);
  }

  /// Моменты появятся вместе с историями и хранилищем медиа.
  @override
  Future<List<Moment>> getMoments() async => const [];

  @override
  Future<void> markMomentSeen(String momentId) async {}
}

/// Строка get_my_friends() → друг. Внешний вид = база + надетые награды.
Friend friendFromRpcRow(Map<String, Object?> row) {
  final base = PlanetAppearanceModel.fromJson(
    row['appearance']! as Map<String, Object?>,
  ).toEntity();
  final equipped = [
    for (final cosmetic in parseValid([
      for (final c in row['equipped']! as List<Object?>)
        c! as Map<String, Object?>,
    ], CosmeticModel.fromJson))
      ?cosmetic.toEntity(),
  ];
  final trophies = parseValid([
    for (final t in row['trophies']! as List<Object?>)
      {
        ...t! as Map<String, Object?>,
        'category': 'friendship',
        'unlocked_at': (t as Map<String, Object?>)['earned_at'],
      },
  ], (json) => AwardModel.fromJson(json).toEntity());
  return Friend(
    id: row['id']! as String,
    name: row['display_name']! as String,
    handle: row['handle']! as String,
    appearance: const ApplyCosmetics()(base, equipped),
    closeness: (row['closeness']! as num).toInt().clamp(0, 100),
    streak: Streak(
      days: (row['streak_days']! as num).toInt(),
      lastExchangeAt:
          DateTime.tryParse('${row['last_exchange_at']}') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    ),
    mood: Mood.values.asNameMap()[row['mood']] ?? Mood.calm,
    hasUnreadSnaps: row['has_unread_snaps'] == true,
    shadow: shadowFromFields(
      DateTime.tryParse('${row['shadow_from']}'),
      DateTime.tryParse('${row['shadow_until']}'),
    ),
    sharedTrophies: trophies,
  );
}
