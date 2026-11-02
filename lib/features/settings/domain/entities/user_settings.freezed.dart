// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSettings {

 SearchVisibility get searchVisibility; RequestPolicy get requestPolicy; MomentsAudience get momentsAudience; MoodAudience get moodAudience; bool get showLastSeen; bool get readReceipts; bool get typingIndicator; bool get galaxyVisible; bool get notifyMessages; bool get notifyRequests; bool get notifyCapsules; bool get notifyShadow; bool get notifyStreaks; bool get notifyAchievements; bool get notifyWeeklyReport; NotificationPreview get notificationPreview; bool get quietHoursEnabled;/// Quiet hours as minutes since midnight: 23:00–08:00.
 int get quietFromMinute; int get quietToMinute; bool get hideStreaks;/// Soft daily reminder after this many minutes, or null for none.
 int? get dailyLimitMinutes; MessageRetention get messageRetention;
/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsCopyWith<UserSettings> get copyWith => _$UserSettingsCopyWithImpl<UserSettings>(this as UserSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettings&&(identical(other.searchVisibility, _this.searchVisibility) || other.searchVisibility == _this.searchVisibility)&&(identical(other.requestPolicy, _this.requestPolicy) || other.requestPolicy == _this.requestPolicy)&&(identical(other.momentsAudience, _this.momentsAudience) || other.momentsAudience == _this.momentsAudience)&&(identical(other.moodAudience, _this.moodAudience) || other.moodAudience == _this.moodAudience)&&(identical(other.showLastSeen, _this.showLastSeen) || other.showLastSeen == _this.showLastSeen)&&(identical(other.readReceipts, _this.readReceipts) || other.readReceipts == _this.readReceipts)&&(identical(other.typingIndicator, _this.typingIndicator) || other.typingIndicator == _this.typingIndicator)&&(identical(other.galaxyVisible, _this.galaxyVisible) || other.galaxyVisible == _this.galaxyVisible)&&(identical(other.notifyMessages, _this.notifyMessages) || other.notifyMessages == _this.notifyMessages)&&(identical(other.notifyRequests, _this.notifyRequests) || other.notifyRequests == _this.notifyRequests)&&(identical(other.notifyCapsules, _this.notifyCapsules) || other.notifyCapsules == _this.notifyCapsules)&&(identical(other.notifyShadow, _this.notifyShadow) || other.notifyShadow == _this.notifyShadow)&&(identical(other.notifyStreaks, _this.notifyStreaks) || other.notifyStreaks == _this.notifyStreaks)&&(identical(other.notifyAchievements, _this.notifyAchievements) || other.notifyAchievements == _this.notifyAchievements)&&(identical(other.notifyWeeklyReport, _this.notifyWeeklyReport) || other.notifyWeeklyReport == _this.notifyWeeklyReport)&&(identical(other.notificationPreview, _this.notificationPreview) || other.notificationPreview == _this.notificationPreview)&&(identical(other.quietHoursEnabled, _this.quietHoursEnabled) || other.quietHoursEnabled == _this.quietHoursEnabled)&&(identical(other.quietFromMinute, _this.quietFromMinute) || other.quietFromMinute == _this.quietFromMinute)&&(identical(other.quietToMinute, _this.quietToMinute) || other.quietToMinute == _this.quietToMinute)&&(identical(other.hideStreaks, _this.hideStreaks) || other.hideStreaks == _this.hideStreaks)&&(identical(other.dailyLimitMinutes, _this.dailyLimitMinutes) || other.dailyLimitMinutes == _this.dailyLimitMinutes)&&(identical(other.messageRetention, _this.messageRetention) || other.messageRetention == _this.messageRetention));
}


@override
int get hashCode {
  final _this = this as UserSettings;
  return Object.hashAll([runtimeType,_this.searchVisibility,_this.requestPolicy,_this.momentsAudience,_this.moodAudience,_this.showLastSeen,_this.readReceipts,_this.typingIndicator,_this.galaxyVisible,_this.notifyMessages,_this.notifyRequests,_this.notifyCapsules,_this.notifyShadow,_this.notifyStreaks,_this.notifyAchievements,_this.notifyWeeklyReport,_this.notificationPreview,_this.quietHoursEnabled,_this.quietFromMinute,_this.quietToMinute,_this.hideStreaks,_this.dailyLimitMinutes,_this.messageRetention]);
}

@override
String toString() {
  final _this = this as UserSettings;
  return 'UserSettings(searchVisibility: ${_this.searchVisibility}, requestPolicy: ${_this.requestPolicy}, momentsAudience: ${_this.momentsAudience}, moodAudience: ${_this.moodAudience}, showLastSeen: ${_this.showLastSeen}, readReceipts: ${_this.readReceipts}, typingIndicator: ${_this.typingIndicator}, galaxyVisible: ${_this.galaxyVisible}, notifyMessages: ${_this.notifyMessages}, notifyRequests: ${_this.notifyRequests}, notifyCapsules: ${_this.notifyCapsules}, notifyShadow: ${_this.notifyShadow}, notifyStreaks: ${_this.notifyStreaks}, notifyAchievements: ${_this.notifyAchievements}, notifyWeeklyReport: ${_this.notifyWeeklyReport}, notificationPreview: ${_this.notificationPreview}, quietHoursEnabled: ${_this.quietHoursEnabled}, quietFromMinute: ${_this.quietFromMinute}, quietToMinute: ${_this.quietToMinute}, hideStreaks: ${_this.hideStreaks}, dailyLimitMinutes: ${_this.dailyLimitMinutes}, messageRetention: ${_this.messageRetention})';
}


}

/// @nodoc
abstract mixin class $UserSettingsCopyWith<$Res>  {
  factory $UserSettingsCopyWith(UserSettings value, $Res Function(UserSettings) _then) = _$UserSettingsCopyWithImpl;
@useResult
$Res call({
 SearchVisibility searchVisibility, RequestPolicy requestPolicy, MomentsAudience momentsAudience, MoodAudience moodAudience, bool showLastSeen, bool readReceipts, bool typingIndicator, bool galaxyVisible, bool notifyMessages, bool notifyRequests, bool notifyCapsules, bool notifyShadow, bool notifyStreaks, bool notifyAchievements, bool notifyWeeklyReport, NotificationPreview notificationPreview, bool quietHoursEnabled, int quietFromMinute, int quietToMinute, bool hideStreaks, int? dailyLimitMinutes, MessageRetention messageRetention
});




}
/// @nodoc
class _$UserSettingsCopyWithImpl<$Res>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._self, this._then);

  final UserSettings _self;
  final $Res Function(UserSettings) _then;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchVisibility = null,Object? requestPolicy = null,Object? momentsAudience = null,Object? moodAudience = null,Object? showLastSeen = null,Object? readReceipts = null,Object? typingIndicator = null,Object? galaxyVisible = null,Object? notifyMessages = null,Object? notifyRequests = null,Object? notifyCapsules = null,Object? notifyShadow = null,Object? notifyStreaks = null,Object? notifyAchievements = null,Object? notifyWeeklyReport = null,Object? notificationPreview = null,Object? quietHoursEnabled = null,Object? quietFromMinute = null,Object? quietToMinute = null,Object? hideStreaks = null,Object? dailyLimitMinutes = freezed,Object? messageRetention = null,}) {
  return _then(UserSettings(
searchVisibility: null == searchVisibility ? _self.searchVisibility : searchVisibility // ignore: cast_nullable_to_non_nullable
as SearchVisibility,requestPolicy: null == requestPolicy ? _self.requestPolicy : requestPolicy // ignore: cast_nullable_to_non_nullable
as RequestPolicy,momentsAudience: null == momentsAudience ? _self.momentsAudience : momentsAudience // ignore: cast_nullable_to_non_nullable
as MomentsAudience,moodAudience: null == moodAudience ? _self.moodAudience : moodAudience // ignore: cast_nullable_to_non_nullable
as MoodAudience,showLastSeen: null == showLastSeen ? _self.showLastSeen : showLastSeen // ignore: cast_nullable_to_non_nullable
as bool,readReceipts: null == readReceipts ? _self.readReceipts : readReceipts // ignore: cast_nullable_to_non_nullable
as bool,typingIndicator: null == typingIndicator ? _self.typingIndicator : typingIndicator // ignore: cast_nullable_to_non_nullable
as bool,galaxyVisible: null == galaxyVisible ? _self.galaxyVisible : galaxyVisible // ignore: cast_nullable_to_non_nullable
as bool,notifyMessages: null == notifyMessages ? _self.notifyMessages : notifyMessages // ignore: cast_nullable_to_non_nullable
as bool,notifyRequests: null == notifyRequests ? _self.notifyRequests : notifyRequests // ignore: cast_nullable_to_non_nullable
as bool,notifyCapsules: null == notifyCapsules ? _self.notifyCapsules : notifyCapsules // ignore: cast_nullable_to_non_nullable
as bool,notifyShadow: null == notifyShadow ? _self.notifyShadow : notifyShadow // ignore: cast_nullable_to_non_nullable
as bool,notifyStreaks: null == notifyStreaks ? _self.notifyStreaks : notifyStreaks // ignore: cast_nullable_to_non_nullable
as bool,notifyAchievements: null == notifyAchievements ? _self.notifyAchievements : notifyAchievements // ignore: cast_nullable_to_non_nullable
as bool,notifyWeeklyReport: null == notifyWeeklyReport ? _self.notifyWeeklyReport : notifyWeeklyReport // ignore: cast_nullable_to_non_nullable
as bool,notificationPreview: null == notificationPreview ? _self.notificationPreview : notificationPreview // ignore: cast_nullable_to_non_nullable
as NotificationPreview,quietHoursEnabled: null == quietHoursEnabled ? _self.quietHoursEnabled : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
as bool,quietFromMinute: null == quietFromMinute ? _self.quietFromMinute : quietFromMinute // ignore: cast_nullable_to_non_nullable
as int,quietToMinute: null == quietToMinute ? _self.quietToMinute : quietToMinute // ignore: cast_nullable_to_non_nullable
as int,hideStreaks: null == hideStreaks ? _self.hideStreaks : hideStreaks // ignore: cast_nullable_to_non_nullable
as bool,dailyLimitMinutes: freezed == dailyLimitMinutes ? _self.dailyLimitMinutes : dailyLimitMinutes // ignore: cast_nullable_to_non_nullable
as int?,messageRetention: null == messageRetention ? _self.messageRetention : messageRetention // ignore: cast_nullable_to_non_nullable
as MessageRetention,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSettings].
extension UserSettingsPatterns on UserSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettings value)  $default,){
final _that = this;
switch (_that) {
case _UserSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettings value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchVisibility searchVisibility,  RequestPolicy requestPolicy,  MomentsAudience momentsAudience,  MoodAudience moodAudience,  bool showLastSeen,  bool readReceipts,  bool typingIndicator,  bool galaxyVisible,  bool notifyMessages,  bool notifyRequests,  bool notifyCapsules,  bool notifyShadow,  bool notifyStreaks,  bool notifyAchievements,  bool notifyWeeklyReport,  NotificationPreview notificationPreview,  bool quietHoursEnabled,  int quietFromMinute,  int quietToMinute,  bool hideStreaks,  int? dailyLimitMinutes,  MessageRetention messageRetention)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that.searchVisibility,_that.requestPolicy,_that.momentsAudience,_that.moodAudience,_that.showLastSeen,_that.readReceipts,_that.typingIndicator,_that.galaxyVisible,_that.notifyMessages,_that.notifyRequests,_that.notifyCapsules,_that.notifyShadow,_that.notifyStreaks,_that.notifyAchievements,_that.notifyWeeklyReport,_that.notificationPreview,_that.quietHoursEnabled,_that.quietFromMinute,_that.quietToMinute,_that.hideStreaks,_that.dailyLimitMinutes,_that.messageRetention);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchVisibility searchVisibility,  RequestPolicy requestPolicy,  MomentsAudience momentsAudience,  MoodAudience moodAudience,  bool showLastSeen,  bool readReceipts,  bool typingIndicator,  bool galaxyVisible,  bool notifyMessages,  bool notifyRequests,  bool notifyCapsules,  bool notifyShadow,  bool notifyStreaks,  bool notifyAchievements,  bool notifyWeeklyReport,  NotificationPreview notificationPreview,  bool quietHoursEnabled,  int quietFromMinute,  int quietToMinute,  bool hideStreaks,  int? dailyLimitMinutes,  MessageRetention messageRetention)  $default,) {final _that = this;
switch (_that) {
case _UserSettings():
return $default(_that.searchVisibility,_that.requestPolicy,_that.momentsAudience,_that.moodAudience,_that.showLastSeen,_that.readReceipts,_that.typingIndicator,_that.galaxyVisible,_that.notifyMessages,_that.notifyRequests,_that.notifyCapsules,_that.notifyShadow,_that.notifyStreaks,_that.notifyAchievements,_that.notifyWeeklyReport,_that.notificationPreview,_that.quietHoursEnabled,_that.quietFromMinute,_that.quietToMinute,_that.hideStreaks,_that.dailyLimitMinutes,_that.messageRetention);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchVisibility searchVisibility,  RequestPolicy requestPolicy,  MomentsAudience momentsAudience,  MoodAudience moodAudience,  bool showLastSeen,  bool readReceipts,  bool typingIndicator,  bool galaxyVisible,  bool notifyMessages,  bool notifyRequests,  bool notifyCapsules,  bool notifyShadow,  bool notifyStreaks,  bool notifyAchievements,  bool notifyWeeklyReport,  NotificationPreview notificationPreview,  bool quietHoursEnabled,  int quietFromMinute,  int quietToMinute,  bool hideStreaks,  int? dailyLimitMinutes,  MessageRetention messageRetention)?  $default,) {final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that.searchVisibility,_that.requestPolicy,_that.momentsAudience,_that.moodAudience,_that.showLastSeen,_that.readReceipts,_that.typingIndicator,_that.galaxyVisible,_that.notifyMessages,_that.notifyRequests,_that.notifyCapsules,_that.notifyShadow,_that.notifyStreaks,_that.notifyAchievements,_that.notifyWeeklyReport,_that.notificationPreview,_that.quietHoursEnabled,_that.quietFromMinute,_that.quietToMinute,_that.hideStreaks,_that.dailyLimitMinutes,_that.messageRetention);case _:
  return null;

}
}

}

/// @nodoc


class _UserSettings implements UserSettings {
  const _UserSettings({this.searchVisibility = SearchVisibility.friendsOfFriends, this.requestPolicy = RequestPolicy.friendsOfFriends, this.momentsAudience = MomentsAudience.friends, this.moodAudience = MoodAudience.friends, this.showLastSeen = false, this.readReceipts = true, this.typingIndicator = true, this.galaxyVisible = false, this.notifyMessages = true, this.notifyRequests = true, this.notifyCapsules = true, this.notifyShadow = true, this.notifyStreaks = true, this.notifyAchievements = true, this.notifyWeeklyReport = true, this.notificationPreview = NotificationPreview.sender, this.quietHoursEnabled = true, this.quietFromMinute = 23 * 60, this.quietToMinute = 8 * 60, this.hideStreaks = false, this.dailyLimitMinutes, this.messageRetention = MessageRetention.day});
  

@override@JsonKey() final  SearchVisibility searchVisibility;
@override@JsonKey() final  RequestPolicy requestPolicy;
@override@JsonKey() final  MomentsAudience momentsAudience;
@override@JsonKey() final  MoodAudience moodAudience;
@override@JsonKey() final  bool showLastSeen;
@override@JsonKey() final  bool readReceipts;
@override@JsonKey() final  bool typingIndicator;
@override@JsonKey() final  bool galaxyVisible;
@override@JsonKey() final  bool notifyMessages;
@override@JsonKey() final  bool notifyRequests;
@override@JsonKey() final  bool notifyCapsules;
@override@JsonKey() final  bool notifyShadow;
@override@JsonKey() final  bool notifyStreaks;
@override@JsonKey() final  bool notifyAchievements;
@override@JsonKey() final  bool notifyWeeklyReport;
@override@JsonKey() final  NotificationPreview notificationPreview;
@override@JsonKey() final  bool quietHoursEnabled;
/// Quiet hours as minutes since midnight: 23:00–08:00.
@override@JsonKey() final  int quietFromMinute;
@override@JsonKey() final  int quietToMinute;
@override@JsonKey() final  bool hideStreaks;
/// Soft daily reminder after this many minutes, or null for none.
@override final  int? dailyLimitMinutes;
@override@JsonKey() final  MessageRetention messageRetention;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsCopyWith<_UserSettings> get copyWith => __$UserSettingsCopyWithImpl<_UserSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettings&&(identical(other.searchVisibility, searchVisibility) || other.searchVisibility == searchVisibility)&&(identical(other.requestPolicy, requestPolicy) || other.requestPolicy == requestPolicy)&&(identical(other.momentsAudience, momentsAudience) || other.momentsAudience == momentsAudience)&&(identical(other.moodAudience, moodAudience) || other.moodAudience == moodAudience)&&(identical(other.showLastSeen, showLastSeen) || other.showLastSeen == showLastSeen)&&(identical(other.readReceipts, readReceipts) || other.readReceipts == readReceipts)&&(identical(other.typingIndicator, typingIndicator) || other.typingIndicator == typingIndicator)&&(identical(other.galaxyVisible, galaxyVisible) || other.galaxyVisible == galaxyVisible)&&(identical(other.notifyMessages, notifyMessages) || other.notifyMessages == notifyMessages)&&(identical(other.notifyRequests, notifyRequests) || other.notifyRequests == notifyRequests)&&(identical(other.notifyCapsules, notifyCapsules) || other.notifyCapsules == notifyCapsules)&&(identical(other.notifyShadow, notifyShadow) || other.notifyShadow == notifyShadow)&&(identical(other.notifyStreaks, notifyStreaks) || other.notifyStreaks == notifyStreaks)&&(identical(other.notifyAchievements, notifyAchievements) || other.notifyAchievements == notifyAchievements)&&(identical(other.notifyWeeklyReport, notifyWeeklyReport) || other.notifyWeeklyReport == notifyWeeklyReport)&&(identical(other.notificationPreview, notificationPreview) || other.notificationPreview == notificationPreview)&&(identical(other.quietHoursEnabled, quietHoursEnabled) || other.quietHoursEnabled == quietHoursEnabled)&&(identical(other.quietFromMinute, quietFromMinute) || other.quietFromMinute == quietFromMinute)&&(identical(other.quietToMinute, quietToMinute) || other.quietToMinute == quietToMinute)&&(identical(other.hideStreaks, hideStreaks) || other.hideStreaks == hideStreaks)&&(identical(other.dailyLimitMinutes, dailyLimitMinutes) || other.dailyLimitMinutes == dailyLimitMinutes)&&(identical(other.messageRetention, messageRetention) || other.messageRetention == messageRetention));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,searchVisibility,requestPolicy,momentsAudience,moodAudience,showLastSeen,readReceipts,typingIndicator,galaxyVisible,notifyMessages,notifyRequests,notifyCapsules,notifyShadow,notifyStreaks,notifyAchievements,notifyWeeklyReport,notificationPreview,quietHoursEnabled,quietFromMinute,quietToMinute,hideStreaks,dailyLimitMinutes,messageRetention]);
}

@override
String toString() {
    return 'UserSettings(searchVisibility: $searchVisibility, requestPolicy: $requestPolicy, momentsAudience: $momentsAudience, moodAudience: $moodAudience, showLastSeen: $showLastSeen, readReceipts: $readReceipts, typingIndicator: $typingIndicator, galaxyVisible: $galaxyVisible, notifyMessages: $notifyMessages, notifyRequests: $notifyRequests, notifyCapsules: $notifyCapsules, notifyShadow: $notifyShadow, notifyStreaks: $notifyStreaks, notifyAchievements: $notifyAchievements, notifyWeeklyReport: $notifyWeeklyReport, notificationPreview: $notificationPreview, quietHoursEnabled: $quietHoursEnabled, quietFromMinute: $quietFromMinute, quietToMinute: $quietToMinute, hideStreaks: $hideStreaks, dailyLimitMinutes: $dailyLimitMinutes, messageRetention: $messageRetention)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsCopyWith<$Res> implements $UserSettingsCopyWith<$Res> {
  factory _$UserSettingsCopyWith(_UserSettings value, $Res Function(_UserSettings) _then) = __$UserSettingsCopyWithImpl;
@override @useResult
$Res call({
 SearchVisibility searchVisibility, RequestPolicy requestPolicy, MomentsAudience momentsAudience, MoodAudience moodAudience, bool showLastSeen, bool readReceipts, bool typingIndicator, bool galaxyVisible, bool notifyMessages, bool notifyRequests, bool notifyCapsules, bool notifyShadow, bool notifyStreaks, bool notifyAchievements, bool notifyWeeklyReport, NotificationPreview notificationPreview, bool quietHoursEnabled, int quietFromMinute, int quietToMinute, bool hideStreaks, int? dailyLimitMinutes, MessageRetention messageRetention
});




}
/// @nodoc
class __$UserSettingsCopyWithImpl<$Res>
    implements _$UserSettingsCopyWith<$Res> {
  __$UserSettingsCopyWithImpl(this._self, this._then);

  final _UserSettings _self;
  final $Res Function(_UserSettings) _then;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchVisibility = null,Object? requestPolicy = null,Object? momentsAudience = null,Object? moodAudience = null,Object? showLastSeen = null,Object? readReceipts = null,Object? typingIndicator = null,Object? galaxyVisible = null,Object? notifyMessages = null,Object? notifyRequests = null,Object? notifyCapsules = null,Object? notifyShadow = null,Object? notifyStreaks = null,Object? notifyAchievements = null,Object? notifyWeeklyReport = null,Object? notificationPreview = null,Object? quietHoursEnabled = null,Object? quietFromMinute = null,Object? quietToMinute = null,Object? hideStreaks = null,Object? dailyLimitMinutes = freezed,Object? messageRetention = null,}) {
  return _then(_UserSettings(
searchVisibility: null == searchVisibility ? _self.searchVisibility : searchVisibility // ignore: cast_nullable_to_non_nullable
as SearchVisibility,requestPolicy: null == requestPolicy ? _self.requestPolicy : requestPolicy // ignore: cast_nullable_to_non_nullable
as RequestPolicy,momentsAudience: null == momentsAudience ? _self.momentsAudience : momentsAudience // ignore: cast_nullable_to_non_nullable
as MomentsAudience,moodAudience: null == moodAudience ? _self.moodAudience : moodAudience // ignore: cast_nullable_to_non_nullable
as MoodAudience,showLastSeen: null == showLastSeen ? _self.showLastSeen : showLastSeen // ignore: cast_nullable_to_non_nullable
as bool,readReceipts: null == readReceipts ? _self.readReceipts : readReceipts // ignore: cast_nullable_to_non_nullable
as bool,typingIndicator: null == typingIndicator ? _self.typingIndicator : typingIndicator // ignore: cast_nullable_to_non_nullable
as bool,galaxyVisible: null == galaxyVisible ? _self.galaxyVisible : galaxyVisible // ignore: cast_nullable_to_non_nullable
as bool,notifyMessages: null == notifyMessages ? _self.notifyMessages : notifyMessages // ignore: cast_nullable_to_non_nullable
as bool,notifyRequests: null == notifyRequests ? _self.notifyRequests : notifyRequests // ignore: cast_nullable_to_non_nullable
as bool,notifyCapsules: null == notifyCapsules ? _self.notifyCapsules : notifyCapsules // ignore: cast_nullable_to_non_nullable
as bool,notifyShadow: null == notifyShadow ? _self.notifyShadow : notifyShadow // ignore: cast_nullable_to_non_nullable
as bool,notifyStreaks: null == notifyStreaks ? _self.notifyStreaks : notifyStreaks // ignore: cast_nullable_to_non_nullable
as bool,notifyAchievements: null == notifyAchievements ? _self.notifyAchievements : notifyAchievements // ignore: cast_nullable_to_non_nullable
as bool,notifyWeeklyReport: null == notifyWeeklyReport ? _self.notifyWeeklyReport : notifyWeeklyReport // ignore: cast_nullable_to_non_nullable
as bool,notificationPreview: null == notificationPreview ? _self.notificationPreview : notificationPreview // ignore: cast_nullable_to_non_nullable
as NotificationPreview,quietHoursEnabled: null == quietHoursEnabled ? _self.quietHoursEnabled : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
as bool,quietFromMinute: null == quietFromMinute ? _self.quietFromMinute : quietFromMinute // ignore: cast_nullable_to_non_nullable
as int,quietToMinute: null == quietToMinute ? _self.quietToMinute : quietToMinute // ignore: cast_nullable_to_non_nullable
as int,hideStreaks: null == hideStreaks ? _self.hideStreaks : hideStreaks // ignore: cast_nullable_to_non_nullable
as bool,dailyLimitMinutes: freezed == dailyLimitMinutes ? _self.dailyLimitMinutes : dailyLimitMinutes // ignore: cast_nullable_to_non_nullable
as int?,messageRetention: null == messageRetention ? _self.messageRetention : messageRetention // ignore: cast_nullable_to_non_nullable
as MessageRetention,
  ));
}


}

// dart format on
