import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_settings.freezed.dart';

/// Animations: as the phone says, or always fewer.
enum MotionPreference { system, reduced }

/// When photos and videos load by themselves.
enum MediaAutoload { always, wifi, never }

/// Settings of this phone only (not the account).
@freezed
abstract class DeviceSettings with _$DeviceSettings {
  const factory DeviceSettings({
    @Default(true) bool haptics,
    @Default(MotionPreference.system) MotionPreference motion,
    @Default(MediaAutoload.wifi) MediaAutoload mediaAutoload,
    @Default(false) bool dataSaver,
  }) = _DeviceSettings;
}

/// Minutes spent in the app today, for the soft daily reminder.
@freezed
abstract class DailyUsage with _$DailyUsage {
  const factory DailyUsage({
    /// The day these minutes belong to, `yyyy-mm-dd`.
    @Default('') String day,
    @Default(0) int minutes,

    /// The reminder has been shown today.
    @Default(false) bool reminded,
  }) = _DailyUsage;

  const DailyUsage._();

  static String dayOf(DateTime time) =>
      '${time.year}-${time.month.toString().padLeft(2, '0')}-'
      '${time.day.toString().padLeft(2, '0')}';

  /// One more minute in the app at [now]; a new day starts from zero.
  DailyUsage addMinute(DateTime now) {
    final today = dayOf(now);
    return today == day
        ? copyWith(minutes: minutes + 1)
        : DailyUsage(day: today, minutes: 1);
  }

  /// Time to remind: the limit is reached and today's reminder is not
  /// shown yet. A reminder, never a lock.
  bool shouldRemind({required int? limitMinutes}) =>
      limitMinutes != null && minutes >= limitMinutes && !reminded;
}
