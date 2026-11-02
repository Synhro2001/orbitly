import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';

enum SearchVisibility { everyone, friendsOfFriends, nobody }

enum RequestPolicy { everyone, friendsOfFriends, inviteOnly }

enum MomentsAudience { closeOrbit, friends, custom }

enum MoodAudience { closeOrbit, friends, nobody }

enum NotificationPreview { full, sender, none }

/// What happens to chat messages: gone an hour after the friend has seen
/// them, gone after 24 hours, or kept.
enum MessageRetention { afterSeen, day, keep }

/// Account settings, kept on the server so they apply on every device. The
/// defaults match the database: the most private sensible choice.
@freezed
abstract class UserSettings with _$UserSettings {
  const factory UserSettings({
    // Privacy.
    @Default(SearchVisibility.friendsOfFriends)
    SearchVisibility searchVisibility,
    @Default(RequestPolicy.friendsOfFriends) RequestPolicy requestPolicy,
    @Default(MomentsAudience.friends) MomentsAudience momentsAudience,
    @Default(MoodAudience.friends) MoodAudience moodAudience,
    @Default(false) bool showLastSeen,
    @Default(true) bool readReceipts,
    @Default(true) bool typingIndicator,
    @Default(false) bool galaxyVisible,

    // Notifications.
    @Default(true) bool notifyMessages,
    @Default(true) bool notifyRequests,
    @Default(true) bool notifyCapsules,
    @Default(true) bool notifyShadow,
    @Default(true) bool notifyStreaks,
    @Default(true) bool notifyAchievements,
    @Default(true) bool notifyWeeklyReport,
    @Default(NotificationPreview.sender)
    NotificationPreview notificationPreview,
    @Default(true) bool quietHoursEnabled,

    /// Quiet hours as minutes since midnight: 23:00–08:00.
    @Default(23 * 60) int quietFromMinute,
    @Default(8 * 60) int quietToMinute,

    // Wellbeing.
    @Default(false) bool hideStreaks,

    /// Soft daily reminder after this many minutes, or null for none.
    int? dailyLimitMinutes,

    // Chats: the rule for new chats.
    @Default(MessageRetention.day) MessageRetention messageRetention,
  }) = _UserSettings;

  /// The choices for the soft daily reminder.
  static const dailyLimitChoices = [15, 30, 60, 90];
}
