import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';

/// Достижения и награды. Открывает их только сервер; клиент читает,
/// отмечает «просмотрено» и надевает открытое.
abstract interface class AchievementsRepository {
  /// Весь каталог с моим прогрессом. Секретные неоткрытые — без названия.
  Future<List<Award>> getAchievements();

  /// id достижений, которые только что открылись.
  Stream<String> watchUnlocks();

  Future<void> markSeen(String achievementId);

  /// Открытая косметика (с отметкой, что надето).
  Future<List<Cosmetic>> getOwnedCosmetics();

  /// Надеть; надетая вещь того же вида снимается.
  Future<void> equip(String cosmeticId);

  Future<void> unequip(CosmeticKind kind);
}
