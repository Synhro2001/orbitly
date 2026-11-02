import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/localized_text.dart';

part 'award.freezed.dart';

enum Rarity { common, rare, epic, legendary }

enum AwardCategory { friendship, streak, closeness, collection, secret }

/// An achievement (or a shared friendship trophy). Title, description and
/// icon are server content; a locked secret has none, the server hides them.
@freezed
abstract class Award with _$Award {
  const factory Award({
    required String id,
    required AwardCategory category,
    required Rarity rarity,
    LocalizedText? title,
    LocalizedText? description,
    String? emoji,
    @Default(0) int progress,
    @Default(1) int target,
    @Default(false) bool hidden,

    /// Shared by two friends: unlocks for both.
    @Default(false) bool pair,

    /// The cosmetic this achievement rewards.
    String? rewardId,
    LocalizedText? rewardTitle,
    DateTime? unlockedAt,
    DateTime? seenAt,
  }) = _Award;

  const Award._();

  bool get unlocked => unlockedAt != null;

  /// A secret that is still locked: shown as "???".
  bool get isSecretLocked => hidden && !unlocked;

  /// Unlocked, but the unlock animation has not been shown yet.
  bool get isNew => unlocked && seenAt == null;

  double get progressFraction =>
      unlocked ? 1 : (target <= 0 ? 0 : (progress / target).clamp(0, 1));
}
