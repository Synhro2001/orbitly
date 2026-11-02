import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';

part 'friends_entities.freezed.dart';

/// A user who is not a friend yet: a search result or a request sender.
@freezed
abstract class UserSummary with _$UserSummary {
  const factory UserSummary({
    required String id,
    required String name,
    required String handle,
    required PlanetAppearance appearance,
  }) = _UserSummary;
}

@freezed
abstract class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required String id,
    required UserSummary from,
    required DateTime sentAt,
  }) = _FriendRequest;
}
