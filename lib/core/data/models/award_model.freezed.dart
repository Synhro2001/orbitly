// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'award_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AwardModel {

 String get id; String get title; String get emoji; bool get unlocked;
/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AwardModelCopyWith<AwardModel> get copyWith => _$AwardModelCopyWithImpl<AwardModel>(this as AwardModel, _$identity);

  /// Serializes this AwardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AwardModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AwardModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.emoji, _this.emoji) || other.emoji == _this.emoji)&&(identical(other.unlocked, _this.unlocked) || other.unlocked == _this.unlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AwardModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.emoji,_this.unlocked);
}

@override
String toString() {
  final _this = this as AwardModel;
  return 'AwardModel(id: ${_this.id}, title: ${_this.title}, emoji: ${_this.emoji}, unlocked: ${_this.unlocked})';
}


}

/// @nodoc
abstract mixin class $AwardModelCopyWith<$Res>  {
  factory $AwardModelCopyWith(AwardModel value, $Res Function(AwardModel) _then) = _$AwardModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String emoji, bool unlocked
});




}
/// @nodoc
class _$AwardModelCopyWithImpl<$Res>
    implements $AwardModelCopyWith<$Res> {
  _$AwardModelCopyWithImpl(this._self, this._then);

  final AwardModel _self;
  final $Res Function(AwardModel) _then;

/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? emoji = null,Object? unlocked = null,}) {
  return _then(AwardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AwardModel].
extension AwardModelPatterns on AwardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AwardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AwardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AwardModel value)  $default,){
final _that = this;
switch (_that) {
case _AwardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AwardModel value)?  $default,){
final _that = this;
switch (_that) {
case _AwardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String emoji,  bool unlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AwardModel() when $default != null:
return $default(_that.id,_that.title,_that.emoji,_that.unlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String emoji,  bool unlocked)  $default,) {final _that = this;
switch (_that) {
case _AwardModel():
return $default(_that.id,_that.title,_that.emoji,_that.unlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String emoji,  bool unlocked)?  $default,) {final _that = this;
switch (_that) {
case _AwardModel() when $default != null:
return $default(_that.id,_that.title,_that.emoji,_that.unlocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AwardModel implements AwardModel {
  const _AwardModel({required this.id, required this.title, required this.emoji, required this.unlocked});
  factory _AwardModel.fromJson(Map<String, dynamic> json) => _$AwardModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String emoji;
@override final  bool unlocked;

/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AwardModelCopyWith<_AwardModel> get copyWith => __$AwardModelCopyWithImpl<_AwardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AwardModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AwardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,emoji,unlocked);
}

@override
String toString() {
    return 'AwardModel(id: $id, title: $title, emoji: $emoji, unlocked: $unlocked)';
}


}

/// @nodoc
abstract mixin class _$AwardModelCopyWith<$Res> implements $AwardModelCopyWith<$Res> {
  factory _$AwardModelCopyWith(_AwardModel value, $Res Function(_AwardModel) _then) = __$AwardModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String emoji, bool unlocked
});




}
/// @nodoc
class __$AwardModelCopyWithImpl<$Res>
    implements _$AwardModelCopyWith<$Res> {
  __$AwardModelCopyWithImpl(this._self, this._then);

  final _AwardModel _self;
  final $Res Function(_AwardModel) _then;

/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? emoji = null,Object? unlocked = null,}) {
  return _then(_AwardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
