// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MomentModel {

 String get id; String get friendId; bool get seen; DateTime get postedAt;
/// Create a copy of MomentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MomentModelCopyWith<MomentModel> get copyWith => _$MomentModelCopyWithImpl<MomentModel>(this as MomentModel, _$identity);

  /// Serializes this MomentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MomentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MomentModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.friendId, _this.friendId) || other.friendId == _this.friendId)&&(identical(other.seen, _this.seen) || other.seen == _this.seen)&&(identical(other.postedAt, _this.postedAt) || other.postedAt == _this.postedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MomentModel;
  return Object.hash(runtimeType,_this.id,_this.friendId,_this.seen,_this.postedAt);
}

@override
String toString() {
  final _this = this as MomentModel;
  return 'MomentModel(id: ${_this.id}, friendId: ${_this.friendId}, seen: ${_this.seen}, postedAt: ${_this.postedAt})';
}


}

/// @nodoc
abstract mixin class $MomentModelCopyWith<$Res>  {
  factory $MomentModelCopyWith(MomentModel value, $Res Function(MomentModel) _then) = _$MomentModelCopyWithImpl;
@useResult
$Res call({
 String id, String friendId, bool seen, DateTime postedAt
});




}
/// @nodoc
class _$MomentModelCopyWithImpl<$Res>
    implements $MomentModelCopyWith<$Res> {
  _$MomentModelCopyWithImpl(this._self, this._then);

  final MomentModel _self;
  final $Res Function(MomentModel) _then;

/// Create a copy of MomentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? friendId = null,Object? seen = null,Object? postedAt = null,}) {
  return _then(MomentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,friendId: null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,seen: null == seen ? _self.seen : seen // ignore: cast_nullable_to_non_nullable
as bool,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MomentModel].
extension MomentModelPatterns on MomentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MomentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MomentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MomentModel value)  $default,){
final _that = this;
switch (_that) {
case _MomentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MomentModel value)?  $default,){
final _that = this;
switch (_that) {
case _MomentModel() when $default != null:
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
case _MomentModel() when $default != null:
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
case _MomentModel():
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
case _MomentModel() when $default != null:
return $default(_that.id,_that.friendId,_that.seen,_that.postedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MomentModel implements MomentModel {
  const _MomentModel({required this.id, required this.friendId, required this.seen, required this.postedAt});
  factory _MomentModel.fromJson(Map<String, dynamic> json) => _$MomentModelFromJson(json);

@override final  String id;
@override final  String friendId;
@override final  bool seen;
@override final  DateTime postedAt;

/// Create a copy of MomentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MomentModelCopyWith<_MomentModel> get copyWith => __$MomentModelCopyWithImpl<_MomentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MomentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MomentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.friendId, friendId) || other.friendId == friendId)&&(identical(other.seen, seen) || other.seen == seen)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,friendId,seen,postedAt);
}

@override
String toString() {
    return 'MomentModel(id: $id, friendId: $friendId, seen: $seen, postedAt: $postedAt)';
}


}

/// @nodoc
abstract mixin class _$MomentModelCopyWith<$Res> implements $MomentModelCopyWith<$Res> {
  factory _$MomentModelCopyWith(_MomentModel value, $Res Function(_MomentModel) _then) = __$MomentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String friendId, bool seen, DateTime postedAt
});




}
/// @nodoc
class __$MomentModelCopyWithImpl<$Res>
    implements _$MomentModelCopyWith<$Res> {
  __$MomentModelCopyWithImpl(this._self, this._then);

  final _MomentModel _self;
  final $Res Function(_MomentModel) _then;

/// Create a copy of MomentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? friendId = null,Object? seen = null,Object? postedAt = null,}) {
  return _then(_MomentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,friendId: null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,seen: null == seen ? _self.seen : seen // ignore: cast_nullable_to_non_nullable
as bool,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
