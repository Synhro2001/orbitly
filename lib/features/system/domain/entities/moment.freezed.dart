// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Moment {

 String get id; String get friendId; bool get seen; DateTime get postedAt;
/// Create a copy of Moment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MomentCopyWith<Moment> get copyWith => _$MomentCopyWithImpl<Moment>(this as Moment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Moment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Moment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.friendId, _this.friendId) || other.friendId == _this.friendId)&&(identical(other.seen, _this.seen) || other.seen == _this.seen)&&(identical(other.postedAt, _this.postedAt) || other.postedAt == _this.postedAt));
}


@override
int get hashCode {
  final _this = this as Moment;
  return Object.hash(runtimeType,_this.id,_this.friendId,_this.seen,_this.postedAt);
}

@override
String toString() {
  final _this = this as Moment;
  return 'Moment(id: ${_this.id}, friendId: ${_this.friendId}, seen: ${_this.seen}, postedAt: ${_this.postedAt})';
}


}

/// @nodoc
abstract mixin class $MomentCopyWith<$Res>  {
  factory $MomentCopyWith(Moment value, $Res Function(Moment) _then) = _$MomentCopyWithImpl;
@useResult
$Res call({
 String id, String friendId, bool seen, DateTime postedAt
});




}
/// @nodoc
class _$MomentCopyWithImpl<$Res>
    implements $MomentCopyWith<$Res> {
  _$MomentCopyWithImpl(this._self, this._then);

  final Moment _self;
  final $Res Function(Moment) _then;

/// Create a copy of Moment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? friendId = null,Object? seen = null,Object? postedAt = null,}) {
  return _then(Moment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,friendId: null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,seen: null == seen ? _self.seen : seen // ignore: cast_nullable_to_non_nullable
as bool,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Moment].
extension MomentPatterns on Moment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Moment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Moment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Moment value)  $default,){
final _that = this;
switch (_that) {
case _Moment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Moment value)?  $default,){
final _that = this;
switch (_that) {
case _Moment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String friendId,  bool seen,  DateTime postedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Moment() when $default != null:
return $default(_that.id,_that.friendId,_that.seen,_that.postedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String friendId,  bool seen,  DateTime postedAt)  $default,) {final _that = this;
switch (_that) {
case _Moment():
return $default(_that.id,_that.friendId,_that.seen,_that.postedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String friendId,  bool seen,  DateTime postedAt)?  $default,) {final _that = this;
switch (_that) {
case _Moment() when $default != null:
return $default(_that.id,_that.friendId,_that.seen,_that.postedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Moment implements Moment {
  const _Moment({required this.id, required this.friendId, required this.seen, required this.postedAt});
  

@override final  String id;
@override final  String friendId;
@override final  bool seen;
@override final  DateTime postedAt;

/// Create a copy of Moment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MomentCopyWith<_Moment> get copyWith => __$MomentCopyWithImpl<_Moment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Moment&&(identical(other.id, id) || other.id == id)&&(identical(other.friendId, friendId) || other.friendId == friendId)&&(identical(other.seen, seen) || other.seen == seen)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,friendId,seen,postedAt);
}

@override
String toString() {
    return 'Moment(id: $id, friendId: $friendId, seen: $seen, postedAt: $postedAt)';
}


}

/// @nodoc
abstract mixin class _$MomentCopyWith<$Res> implements $MomentCopyWith<$Res> {
  factory _$MomentCopyWith(_Moment value, $Res Function(_Moment) _then) = __$MomentCopyWithImpl;
@override @useResult
$Res call({
 String id, String friendId, bool seen, DateTime postedAt
});




}
/// @nodoc
class __$MomentCopyWithImpl<$Res>
    implements _$MomentCopyWith<$Res> {
  __$MomentCopyWithImpl(this._self, this._then);

  final _Moment _self;
  final $Res Function(_Moment) _then;

/// Create a copy of Moment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? friendId = null,Object? seen = null,Object? postedAt = null,}) {
  return _then(_Moment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,friendId: null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,seen: null == seen ? _self.seen : seen // ignore: cast_nullable_to_non_nullable
as bool,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
