import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/domain/entities/streak.dart';

part 'friend.freezed.dart';

@freezed
abstract class Friend with _$Friend {
  const factory Friend({
    required String id,
    required String name,
    required String handle,
    required PlanetAppearance appearance,

    /// Близость общения, 0–100. Чем больше, тем ближе орбита.
    required int closeness,
    required Streak streak,
    required Mood mood,
    required bool hasUnreadSnaps,

    /// Если друг в тени (или запланировал её).
    Shadow? shadow,

    /// Общие трофеи нашей дружбы.
    @Default([]) List<Award> sharedTrophies,
  }) = _Friend;
}
