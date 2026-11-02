import 'package:freezed_annotation/freezed_annotation.dart';

part 'award.freezed.dart';

enum Rarity { common, rare, epic, legendary }

enum AwardCategory { friendship, streak, closeness, collection, secret }

/// Достижение (или общий трофей дружбы). Название, описание и значок — контент
/// с сервера. У секретного неоткрытого достижения их нет: сервер их не отдаёт.
@freezed
abstract class Award with _$Award {
  const factory Award({
    required String id,
    required AwardCategory category,
    required Rarity rarity,
    String? title,
    String? description,
    String? emoji,
    @Default(0) int progress,
    @Default(1) int target,
    @Default(false) bool hidden,

    /// Общее для двух друзей: открывается у обоих.
    @Default(false) bool pair,

    /// Косметика, которую даёт достижение.
    String? rewardId,
    String? rewardTitle,
    DateTime? unlockedAt,
    DateTime? seenAt,
  }) = _Award;

  const Award._();

  bool get unlocked => unlockedAt != null;

  /// Секрет, который ещё не открыт: показываем «???».
  bool get isSecretLocked => hidden && !unlocked;

  /// Открыто, но анимацию открытия ещё не показывали.
  bool get isNew => unlocked && seenAt == null;

  double get progressFraction =>
      unlocked ? 1 : (target <= 0 ? 0 : (progress / target).clamp(0, 1));
}
