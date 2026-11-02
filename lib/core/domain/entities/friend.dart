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

    /// Closeness, 0–100. The higher it is, the closer the orbit.
    required int closeness,
    required Streak streak,

    /// Null when the friend does not share it with me.
    required Mood? mood,
    required bool hasUnreadSnaps,

    /// Set when the friend is in shadow (or has scheduled one).
    Shadow? shadow,

    /// Trophies we earned together.
    @Default([]) List<Award> sharedTrophies,

    /// In my quiet orbit: no notifications and no glow.
    @Default(false) bool muted,
  }) = _Friend;

  const Friend._();

  /// The planet glows when there is an unseen snap, unless I muted them.
  bool get glows => hasUnreadSnaps && !muted;
}
