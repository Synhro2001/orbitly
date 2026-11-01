// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'award.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Award {

 String get id; String get title; String get emoji; bool get unlocked;
/// Create a copy of Award
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AwardCopyWith<Award> get copyWith => _$AwardCopyWithImpl<Award>(this as Award, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Award;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Award&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.emoji, _this.emoji) || other.emoji == _this.emoji)&&(identical(other.unlocked, _this.unlocked) || other.unlocked == _this.unlocked));
}


@override
int get hashCode {
  final _this = this as Award;
  return Object.hash(runtimeType,_this.id,_this.title,_this.emoji,_this.unlocked);
}

@override
String toString() {
  final _this = this as Award;
  return 'Award(id: ${_this.id}, title: ${_this.title}, emoji: ${_this.emoji}, unlocked: ${_this.unlocked})';
}


}

/// @nodoc
abstract mixin class $AwardCopyWith<$Res>  {
  factory $AwardCopyWith(Award value, $Res Function(Award) _then) = _$AwardCopyWithImpl;
@useResult
$Res call({
 String id, String title, String emoji, bool unlocked
});




}
/// @nodoc
class _$AwardCopyWithImpl<$Res>
    implements $AwardCopyWith<$Res> {
  _$AwardCopyWithImpl(this._self, this._then);

  final Award _self;
  final $Res Function(Award) _then;

/// Create a copy of Award
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? emoji = null,Object? unlocked = null,}) {
  return _then(Award(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Award].
extension AwardPatterns on Award {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Award value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Award() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Award value)  $default,){
final _that = this;
switch (_that) {
case _Award():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Award value)?  $default,){
final _that = this;
switch (_that) {
case _Award() when $default != null:
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
case _Award() when $default != null:
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
case _Award():
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
case _Award() when $default != null:
return $default(_that.id,_that.title,_that.emoji,_that.unlocked);case _:
  return null;

}
}

}

/// @nodoc


class _Award implements Award {
  const _Award({required this.id, required this.title, required this.emoji, required this.unlocked});
  

@override final  String id;
@override final  String title;
@override final  String emoji;
@override final  bool unlocked;

/// Create a copy of Award
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AwardCopyWith<_Award> get copyWith => __$AwardCopyWithImpl<_Award>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Award&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,emoji,unlocked);
}

@override
String toString() {
    return 'Award(id: $id, title: $title, emoji: $emoji, unlocked: $unlocked)';
}


}

/// @nodoc
abstract mixin class _$AwardCopyWith<$Res> implements $AwardCopyWith<$Res> {
  factory _$AwardCopyWith(_Award value, $Res Function(_Award) _then) = __$AwardCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String emoji, bool unlocked
});




}
/// @nodoc
class __$AwardCopyWithImpl<$Res>
    implements _$AwardCopyWith<$Res> {
  __$AwardCopyWithImpl(this._self, this._then);

  final _Award _self;
  final $Res Function(_Award) _then;

/// Create a copy of Award
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? emoji = null,Object? unlocked = null,}) {
  return _then(_Award(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
