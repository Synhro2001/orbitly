import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/data/models/localized_text_converter.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/localized_text.dart';

part 'award_model.freezed.dart';
part 'award_model.g.dart';

/// A catalogue row as returned by get_my_achievements(). For locked secret
/// achievements the server sends null instead of the title, description,
/// icon, progress and reward.
@freezed
abstract class AwardModel with _$AwardModel {
  const factory AwardModel({
    required String id,
    @JsonKey(unknownEnumValue: AwardCategory.collection)
    @Default(AwardCategory.collection)
    AwardCategory category,
    @JsonKey(unknownEnumValue: Rarity.common)
    @Default(Rarity.common)
    Rarity rarity,
    @LocalizedTextConverter() LocalizedText? title,
    @LocalizedTextConverter() LocalizedText? description,
    String? icon,
    @Default(false) bool hidden,
    @Default(false) bool pair,
    int? progress,
    int? target,
    DateTime? unlockedAt,
    DateTime? seenAt,
    String? rewardCosmeticId,
    @LocalizedTextConverter() LocalizedText? rewardTitle,
  }) = _AwardModel;

  factory AwardModel.fromJson(Map<String, Object?> json) =>
      _$AwardModelFromJson(json);
}

extension AwardModelX on AwardModel {
  Award toEntity() => Award(
    id: id,
    category: category,
    rarity: rarity,
    title: title,
    description: description,
    emoji: icon,
    progress: progress ?? 0,
    target: target ?? 1,
    hidden: hidden,
    pair: pair,
    rewardId: rewardCosmeticId,
    rewardTitle: rewardTitle,
    unlockedAt: unlockedAt,
    seenAt: seenAt,
  );
}
