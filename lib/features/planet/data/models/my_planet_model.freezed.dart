// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_planet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyPlanetModel {

 String get name; PlanetAppearanceModel get appearance; int get level; int get xp; int get xpForNextLevel; int get bestStreakDays; Mood get mood; DateTime? get shadowFrom; DateTime? get shadowUntil;
/// Create a copy of MyPlanetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyPlanetModelCopyWith<MyPlanetModel> get copyWith => _$MyPlanetModelCopyWithImpl<MyPlanetModel>(this as MyPlanetModel, _$identity);

  /// Serializes this MyPlanetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyPlanetModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyPlanetModel&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.appearance, _this.appearance) || other.appearance == _this.appearance)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.xp, _this.xp) || other.xp == _this.xp)&&(identical(other.xpForNextLevel, _this.xpForNextLevel) || other.xpForNextLevel == _this.xpForNextLevel)&&(identical(other.bestStreakDays, _this.bestStreakDays) || other.bestStreakDays == _this.bestStreakDays)&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&(identical(other.shadowFrom, _this.shadowFrom) || other.shadowFrom == _this.shadowFrom)&&(identical(other.shadowUntil, _this.shadowUntil) || other.shadowUntil == _this.shadowUntil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyPlanetModel;
  return Object.hash(runtimeType,_this.name,_this.appearance,_this.level,_this.xp,_this.xpForNextLevel,_this.bestStreakDays,_this.mood,_this.shadowFrom,_this.shadowUntil);
}

@override
String toString() {
  final _this = this as MyPlanetModel;
  return 'MyPlanetModel(name: ${_this.name}, appearance: ${_this.appearance}, level: ${_this.level}, xp: ${_this.xp}, xpForNextLevel: ${_this.xpForNextLevel}, bestStreakDays: ${_this.bestStreakDays}, mood: ${_this.mood}, shadowFrom: ${_this.shadowFrom}, shadowUntil: ${_this.shadowUntil})';
}


}

/// @nodoc
abstract mixin class $MyPlanetModelCopyWith<$Res>  {
  factory $MyPlanetModelCopyWith(MyPlanetModel value, $Res Function(MyPlanetModel) _then) = _$MyPlanetModelCopyWithImpl;
@useResult
$Res call({
 String name, PlanetAppearanceModel appearance, int level, int xp, int xpForNextLevel, int bestStreakDays, Mood mood, DateTime? shadowFrom, DateTime? shadowUntil
});


$PlanetAppearanceModelCopyWith<$Res> get appearance;

}
/// @nodoc
class _$MyPlanetModelCopyWithImpl<$Res>
    implements $MyPlanetModelCopyWith<$Res> {
  _$MyPlanetModelCopyWithImpl(this._self, this._then);

  final MyPlanetModel _self;
  final $Res Function(MyPlanetModel) _then;

/// Create a copy of MyPlanetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? appearance = null,Object? level = null,Object? xp = null,Object? xpForNextLevel = null,Object? bestStreakDays = null,Object? mood = null,Object? shadowFrom = freezed,Object? shadowUntil = freezed,}) {
  return _then(MyPlanetModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearanceModel,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,xpForNextLevel: null == xpForNextLevel ? _self.xpForNextLevel : xpForNextLevel // ignore: cast_nullable_to_non_nullable
as int,bestStreakDays: null == bestStreakDays ? _self.bestStreakDays : bestStreakDays // ignore: cast_nullable_to_non_nullable
as int,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,shadowFrom: freezed == shadowFrom ? _self.shadowFrom : shadowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,shadowUntil: freezed == shadowUntil ? _self.shadowUntil : shadowUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of MyPlanetModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceModelCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceModelCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyPlanetModel].
extension MyPlanetModelPatterns on MyPlanetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyPlanetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyPlanetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyPlanetModel value)  $default,){
final _that = this;
switch (_that) {
case _MyPlanetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyPlanetModel value)?  $default,){
final _that = this;
switch (_that) {
case _MyPlanetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  PlanetAppearanceModel appearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  DateTime? shadowFrom,  DateTime? shadowUntil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyPlanetModel() when $default != null:
return $default(_that.name,_that.appearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.shadowFrom,_that.shadowUntil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  PlanetAppearanceModel appearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  DateTime? shadowFrom,  DateTime? shadowUntil)  $default,) {final _that = this;
switch (_that) {
case _MyPlanetModel():
return $default(_that.name,_that.appearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.shadowFrom,_that.shadowUntil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  PlanetAppearanceModel appearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  DateTime? shadowFrom,  DateTime? shadowUntil)?  $default,) {final _that = this;
switch (_that) {
case _MyPlanetModel() when $default != null:
return $default(_that.name,_that.appearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.shadowFrom,_that.shadowUntil);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyPlanetModel implements MyPlanetModel {
  const _MyPlanetModel({required this.name, required this.appearance, required this.level, required this.xp, required this.xpForNextLevel, required this.bestStreakDays, required this.mood, this.shadowFrom, this.shadowUntil});
  factory _MyPlanetModel.fromJson(Map<String, dynamic> json) => _$MyPlanetModelFromJson(json);

@override final  String name;
@override final  PlanetAppearanceModel appearance;
@override final  int level;
@override final  int xp;
@override final  int xpForNextLevel;
@override final  int bestStreakDays;
@override final  Mood mood;
@override final  DateTime? shadowFrom;
@override final  DateTime? shadowUntil;

/// Create a copy of MyPlanetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyPlanetModelCopyWith<_MyPlanetModel> get copyWith => __$MyPlanetModelCopyWithImpl<_MyPlanetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyPlanetModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyPlanetModel&&(identical(other.name, name) || other.name == name)&&(identical(other.appearance, appearance) || other.appearance == appearance)&&(identical(other.level, level) || other.level == level)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.xpForNextLevel, xpForNextLevel) || other.xpForNextLevel == xpForNextLevel)&&(identical(other.bestStreakDays, bestStreakDays) || other.bestStreakDays == bestStreakDays)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.shadowFrom, shadowFrom) || other.shadowFrom == shadowFrom)&&(identical(other.shadowUntil, shadowUntil) || other.shadowUntil == shadowUntil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,appearance,level,xp,xpForNextLevel,bestStreakDays,mood,shadowFrom,shadowUntil);
}

@override
String toString() {
    return 'MyPlanetModel(name: $name, appearance: $appearance, level: $level, xp: $xp, xpForNextLevel: $xpForNextLevel, bestStreakDays: $bestStreakDays, mood: $mood, shadowFrom: $shadowFrom, shadowUntil: $shadowUntil)';
}


}

/// @nodoc
abstract mixin class _$MyPlanetModelCopyWith<$Res> implements $MyPlanetModelCopyWith<$Res> {
  factory _$MyPlanetModelCopyWith(_MyPlanetModel value, $Res Function(_MyPlanetModel) _then) = __$MyPlanetModelCopyWithImpl;
@override @useResult
$Res call({
 String name, PlanetAppearanceModel appearance, int level, int xp, int xpForNextLevel, int bestStreakDays, Mood mood, DateTime? shadowFrom, DateTime? shadowUntil
});


@override $PlanetAppearanceModelCopyWith<$Res> get appearance;

}
/// @nodoc
class __$MyPlanetModelCopyWithImpl<$Res>
    implements _$MyPlanetModelCopyWith<$Res> {
  __$MyPlanetModelCopyWithImpl(this._self, this._then);

  final _MyPlanetModel _self;
  final $Res Function(_MyPlanetModel) _then;

/// Create a copy of MyPlanetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? appearance = null,Object? level = null,Object? xp = null,Object? xpForNextLevel = null,Object? bestStreakDays = null,Object? mood = null,Object? shadowFrom = freezed,Object? shadowUntil = freezed,}) {
  return _then(_MyPlanetModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearanceModel,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,xpForNextLevel: null == xpForNextLevel ? _self.xpForNextLevel : xpForNextLevel // ignore: cast_nullable_to_non_nullable
as int,bestStreakDays: null == bestStreakDays ? _self.bestStreakDays : bestStreakDays // ignore: cast_nullable_to_non_nullable
as int,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,shadowFrom: freezed == shadowFrom ? _self.shadowFrom : shadowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,shadowUntil: freezed == shadowUntil ? _self.shadowUntil : shadowUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of MyPlanetModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceModelCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceModelCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}

// dart format on
