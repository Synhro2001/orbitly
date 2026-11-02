// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceSettings {

 bool get haptics; MotionPreference get motion; MediaAutoload get mediaAutoload; bool get dataSaver;
/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsCopyWith<DeviceSettings> get copyWith => _$DeviceSettingsCopyWithImpl<DeviceSettings>(this as DeviceSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DeviceSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettings&&(identical(other.haptics, _this.haptics) || other.haptics == _this.haptics)&&(identical(other.motion, _this.motion) || other.motion == _this.motion)&&(identical(other.mediaAutoload, _this.mediaAutoload) || other.mediaAutoload == _this.mediaAutoload)&&(identical(other.dataSaver, _this.dataSaver) || other.dataSaver == _this.dataSaver));
}


@override
int get hashCode {
  final _this = this as DeviceSettings;
  return Object.hash(runtimeType,_this.haptics,_this.motion,_this.mediaAutoload,_this.dataSaver);
}

@override
String toString() {
  final _this = this as DeviceSettings;
  return 'DeviceSettings(haptics: ${_this.haptics}, motion: ${_this.motion}, mediaAutoload: ${_this.mediaAutoload}, dataSaver: ${_this.dataSaver})';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsCopyWith<$Res>  {
  factory $DeviceSettingsCopyWith(DeviceSettings value, $Res Function(DeviceSettings) _then) = _$DeviceSettingsCopyWithImpl;
@useResult
$Res call({
 bool haptics, MotionPreference motion, MediaAutoload mediaAutoload, bool dataSaver
});




}
/// @nodoc
class _$DeviceSettingsCopyWithImpl<$Res>
    implements $DeviceSettingsCopyWith<$Res> {
  _$DeviceSettingsCopyWithImpl(this._self, this._then);

  final DeviceSettings _self;
  final $Res Function(DeviceSettings) _then;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? haptics = null,Object? motion = null,Object? mediaAutoload = null,Object? dataSaver = null,}) {
  return _then(DeviceSettings(
haptics: null == haptics ? _self.haptics : haptics // ignore: cast_nullable_to_non_nullable
as bool,motion: null == motion ? _self.motion : motion // ignore: cast_nullable_to_non_nullable
as MotionPreference,mediaAutoload: null == mediaAutoload ? _self.mediaAutoload : mediaAutoload // ignore: cast_nullable_to_non_nullable
as MediaAutoload,dataSaver: null == dataSaver ? _self.dataSaver : dataSaver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceSettings].
extension DeviceSettingsPatterns on DeviceSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceSettings value)  $default,){
final _that = this;
switch (_that) {
case _DeviceSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceSettings value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool haptics,  MotionPreference motion,  MediaAutoload mediaAutoload,  bool dataSaver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
return $default(_that.haptics,_that.motion,_that.mediaAutoload,_that.dataSaver);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool haptics,  MotionPreference motion,  MediaAutoload mediaAutoload,  bool dataSaver)  $default,) {final _that = this;
switch (_that) {
case _DeviceSettings():
return $default(_that.haptics,_that.motion,_that.mediaAutoload,_that.dataSaver);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool haptics,  MotionPreference motion,  MediaAutoload mediaAutoload,  bool dataSaver)?  $default,) {final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
return $default(_that.haptics,_that.motion,_that.mediaAutoload,_that.dataSaver);case _:
  return null;

}
}

}

/// @nodoc


class _DeviceSettings implements DeviceSettings {
  const _DeviceSettings({this.haptics = true, this.motion = MotionPreference.system, this.mediaAutoload = MediaAutoload.wifi, this.dataSaver = false});
  

@override@JsonKey() final  bool haptics;
@override@JsonKey() final  MotionPreference motion;
@override@JsonKey() final  MediaAutoload mediaAutoload;
@override@JsonKey() final  bool dataSaver;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSettingsCopyWith<_DeviceSettings> get copyWith => __$DeviceSettingsCopyWithImpl<_DeviceSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSettings&&(identical(other.haptics, haptics) || other.haptics == haptics)&&(identical(other.motion, motion) || other.motion == motion)&&(identical(other.mediaAutoload, mediaAutoload) || other.mediaAutoload == mediaAutoload)&&(identical(other.dataSaver, dataSaver) || other.dataSaver == dataSaver));
}


@override
int get hashCode {
    return Object.hash(runtimeType,haptics,motion,mediaAutoload,dataSaver);
}

@override
String toString() {
    return 'DeviceSettings(haptics: $haptics, motion: $motion, mediaAutoload: $mediaAutoload, dataSaver: $dataSaver)';
}


}

/// @nodoc
abstract mixin class _$DeviceSettingsCopyWith<$Res> implements $DeviceSettingsCopyWith<$Res> {
  factory _$DeviceSettingsCopyWith(_DeviceSettings value, $Res Function(_DeviceSettings) _then) = __$DeviceSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool haptics, MotionPreference motion, MediaAutoload mediaAutoload, bool dataSaver
});




}
/// @nodoc
class __$DeviceSettingsCopyWithImpl<$Res>
    implements _$DeviceSettingsCopyWith<$Res> {
  __$DeviceSettingsCopyWithImpl(this._self, this._then);

  final _DeviceSettings _self;
  final $Res Function(_DeviceSettings) _then;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? haptics = null,Object? motion = null,Object? mediaAutoload = null,Object? dataSaver = null,}) {
  return _then(_DeviceSettings(
haptics: null == haptics ? _self.haptics : haptics // ignore: cast_nullable_to_non_nullable
as bool,motion: null == motion ? _self.motion : motion // ignore: cast_nullable_to_non_nullable
as MotionPreference,mediaAutoload: null == mediaAutoload ? _self.mediaAutoload : mediaAutoload // ignore: cast_nullable_to_non_nullable
as MediaAutoload,dataSaver: null == dataSaver ? _self.dataSaver : dataSaver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$DailyUsage {

/// The day these minutes belong to, `yyyy-mm-dd`.
 String get day; int get minutes;/// The reminder has been shown today.
 bool get reminded;
/// Create a copy of DailyUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyUsageCopyWith<DailyUsage> get copyWith => _$DailyUsageCopyWithImpl<DailyUsage>(this as DailyUsage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DailyUsage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyUsage&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.minutes, _this.minutes) || other.minutes == _this.minutes)&&(identical(other.reminded, _this.reminded) || other.reminded == _this.reminded));
}


@override
int get hashCode {
  final _this = this as DailyUsage;
  return Object.hash(runtimeType,_this.day,_this.minutes,_this.reminded);
}

@override
String toString() {
  final _this = this as DailyUsage;
  return 'DailyUsage(day: ${_this.day}, minutes: ${_this.minutes}, reminded: ${_this.reminded})';
}


}

/// @nodoc
abstract mixin class $DailyUsageCopyWith<$Res>  {
  factory $DailyUsageCopyWith(DailyUsage value, $Res Function(DailyUsage) _then) = _$DailyUsageCopyWithImpl;
@useResult
$Res call({
 String day, int minutes, bool reminded
});




}
/// @nodoc
class _$DailyUsageCopyWithImpl<$Res>
    implements $DailyUsageCopyWith<$Res> {
  _$DailyUsageCopyWithImpl(this._self, this._then);

  final DailyUsage _self;
  final $Res Function(DailyUsage) _then;

/// Create a copy of DailyUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? minutes = null,Object? reminded = null,}) {
  return _then(DailyUsage(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,reminded: null == reminded ? _self.reminded : reminded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyUsage].
extension DailyUsagePatterns on DailyUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyUsage value)  $default,){
final _that = this;
switch (_that) {
case _DailyUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyUsage value)?  $default,){
final _that = this;
switch (_that) {
case _DailyUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String day,  int minutes,  bool reminded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyUsage() when $default != null:
return $default(_that.day,_that.minutes,_that.reminded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String day,  int minutes,  bool reminded)  $default,) {final _that = this;
switch (_that) {
case _DailyUsage():
return $default(_that.day,_that.minutes,_that.reminded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String day,  int minutes,  bool reminded)?  $default,) {final _that = this;
switch (_that) {
case _DailyUsage() when $default != null:
return $default(_that.day,_that.minutes,_that.reminded);case _:
  return null;

}
}

}

/// @nodoc


class _DailyUsage extends DailyUsage {
  const _DailyUsage({this.day = '', this.minutes = 0, this.reminded = false}): super._();
  

/// The day these minutes belong to, `yyyy-mm-dd`.
@override@JsonKey() final  String day;
@override@JsonKey() final  int minutes;
/// The reminder has been shown today.
@override@JsonKey() final  bool reminded;

/// Create a copy of DailyUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyUsageCopyWith<_DailyUsage> get copyWith => __$DailyUsageCopyWithImpl<_DailyUsage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyUsage&&(identical(other.day, day) || other.day == day)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.reminded, reminded) || other.reminded == reminded));
}


@override
int get hashCode {
    return Object.hash(runtimeType,day,minutes,reminded);
}

@override
String toString() {
    return 'DailyUsage(day: $day, minutes: $minutes, reminded: $reminded)';
}


}

/// @nodoc
abstract mixin class _$DailyUsageCopyWith<$Res> implements $DailyUsageCopyWith<$Res> {
  factory _$DailyUsageCopyWith(_DailyUsage value, $Res Function(_DailyUsage) _then) = __$DailyUsageCopyWithImpl;
@override @useResult
$Res call({
 String day, int minutes, bool reminded
});




}
/// @nodoc
class __$DailyUsageCopyWithImpl<$Res>
    implements _$DailyUsageCopyWith<$Res> {
  __$DailyUsageCopyWithImpl(this._self, this._then);

  final _DailyUsage _self;
  final $Res Function(_DailyUsage) _then;

/// Create a copy of DailyUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? minutes = null,Object? reminded = null,}) {
  return _then(_DailyUsage(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,reminded: null == reminded ? _self.reminded : reminded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
