// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'user_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettingsModel _$UserSettingsModelFromJson(Map<String, dynamic> json) =>
    _UserSettingsModel(
      searchVisibility:
          $enumDecodeNullable(
            _$SearchVisibilityEnumMap,
            json['search_visibility'],
            unknownValue: SearchVisibility.friendsOfFriends,
          ) ??
          SearchVisibility.friendsOfFriends,
      requestPolicy:
          $enumDecodeNullable(
            _$RequestPolicyEnumMap,
            json['request_policy'],
            unknownValue: RequestPolicy.friendsOfFriends,
          ) ??
          RequestPolicy.friendsOfFriends,
      momentsAudience:
          $enumDecodeNullable(
            _$MomentsAudienceEnumMap,
            json['moments_audience'],
            unknownValue: MomentsAudience.friends,
          ) ??
          MomentsAudience.friends,
      moodAudience:
          $enumDecodeNullable(
            _$MoodAudienceEnumMap,
            json['mood_audience'],
            unknownValue: MoodAudience.friends,
          ) ??
          MoodAudience.friends,
      showLastSeen: json['show_last_seen'] as bool? ?? false,
      readReceipts: json['read_receipts'] as bool? ?? true,
      typingIndicator: json['typing_indicator'] as bool? ?? true,
      galaxyVisible: json['galaxy_visible'] as bool? ?? false,
      notifyMessages: json['notify_messages'] as bool? ?? true,
      notifyRequests: json['notify_requests'] as bool? ?? true,
      notifyCapsules: json['notify_capsules'] as bool? ?? true,
      notifyShadow: json['notify_shadow'] as bool? ?? true,
      notifyStreaks: json['notify_streaks'] as bool? ?? true,
      notifyAchievements: json['notify_achievements'] as bool? ?? true,
      notifyWeeklyReport: json['notify_weekly_report'] as bool? ?? true,
      notificationPreview:
          $enumDecodeNullable(
            _$NotificationPreviewEnumMap,
            json['notification_preview'],
            unknownValue: NotificationPreview.sender,
          ) ??
          NotificationPreview.sender,
      quietHoursEnabled: json['quiet_hours_enabled'] as bool? ?? true,
      quietFrom: json['quiet_from'] as String? ?? '23:00:00',
      quietTo: json['quiet_to'] as String? ?? '08:00:00',
      hideStreaks: json['hide_streaks'] as bool? ?? false,
      dailyLimitMinutes: (json['daily_limit_minutes'] as num?)?.toInt(),
      messageRetention:
          $enumDecodeNullable(
            _$MessageRetentionEnumMap,
            json['message_retention'],
            unknownValue: MessageRetention.day,
          ) ??
          MessageRetention.day,
    );

Map<String, dynamic> _$UserSettingsModelToJson(
  _UserSettingsModel instance,
) => <String, dynamic>{
  'search_visibility': _$SearchVisibilityEnumMap[instance.searchVisibility]!,
  'request_policy': _$RequestPolicyEnumMap[instance.requestPolicy]!,
  'moments_audience': _$MomentsAudienceEnumMap[instance.momentsAudience]!,
  'mood_audience': _$MoodAudienceEnumMap[instance.moodAudience]!,
  'show_last_seen': instance.showLastSeen,
  'read_receipts': instance.readReceipts,
  'typing_indicator': instance.typingIndicator,
  'galaxy_visible': instance.galaxyVisible,
  'notify_messages': instance.notifyMessages,
  'notify_requests': instance.notifyRequests,
  'notify_capsules': instance.notifyCapsules,
  'notify_shadow': instance.notifyShadow,
  'notify_streaks': instance.notifyStreaks,
  'notify_achievements': instance.notifyAchievements,
  'notify_weekly_report': instance.notifyWeeklyReport,
  'notification_preview':
      _$NotificationPreviewEnumMap[instance.notificationPreview]!,
  'quiet_hours_enabled': instance.quietHoursEnabled,
  'quiet_from': instance.quietFrom,
  'quiet_to': instance.quietTo,
  'hide_streaks': instance.hideStreaks,
  'daily_limit_minutes': instance.dailyLimitMinutes,
  'message_retention': _$MessageRetentionEnumMap[instance.messageRetention]!,
};

const _$SearchVisibilityEnumMap = {
  SearchVisibility.everyone: 'everyone',
  SearchVisibility.friendsOfFriends: 'friendsOfFriends',
  SearchVisibility.nobody: 'nobody',
};

const _$RequestPolicyEnumMap = {
  RequestPolicy.everyone: 'everyone',
  RequestPolicy.friendsOfFriends: 'friendsOfFriends',
  RequestPolicy.inviteOnly: 'inviteOnly',
};

const _$MomentsAudienceEnumMap = {
  MomentsAudience.closeOrbit: 'closeOrbit',
  MomentsAudience.friends: 'friends',
  MomentsAudience.custom: 'custom',
};

const _$MoodAudienceEnumMap = {
  MoodAudience.closeOrbit: 'closeOrbit',
  MoodAudience.friends: 'friends',
  MoodAudience.nobody: 'nobody',
};

const _$NotificationPreviewEnumMap = {
  NotificationPreview.full: 'full',
  NotificationPreview.sender: 'sender',
  NotificationPreview.none: 'none',
};

const _$MessageRetentionEnumMap = {
  MessageRetention.afterSeen: 'afterSeen',
  MessageRetention.day: 'day',
  MessageRetention.keep: 'keep',
};
