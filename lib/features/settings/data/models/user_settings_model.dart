import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';

part 'user_settings_model.freezed.dart';
part 'user_settings_model.g.dart';

/// A `user_settings` row. Unknown values from a newer server fall back to
/// the private default instead of breaking the screen.
@freezed
abstract class UserSettingsModel with _$UserSettingsModel {
  const factory UserSettingsModel({
    @JsonKey(unknownEnumValue: SearchVisibility.friendsOfFriends)
    @Default(SearchVisibility.friendsOfFriends)
    SearchVisibility searchVisibility,
    @JsonKey(unknownEnumValue: RequestPolicy.friendsOfFriends)
    @Default(RequestPolicy.friendsOfFriends)
    RequestPolicy requestPolicy,
    @JsonKey(unknownEnumValue: MomentsAudience.friends)
    @Default(MomentsAudience.friends)
    MomentsAudience momentsAudience,
    @JsonKey(unknownEnumValue: MoodAudience.friends)
    @Default(MoodAudience.friends)
    MoodAudience moodAudience,
    @Default(false) bool showLastSeen,
    @Default(true) bool readReceipts,
    @Default(true) bool typingIndicator,
    @Default(false) bool galaxyVisible,
    @Default(true) bool notifyMessages,
    @Default(true) bool notifyRequests,
    @Default(true) bool notifyCapsules,
    @Default(true) bool notifyShadow,
    @Default(true) bool notifyStreaks,
    @Default(true) bool notifyAchievements,
    @Default(true) bool notifyWeeklyReport,
    @JsonKey(unknownEnumValue: NotificationPreview.sender)
    @Default(NotificationPreview.sender)
    NotificationPreview notificationPreview,
    @Default(true) bool quietHoursEnabled,
    @Default('23:00:00') String quietFrom,
    @Default('08:00:00') String quietTo,
    @Default(false) bool hideStreaks,
    int? dailyLimitMinutes,
    @JsonKey(unknownEnumValue: MessageRetention.day)
    @Default(MessageRetention.day)
    MessageRetention messageRetention,
  }) = _UserSettingsModel;

  factory UserSettingsModel.fromJson(Map<String, Object?> json) =>
      _$UserSettingsModelFromJson(json);

  factory UserSettingsModel.fromEntity(UserSettings s) => UserSettingsModel(
    searchVisibility: s.searchVisibility,
    requestPolicy: s.requestPolicy,
    momentsAudience: s.momentsAudience,
    moodAudience: s.moodAudience,
    showLastSeen: s.showLastSeen,
    readReceipts: s.readReceipts,
    typingIndicator: s.typingIndicator,
    galaxyVisible: s.galaxyVisible,
    notifyMessages: s.notifyMessages,
    notifyRequests: s.notifyRequests,
    notifyCapsules: s.notifyCapsules,
    notifyShadow: s.notifyShadow,
    notifyStreaks: s.notifyStreaks,
    notifyAchievements: s.notifyAchievements,
    notifyWeeklyReport: s.notifyWeeklyReport,
    notificationPreview: s.notificationPreview,
    quietHoursEnabled: s.quietHoursEnabled,
    quietFrom: timeFromMinute(s.quietFromMinute),
    quietTo: timeFromMinute(s.quietToMinute),
    hideStreaks: s.hideStreaks,
    dailyLimitMinutes: s.dailyLimitMinutes,
    messageRetention: s.messageRetention,
  );
}

extension UserSettingsModelX on UserSettingsModel {
  UserSettings toEntity() => UserSettings(
    searchVisibility: searchVisibility,
    requestPolicy: requestPolicy,
    momentsAudience: momentsAudience,
    moodAudience: moodAudience,
    showLastSeen: showLastSeen,
    readReceipts: readReceipts,
    typingIndicator: typingIndicator,
    galaxyVisible: galaxyVisible,
    notifyMessages: notifyMessages,
    notifyRequests: notifyRequests,
    notifyCapsules: notifyCapsules,
    notifyShadow: notifyShadow,
    notifyStreaks: notifyStreaks,
    notifyAchievements: notifyAchievements,
    notifyWeeklyReport: notifyWeeklyReport,
    notificationPreview: notificationPreview,
    quietHoursEnabled: quietHoursEnabled,
    quietFromMinute: minuteFromTime(quietFrom) ?? 23 * 60,
    quietToMinute: minuteFromTime(quietTo) ?? 8 * 60,
    hideStreaks: hideStreaks,
    dailyLimitMinutes: dailyLimitMinutes,
    messageRetention: messageRetention,
  );
}

/// Postgres `time` ("23:00:00") → minutes since midnight; null if broken.
int? minuteFromTime(String time) {
  final parts = time.split(':');
  if (parts.length < 2) return null;
  final hours = int.tryParse(parts[0]);
  final minutes = int.tryParse(parts[1]);
  if (hours == null || minutes == null) return null;
  if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) return null;
  return hours * 60 + minutes;
}

/// Minutes since midnight → Postgres `time` ("08:00:00").
String timeFromMinute(int minute) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(minute ~/ 60 % 24)}:${two(minute % 60)}:00';
}
