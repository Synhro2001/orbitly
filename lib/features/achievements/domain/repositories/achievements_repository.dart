import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';

/// Achievements and rewards. Only the server unlocks them; the client reads,
/// marks them as seen and wears what is unlocked.
abstract interface class AchievementsRepository {
  /// The whole catalogue with my progress. Locked secrets come without title.
  Future<List<Award>> getAchievements();

  /// Ids of achievements that have just unlocked.
  Stream<String> watchUnlocks();

  Future<void> markSeen(String achievementId);

  /// Unlocked cosmetics, each marked as worn or not.
  Future<List<Cosmetic>> getOwnedCosmetics();

  /// Wear an item; a worn item of the same kind is taken off.
  Future<void> equip(String cosmeticId);

  Future<void> unequip(CosmeticKind kind);
}
