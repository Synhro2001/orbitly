// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_planet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyPlanet {

 String get name; PlanetAppearance get appearance; int get level; int get xp; int get xpForNextLevel; int get bestStreakDays; Mood get mood; List<Award> get awards;
/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyPlanetCopyWith<MyPlanet> get copyWith => _$MyPlanetCopyWithImpl<MyPlanet>(this as MyPlanet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MyPlanet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyPlanet&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.appearance, _this.appearance) || other.appearance == _this.appearance)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.xp, _this.xp) || other.xp == _this.xp)&&(identical(other.xpForNextLevel, _this.xpForNextLevel) || other.xpForNextLevel == _this.xpForNextLevel)&&(identical(other.bestStreakDays, _this.bestStreakDays) || other.bestStreakDays == _this.bestStreakDays)&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&const DeepCollectionEquality().equals(other.awards, _this.awards));
}


@override
int get hashCode {
  final _this = this as MyPlanet;
  return Object.hash(runtimeType,_this.name,_this.appearance,_this.level,_this.xp,_this.xpForNextLevel,_this.bestStreakDays,_this.mood,const DeepCollectionEquality().hash(_this.awards));
}

@override
String toString() {
  final _this = this as MyPlanet;
  return 'MyPlanet(name: ${_this.name}, appearance: ${_this.appearance}, level: ${_this.level}, xp: ${_this.xp}, xpForNextLevel: ${_this.xpForNextLevel}, bestStreakDays: ${_this.bestStreakDays}, mood: ${_this.mood}, awards: ${_this.awards})';
}


}

/// @nodoc
abstract mixin class $MyPlanetCopyWith<$Res>  {
  factory $MyPlanetCopyWith(MyPlanet value, $Res Function(MyPlanet) _then) = _$MyPlanetCopyWithImpl;
@useResult
$Res call({
 String name, PlanetAppearance appearance, int level, int xp, int xpForNextLevel, int bestStreakDays, Mood mood, List<Award> awards
});


$PlanetAppearanceCopyWith<$Res> get appearance;

}
/// @nodoc
class _$MyPlanetCopyWithImpl<$Res>
    implements $MyPlanetCopyWith<$Res> {
  _$MyPlanetCopyWithImpl(this._self, this._then);

  final MyPlanet _self;
  final $Res Function(MyPlanet) _then;

/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? appearance = null,Object? level = null,Object? xp = null,Object? xpForNextLevel = null,Object? bestStreakDays = null,Object? mood = null,Object? awards = null,}) {
  return _then(MyPlanet(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearance,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,xpForNextLevel: null == xpForNextLevel ? _self.xpForNextLevel : xpForNextLevel // ignore: cast_nullable_to_non_nullable
as int,bestStreakDays: null == bestStreakDays ? _self.bestStreakDays : bestStreakDays // ignore: cast_nullable_to_non_nullable
as int,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,awards: null == awards ? _self.awards : awards // ignore: cast_nullable_to_non_nullable
as List<Award>,
  ));
}
/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyPlanet].
extension MyPlanetPatterns on MyPlanet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyPlanet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyPlanet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyPlanet value)  $default,){
final _that = this;
switch (_that) {
case _MyPlanet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyPlanet value)?  $default,){
final _that = this;
switch (_that) {
case _MyPlanet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  PlanetAppearance appearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  List<Award> awards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyPlanet() when $default != null:
return $default(_that.name,_that.appearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.awards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  PlanetAppearance appearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  List<Award> awards)  $default,) {final _that = this;
switch (_that) {
case _MyPlanet():
return $default(_that.name,_that.appearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.awards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  PlanetAppearance appearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  List<Award> awards)?  $default,) {final _that = this;
switch (_that) {
case _MyPlanet() when $default != null:
return $default(_that.name,_that.appearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.awards);case _:
  return null;

}
}

}

/// @nodoc


class _MyPlanet extends MyPlanet {
  const _MyPlanet({required this.name, required this.appearance, required this.level, required this.xp, required this.xpForNextLevel, required this.bestStreakDays, required this.mood, required  List<Award> awards}): _awards = awards,super._();
  

@override final  String name;
@override final  PlanetAppearance appearance;
@override final  int level;
@override final  int xp;
@override final  int xpForNextLevel;
@override final  int bestStreakDays;
@override final  Mood mood;
 final  List<Award> _awards;
@override List<Award> get awards {
  if (_awards is EqualUnmodifiableListView) return _awards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_awards);
}


/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyPlanetCopyWith<_MyPlanet> get copyWith => __$MyPlanetCopyWithImpl<_MyPlanet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyPlanet&&(identical(other.name, name) || other.name == name)&&(identical(other.appearance, appearance) || other.appearance == appearance)&&(identical(other.level, level) || other.level == level)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.xpForNextLevel, xpForNextLevel) || other.xpForNextLevel == xpForNextLevel)&&(identical(other.bestStreakDays, bestStreakDays) || other.bestStreakDays == bestStreakDays)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other.awards, _awards));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,appearance,level,xp,xpForNextLevel,bestStreakDays,mood,const DeepCollectionEquality().hash(_awards));
}

@override
String toString() {
    return 'MyPlanet(name: $name, appearance: $appearance, level: $level, xp: $xp, xpForNextLevel: $xpForNextLevel, bestStreakDays: $bestStreakDays, mood: $mood, awards: $awards)';
}


}

/// @nodoc
abstract mixin class _$MyPlanetCopyWith<$Res> implements $MyPlanetCopyWith<$Res> {
  factory _$MyPlanetCopyWith(_MyPlanet value, $Res Function(_MyPlanet) _then) = __$MyPlanetCopyWithImpl;
@override @useResult
$Res call({
 String name, PlanetAppearance appearance, int level, int xp, int xpForNextLevel, int bestStreakDays, Mood mood, List<Award> awards
});


@override $PlanetAppearanceCopyWith<$Res> get appearance;

}
/// @nodoc
class __$MyPlanetCopyWithImpl<$Res>
    implements _$MyPlanetCopyWith<$Res> {
  __$MyPlanetCopyWithImpl(this._self, this._then);

  final _MyPlanet _self;
  final $Res Function(_MyPlanet) _then;

/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? appearance = null,Object? level = null,Object? xp = null,Object? xpForNextLevel = null,Object? bestStreakDays = null,Object? mood = null,Object? awards = null,}) {
  return _then(_MyPlanet(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearance,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,xpForNextLevel: null == xpForNextLevel ? _self.xpForNextLevel : xpForNextLevel // ignore: cast_nullable_to_non_nullable
as int,bestStreakDays: null == bestStreakDays ? _self.bestStreakDays : bestStreakDays // ignore: cast_nullable_to_non_nullable
as int,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,awards: null == awards ? _self._awards : awards // ignore: cast_nullable_to_non_nullable
as List<Award>,
  ));
}

/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}

// dart format on
