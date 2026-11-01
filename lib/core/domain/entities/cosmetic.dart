import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/award.dart';

part 'cosmetic.freezed.dart';

enum CosmeticKind { planetType, moon, ring, glow, cometTrail }

/// Награда-украшение для планеты. Что именно она меняет, описано в [params]
/// (контент с сервера): `{"type": "nebula"}`, `{"moons": 2}`,
/// `{"style": "aurora"}`.
@freezed
abstract class Cosmetic with _$Cosmetic {
  const factory Cosmetic({
    required String id,
    required String title,
    required CosmeticKind kind,
    required Rarity rarity,
    @Default(<String, Object?>{}) Map<String, Object?> params,
    @Default(false) bool equipped,
  }) = _Cosmetic;
}
