import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/award.dart';

part 'award_model.freezed.dart';
part 'award_model.g.dart';

@freezed
abstract class AwardModel with _$AwardModel {
  const factory AwardModel({
    required String id,
    required String title,
    required String emoji,
    required bool unlocked,
  }) = _AwardModel;

  factory AwardModel.fromJson(Map<String, Object?> json) =>
      _$AwardModelFromJson(json);
}

extension AwardModelX on AwardModel {
  Award toEntity() =>
      Award(id: id, title: title, emoji: emoji, unlocked: unlocked);
}
