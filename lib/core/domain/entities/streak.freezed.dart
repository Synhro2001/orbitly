// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Streak {

 int get days; DateTime get lastExchangeAt;
/// Create a copy of Streak
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreakCopyWith<Streak> get copyWith => _$StreakCopyWithImpl<Streak>(this as Streak, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Streak;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Streak&&(identical(other.days, _this.days) || other.days == _this.days)&&(identical(other.lastExchangeAt, _this.lastExchangeAt) || other.lastExchangeAt == _this.lastExchangeAt));
}


@override
int get hashCode {
  final _this = this as Streak;
  return Object.hash(runtimeType,_this.days,_this.lastExchangeAt);
}

@override
String toString() {
  final _this = this as Streak;
  return 'Streak(days: ${_this.days}, lastExchangeAt: ${_this.lastExchangeAt})';
}


}

/// @nodoc
abstract mixin class $StreakCopyWith<$Res>  {
  factory $StreakCopyWith(Streak value, $Res Function(Streak) _then) = _$StreakCopyWithImpl;
@useResult
$Res call({
 int days, DateTime lastExchangeAt
});




}
/// @nodoc
class _$StreakCopyWithImpl<$Res>
    implements $StreakCopyWith<$Res> {
  _$StreakCopyWithImpl(this._self, this._then);

  final Streak _self;
  final $Res Function(Streak) _then;

/// Create a copy of Streak
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,Object? lastExchangeAt = null,}) {
  return _then(Streak(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,lastExchangeAt: null == lastExchangeAt ? _self.lastExchangeAt : lastExchangeAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Streak].
extension StreakPatterns on Streak {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Streak value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Streak() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Streak value)  $default,){
final _that = this;
switch (_that) {
case _Streak():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Streak value)?  $default,){
final _that = this;
switch (_that) {
case _Streak() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int days,  DateTime lastExchangeAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Streak() when $default != null:
return $default(_that.days,_that.lastExchangeAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int days,  DateTime lastExchangeAt)  $default,) {final _that = this;
switch (_that) {
case _Streak():
return $default(_that.days,_that.lastExchangeAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int days,  DateTime lastExchangeAt)?  $default,) {final _that = this;
switch (_that) {
case _Streak() when $default != null:
return $default(_that.days,_that.lastExchangeAt);case _:
  return null;

}
}

}

/// @nodoc


class _Streak implements Streak {
  const _Streak({required this.days, required this.lastExchangeAt});
  

@override final  int days;
@override final  DateTime lastExchangeAt;

/// Create a copy of Streak
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreakCopyWith<_Streak> get copyWith => __$StreakCopyWithImpl<_Streak>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Streak&&(identical(other.days, days) || other.days == days)&&(identical(other.lastExchangeAt, lastExchangeAt) || other.lastExchangeAt == lastExchangeAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,days,lastExchangeAt);
}

@override
String toString() {
    return 'Streak(days: $days, lastExchangeAt: $lastExchangeAt)';
}


}

/// @nodoc
abstract mixin class _$StreakCopyWith<$Res> implements $StreakCopyWith<$Res> {
  factory _$StreakCopyWith(_Streak value, $Res Function(_Streak) _then) = __$StreakCopyWithImpl;
@override @useResult
$Res call({
 int days, DateTime lastExchangeAt
});




}
/// @nodoc
class __$StreakCopyWithImpl<$Res>
    implements _$StreakCopyWith<$Res> {
  __$StreakCopyWithImpl(this._self, this._then);

  final _Streak _self;
  final $Res Function(_Streak) _then;

/// Create a copy of Streak
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,Object? lastExchangeAt = null,}) {
  return _then(_Streak(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,lastExchangeAt: null == lastExchangeAt ? _self.lastExchangeAt : lastExchangeAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
