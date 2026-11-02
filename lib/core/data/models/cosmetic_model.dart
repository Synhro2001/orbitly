import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';

part 'cosmetic_model.freezed.dart';
part 'cosmetic_model.g.dart';

/// A row of the `cosmetics` catalogue. The kind is snake_case in the
/// database (`planet_type`, `comet_trail`).
@freezed
abstract class CosmeticModel with _$CosmeticModel {
  const factory CosmeticModel({
    required String id,
    required String title,
    required String kind,
    @JsonKey(unknownEnumValue: Rarity.common)
    @Default(Rarity.common)
    Rarity rarity,
    @Default(<String, Object?>{}) Map<String, Object?> params,
    @Default(false) bool equipped,
  }) = _CosmeticModel;

  factory CosmeticModel.fromJson(Map<String, Object?> json) =>
      _$CosmeticModelFromJson(json);
}

extension CosmeticModelX on CosmeticModel {
  /// `null` for a kind this app version does not know yet.
  Cosmetic? toEntity() {
    final cosmeticKind = cosmeticKindFromDb(kind);
    if (cosmeticKind == null) return null;
    return Cosmetic(
      id: id,
      title: title,
      kind: cosmeticKind,
      rarity: rarity,
      params: params,
      equipped: equipped,
    );
  }
}

CosmeticKind? cosmeticKindFromDb(String kind) => switch (kind) {
  'planet_type' => CosmeticKind.planetType,
  'moon' => CosmeticKind.moon,
  'ring' => CosmeticKind.ring,
  'glow' => CosmeticKind.glow,
  'comet_trail' => CosmeticKind.cometTrail,
  _ => null,
};

String cosmeticKindToDb(CosmeticKind kind) => switch (kind) {
  CosmeticKind.planetType => 'planet_type',
  CosmeticKind.moon => 'moon',
  CosmeticKind.ring => 'ring',
  CosmeticKind.glow => 'glow',
  CosmeticKind.cometTrail => 'comet_trail',
};
