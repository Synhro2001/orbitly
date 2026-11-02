import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/cosmetic_model.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/core/data/models/shadow_json.dart';
import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/core/data/supabase/rpc_rows.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/message_retention.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/streak.dart';
import 'package:orbitly/core/domain/usecases/apply_cosmetics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// My accepted friends with closeness, streak, equipped cosmetics and
/// shared trophies — one server call (get_my_friends).
Future<List<Friend>> fetchMyFriends(SupabaseClient client) async =>
    parseValid(await client.rpcRows('get_my_friends'), friendFromRpcRow);

/// A get_my_friends() row → friend. Appearance = base + worn rewards.
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
    // Null: hidden by the friend's settings (or unknown to this version).
    mood: Mood.values.asNameMap()[row['mood']],
    hasUnreadSnaps: row['has_unread_snaps'] == true,
    muted: row['muted'] == true,
    messageRetention:
        MessageRetention.values.asNameMap()[row['message_retention']] ??
        MessageRetention.keep,
    shadow: shadowFromFields(
      DateTime.tryParse('${row['shadow_from']}'),
      DateTime.tryParse('${row['shadow_until']}'),
    ),
    sharedTrophies: trophies,
  );
}
