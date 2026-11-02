import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/award.dart';

part 'award_model.freezed.dart';
part 'award_model.g.dart';

/// Строка каталога достижений — как её отдаёт get_my_achievements().
/// У секретных неоткрытых достижений сервер присылает null вместо названия,
/// описания, значка, прогресса и награды.
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
    String? title,
    String? description,
    String? icon,
    @Default(false) bool hidden,
    @Default(false) bool pair,
    int? progress,
    int? target,
    DateTime? unlockedAt,
    DateTime? seenAt,
    String? rewardCosmeticId,
    String? rewardTitle,
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
