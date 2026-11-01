// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shadow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Shadow {

 DateTime get from; DateTime get until;
/// Create a copy of Shadow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShadowCopyWith<Shadow> get copyWith => _$ShadowCopyWithImpl<Shadow>(this as Shadow, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Shadow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Shadow&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.until, _this.until) || other.until == _this.until));
}


@override
int get hashCode {
  final _this = this as Shadow;
  return Object.hash(runtimeType,_this.from,_this.until);
}

@override
String toString() {
  final _this = this as Shadow;
  return 'Shadow(from: ${_this.from}, until: ${_this.until})';
}


}

/// @nodoc
abstract mixin class $ShadowCopyWith<$Res>  {
  factory $ShadowCopyWith(Shadow value, $Res Function(Shadow) _then) = _$ShadowCopyWithImpl;
@useResult
$Res call({
 DateTime from, DateTime until
});




}
/// @nodoc
class _$ShadowCopyWithImpl<$Res>
    implements $ShadowCopyWith<$Res> {
  _$ShadowCopyWithImpl(this._self, this._then);

  final Shadow _self;
  final $Res Function(Shadow) _then;

/// Create a copy of Shadow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? until = null,}) {
  return _then(Shadow(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,until: null == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Shadow].
extension ShadowPatterns on Shadow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Shadow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Shadow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Shadow value)  $default,){
final _that = this;
switch (_that) {
case _Shadow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Shadow value)?  $default,){
final _that = this;
switch (_that) {
case _Shadow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime from,  DateTime until)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Shadow() when $default != null:
return $default(_that.from,_that.until);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime from,  DateTime until)  $default,) {final _that = this;
switch (_that) {
case _Shadow():
return $default(_that.from,_that.until);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime from,  DateTime until)?  $default,) {final _that = this;
switch (_that) {
case _Shadow() when $default != null:
return $default(_that.from,_that.until);case _:
  return null;

}
}

}

/// @nodoc


class _Shadow extends Shadow {
  const _Shadow({required this.from, required this.until}): super._();
  

@override final  DateTime from;
@override final  DateTime until;

/// Create a copy of Shadow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShadowCopyWith<_Shadow> get copyWith => __$ShadowCopyWithImpl<_Shadow>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Shadow&&(identical(other.from, from) || other.from == from)&&(identical(other.until, until) || other.until == until));
}


@override
int get hashCode {
    return Object.hash(runtimeType,from,until);
}

@override
String toString() {
    return 'Shadow(from: $from, until: $until)';
}


}

/// @nodoc
abstract mixin class _$ShadowCopyWith<$Res> implements $ShadowCopyWith<$Res> {
  factory _$ShadowCopyWith(_Shadow value, $Res Function(_Shadow) _then) = __$ShadowCopyWithImpl;
@override @useResult
$Res call({
 DateTime from, DateTime until
});




}
/// @nodoc
class __$ShadowCopyWithImpl<$Res>
    implements _$ShadowCopyWith<$Res> {
  __$ShadowCopyWithImpl(this._self, this._then);

  final _Shadow _self;
  final $Res Function(_Shadow) _then;

/// Create a copy of Shadow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? until = null,}) {
  return _then(_Shadow(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,until: null == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
