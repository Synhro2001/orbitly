import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/features/system/domain/entities/moment.dart';

part 'moment_model.freezed.dart';
part 'moment_model.g.dart';

@freezed
abstract class MomentModel with _$MomentModel {
  const factory MomentModel({
    required String id,
    required String friendId,
    required bool seen,
    required DateTime postedAt,
  }) = _MomentModel;

  factory MomentModel.fromJson(Map<String, Object?> json) =>
      _$MomentModelFromJson(json);
}

extension MomentModelX on MomentModel {
  Moment toEntity() =>
      Moment(id: id, friendId: friendId, seen: seen, postedAt: postedAt);
}
