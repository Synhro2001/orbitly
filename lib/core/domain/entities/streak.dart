import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak.freezed.dart';

/// Streak: how many days in a row two friends have exchanged snaps/messages.
@freezed
abstract class Streak with _$Streak {
  const factory Streak({required int days, required DateTime lastExchangeAt}) =
      _Streak;
}

enum StreakStatus {
  /// The last exchange was less than a day ago.
  active,

  /// A day was missed: there are 24 more hours to save the streak.
  cracked,

  /// The streak is lost.
  burnt,

  /// One of the friends is in shadow: the streak is frozen and cannot burn.
  paused,
}
