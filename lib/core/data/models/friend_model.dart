import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/core/data/models/shadow_json.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/streak.dart';

part 'friend_model.freezed.dart';
part 'friend_model.g.dart';

@freezed
abstract class FriendModel with _$FriendModel {
  const factory FriendModel({
    required String id,
    required String name,
    required String handle,
    required PlanetAppearanceModel appearance,
    required int closeness,
    required int streakDays,
    required DateTime lastExchangeAt,
    @JsonKey(unknownEnumValue: Mood.calm) required Mood mood,
    required bool hasUnreadSnaps,
    DateTime? shadowFrom,
    DateTime? shadowUntil,
    @Default([]) List<AwardModel> trophies,
  }) = _FriendModel;

  factory FriendModel.fromJson(Map<String, Object?> json) =>
      _$FriendModelFromJson(json);
}

extension FriendModelX on FriendModel {
  Friend toEntity() => Friend(
    id: id,
    name: name,
    handle: handle,
    appearance: appearance.toEntity(),
    closeness: closeness.clamp(0, 100),
    streak: Streak(days: streakDays, lastExchangeAt: lastExchangeAt),
    mood: mood,
    hasUnreadSnaps: hasUnreadSnaps,
    shadow: shadowFromFields(shadowFrom, shadowUntil),
    sharedTrophies: [for (final t in trophies) t.toEntity()],
  );
}
