import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/data/models/planet_appearance_model.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';

part 'friends_models.freezed.dart';
part 'friends_models.g.dart';

@freezed
abstract class UserSummaryModel with _$UserSummaryModel {
  const factory UserSummaryModel({
    required String id,
    required String name,
    required String handle,
    required PlanetAppearanceModel appearance,
  }) = _UserSummaryModel;

  factory UserSummaryModel.fromJson(Map<String, Object?> json) =>
      _$UserSummaryModelFromJson(json);
}

@freezed
abstract class FriendRequestModel with _$FriendRequestModel {
  const factory FriendRequestModel({
    required String id,
    required UserSummaryModel user,
    required DateTime sentAt,
  }) = _FriendRequestModel;

  factory FriendRequestModel.fromJson(Map<String, Object?> json) =>
      _$FriendRequestModelFromJson(json);
}

/// A user row from a server function (search, invite, blocked, muted):
/// the name comes as `display_name`.
UserSummary userSummaryFromRow(Map<String, dynamic> row) =>
    UserSummaryModel.fromJson({...row, 'name': row['display_name']}).toEntity();

extension UserSummaryModelX on UserSummaryModel {
  UserSummary toEntity() => UserSummary(
    id: id,
    name: name,
    handle: handle,
    appearance: appearance.toEntity(),
  );
}

extension FriendRequestModelX on FriendRequestModel {
  FriendRequest toEntity() =>
      FriendRequest(id: id, from: user.toEntity(), sentAt: sentAt);
}
