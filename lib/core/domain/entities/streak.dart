import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak.freezed.dart';

/// Серия: сколько дней подряд друзья обмениваются снапами/сообщениями.
@freezed
abstract class Streak with _$Streak {
  const factory Streak({required int days, required DateTime lastExchangeAt}) =
      _Streak;
}

enum StreakStatus {
  /// Обмен был меньше суток назад.
  active,

  /// Сутки пропущены: есть ещё 24 часа, чтобы восстановить серию.
  cracked,

  /// Серия потеряна.
  burnt,

  /// Один из друзей в тени — серия замерла и не сгорает.
  paused,
}
