// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportEntryModel {

 FriendModel get friend; int get delta;
/// Create a copy of ReportEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportEntryModelCopyWith<ReportEntryModel> get copyWith => _$ReportEntryModelCopyWithImpl<ReportEntryModel>(this as ReportEntryModel, _$identity);

  /// Serializes this ReportEntryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReportEntryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportEntryModel&&(identical(other.friend, _this.friend) || other.friend == _this.friend)&&(identical(other.delta, _this.delta) || other.delta == _this.delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReportEntryModel;
  return Object.hash(runtimeType,_this.friend,_this.delta);
}

@override
String toString() {
  final _this = this as ReportEntryModel;
  return 'ReportEntryModel(friend: ${_this.friend}, delta: ${_this.delta})';
}


}

/// @nodoc
abstract mixin class $ReportEntryModelCopyWith<$Res>  {
  factory $ReportEntryModelCopyWith(ReportEntryModel value, $Res Function(ReportEntryModel) _then) = _$ReportEntryModelCopyWithImpl;
@useResult
$Res call({
 FriendModel friend, int delta
});


$FriendModelCopyWith<$Res> get friend;

}
/// @nodoc
class _$ReportEntryModelCopyWithImpl<$Res>
    implements $ReportEntryModelCopyWith<$Res> {
  _$ReportEntryModelCopyWithImpl(this._self, this._then);

  final ReportEntryModel _self;
  final $Res Function(ReportEntryModel) _then;

/// Create a copy of ReportEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friend = null,Object? delta = null,}) {
  return _then(ReportEntryModel(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as FriendModel,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ReportEntryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendModelCopyWith<$Res> get friend {
  
  return $FriendModelCopyWith<$Res>(_self.friend, (value) {
    return _then(_self.copyWith(friend: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportEntryModel].
extension ReportEntryModelPatterns on ReportEntryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportEntryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _ReportEntryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReportEntryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FriendModel friend,  int delta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportEntryModel() when $default != null:
return $default(_that.friend,_that.delta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FriendModel friend,  int delta)  $default,) {final _that = this;
switch (_that) {
case _ReportEntryModel():
return $default(_that.friend,_that.delta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FriendModel friend,  int delta)?  $default,) {final _that = this;
switch (_that) {
case _ReportEntryModel() when $default != null:
return $default(_that.friend,_that.delta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportEntryModel implements ReportEntryModel {
  const _ReportEntryModel({required this.friend, required this.delta});
  factory _ReportEntryModel.fromJson(Map<String, dynamic> json) => _$ReportEntryModelFromJson(json);

@override final  FriendModel friend;
@override final  int delta;

/// Create a copy of ReportEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportEntryModelCopyWith<_ReportEntryModel> get copyWith => __$ReportEntryModelCopyWithImpl<_ReportEntryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportEntryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportEntryModel&&(identical(other.friend, friend) || other.friend == friend)&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,friend,delta);
}

@override
String toString() {
    return 'ReportEntryModel(friend: $friend, delta: $delta)';
}


}

/// @nodoc
abstract mixin class _$ReportEntryModelCopyWith<$Res> implements $ReportEntryModelCopyWith<$Res> {
  factory _$ReportEntryModelCopyWith(_ReportEntryModel value, $Res Function(_ReportEntryModel) _then) = __$ReportEntryModelCopyWithImpl;
@override @useResult
$Res call({
 FriendModel friend, int delta
});


@override $FriendModelCopyWith<$Res> get friend;

}
/// @nodoc
class __$ReportEntryModelCopyWithImpl<$Res>
    implements _$ReportEntryModelCopyWith<$Res> {
  __$ReportEntryModelCopyWithImpl(this._self, this._then);

  final _ReportEntryModel _self;
  final $Res Function(_ReportEntryModel) _then;

/// Create a copy of ReportEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friend = null,Object? delta = null,}) {
  return _then(_ReportEntryModel(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as FriendModel,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ReportEntryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendModelCopyWith<$Res> get friend {
  
  return $FriendModelCopyWith<$Res>(_self.friend, (value) {
    return _then(_self.copyWith(friend: value));
  });
}
}

// dart format on
