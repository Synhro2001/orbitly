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

 String get name; String get handle;/// The look chosen at creation: type, seed, hue.
 PlanetAppearance get baseAppearance; int get level; int get xp; int get xpForNextLevel; int get bestStreakDays; Mood get mood;/// Worn rewards.
 List<Cosmetic> get equipped; Shadow? get shadow;
/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyPlanetCopyWith<MyPlanet> get copyWith => _$MyPlanetCopyWithImpl<MyPlanet>(this as MyPlanet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MyPlanet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyPlanet&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.baseAppearance, _this.baseAppearance) || other.baseAppearance == _this.baseAppearance)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.xp, _this.xp) || other.xp == _this.xp)&&(identical(other.xpForNextLevel, _this.xpForNextLevel) || other.xpForNextLevel == _this.xpForNextLevel)&&(identical(other.bestStreakDays, _this.bestStreakDays) || other.bestStreakDays == _this.bestStreakDays)&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&const DeepCollectionEquality().equals(other.equipped, _this.equipped)&&(identical(other.shadow, _this.shadow) || other.shadow == _this.shadow));
}


@override
int get hashCode {
  final _this = this as MyPlanet;
  return Object.hash(runtimeType,_this.name,_this.handle,_this.baseAppearance,_this.level,_this.xp,_this.xpForNextLevel,_this.bestStreakDays,_this.mood,const DeepCollectionEquality().hash(_this.equipped),_this.shadow);
}

@override
String toString() {
  final _this = this as MyPlanet;
  return 'MyPlanet(name: ${_this.name}, handle: ${_this.handle}, baseAppearance: ${_this.baseAppearance}, level: ${_this.level}, xp: ${_this.xp}, xpForNextLevel: ${_this.xpForNextLevel}, bestStreakDays: ${_this.bestStreakDays}, mood: ${_this.mood}, equipped: ${_this.equipped}, shadow: ${_this.shadow})';
}


}

/// @nodoc
abstract mixin class $MyPlanetCopyWith<$Res>  {
  factory $MyPlanetCopyWith(MyPlanet value, $Res Function(MyPlanet) _then) = _$MyPlanetCopyWithImpl;
@useResult
$Res call({
 String name, String handle, PlanetAppearance baseAppearance, int level, int xp, int xpForNextLevel, int bestStreakDays, Mood mood, List<Cosmetic> equipped, Shadow? shadow
});


$PlanetAppearanceCopyWith<$Res> get baseAppearance;$ShadowCopyWith<$Res>? get shadow;

}
/// @nodoc
class _$MyPlanetCopyWithImpl<$Res>
    implements $MyPlanetCopyWith<$Res> {
  _$MyPlanetCopyWithImpl(this._self, this._then);

  final MyPlanet _self;
  final $Res Function(MyPlanet) _then;

/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? handle = null,Object? baseAppearance = null,Object? level = null,Object? xp = null,Object? xpForNextLevel = null,Object? bestStreakDays = null,Object? mood = null,Object? equipped = null,Object? shadow = freezed,}) {
  return _then(MyPlanet(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,baseAppearance: null == baseAppearance ? _self.baseAppearance : baseAppearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearance,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,xpForNextLevel: null == xpForNextLevel ? _self.xpForNextLevel : xpForNextLevel // ignore: cast_nullable_to_non_nullable
as int,bestStreakDays: null == bestStreakDays ? _self.bestStreakDays : bestStreakDays // ignore: cast_nullable_to_non_nullable
as int,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,equipped: null == equipped ? _self.equipped : equipped // ignore: cast_nullable_to_non_nullable
as List<Cosmetic>,shadow: freezed == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as Shadow?,
  ));
}
/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<$Res> get baseAppearance {
  
  return $PlanetAppearanceCopyWith<$Res>(_self.baseAppearance, (value) {
    return _then(_self.copyWith(baseAppearance: value));
  });
}/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShadowCopyWith<$Res>? get shadow {
    if (_self.shadow == null) {
    return null;
  }

  return $ShadowCopyWith<$Res>(_self.shadow!, (value) {
    return _then(_self.copyWith(shadow: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String handle,  PlanetAppearance baseAppearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  List<Cosmetic> equipped,  Shadow? shadow)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyPlanet() when $default != null:
return $default(_that.name,_that.handle,_that.baseAppearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.equipped,_that.shadow);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String handle,  PlanetAppearance baseAppearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  List<Cosmetic> equipped,  Shadow? shadow)  $default,) {final _that = this;
switch (_that) {
case _MyPlanet():
return $default(_that.name,_that.handle,_that.baseAppearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.equipped,_that.shadow);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String handle,  PlanetAppearance baseAppearance,  int level,  int xp,  int xpForNextLevel,  int bestStreakDays,  Mood mood,  List<Cosmetic> equipped,  Shadow? shadow)?  $default,) {final _that = this;
switch (_that) {
case _MyPlanet() when $default != null:
return $default(_that.name,_that.handle,_that.baseAppearance,_that.level,_that.xp,_that.xpForNextLevel,_that.bestStreakDays,_that.mood,_that.equipped,_that.shadow);case _:
  return null;

}
}

}

/// @nodoc


class _MyPlanet extends MyPlanet {
  const _MyPlanet({required this.name, required this.handle, required this.baseAppearance, required this.level, required this.xp, required this.xpForNextLevel, required this.bestStreakDays, required this.mood,  List<Cosmetic> equipped = const [], this.shadow}): _equipped = equipped,super._();
  

@override final  String name;
@override final  String handle;
/// The look chosen at creation: type, seed, hue.
@override final  PlanetAppearance baseAppearance;
@override final  int level;
@override final  int xp;
@override final  int xpForNextLevel;
@override final  int bestStreakDays;
@override final  Mood mood;
/// Worn rewards.
 final  List<Cosmetic> _equipped;
/// Worn rewards.
@override@JsonKey() List<Cosmetic> get equipped {
  if (_equipped is EqualUnmodifiableListView) return _equipped;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipped);
}

@override final  Shadow? shadow;

/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyPlanetCopyWith<_MyPlanet> get copyWith => __$MyPlanetCopyWithImpl<_MyPlanet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyPlanet&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.baseAppearance, baseAppearance) || other.baseAppearance == baseAppearance)&&(identical(other.level, level) || other.level == level)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.xpForNextLevel, xpForNextLevel) || other.xpForNextLevel == xpForNextLevel)&&(identical(other.bestStreakDays, bestStreakDays) || other.bestStreakDays == bestStreakDays)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other.equipped, _equipped)&&(identical(other.shadow, shadow) || other.shadow == shadow));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,handle,baseAppearance,level,xp,xpForNextLevel,bestStreakDays,mood,const DeepCollectionEquality().hash(_equipped),shadow);
}

@override
String toString() {
    return 'MyPlanet(name: $name, handle: $handle, baseAppearance: $baseAppearance, level: $level, xp: $xp, xpForNextLevel: $xpForNextLevel, bestStreakDays: $bestStreakDays, mood: $mood, equipped: $equipped, shadow: $shadow)';
}


}

/// @nodoc
abstract mixin class _$MyPlanetCopyWith<$Res> implements $MyPlanetCopyWith<$Res> {
  factory _$MyPlanetCopyWith(_MyPlanet value, $Res Function(_MyPlanet) _then) = __$MyPlanetCopyWithImpl;
@override @useResult
$Res call({
 String name, String handle, PlanetAppearance baseAppearance, int level, int xp, int xpForNextLevel, int bestStreakDays, Mood mood, List<Cosmetic> equipped, Shadow? shadow
});


@override $PlanetAppearanceCopyWith<$Res> get baseAppearance;@override $ShadowCopyWith<$Res>? get shadow;

}
/// @nodoc
class __$MyPlanetCopyWithImpl<$Res>
    implements _$MyPlanetCopyWith<$Res> {
  __$MyPlanetCopyWithImpl(this._self, this._then);

  final _MyPlanet _self;
  final $Res Function(_MyPlanet) _then;

/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? handle = null,Object? baseAppearance = null,Object? level = null,Object? xp = null,Object? xpForNextLevel = null,Object? bestStreakDays = null,Object? mood = null,Object? equipped = null,Object? shadow = freezed,}) {
  return _then(_MyPlanet(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,baseAppearance: null == baseAppearance ? _self.baseAppearance : baseAppearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearance,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,xpForNextLevel: null == xpForNextLevel ? _self.xpForNextLevel : xpForNextLevel // ignore: cast_nullable_to_non_nullable
as int,bestStreakDays: null == bestStreakDays ? _self.bestStreakDays : bestStreakDays // ignore: cast_nullable_to_non_nullable
as int,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,equipped: null == equipped ? _self._equipped : equipped // ignore: cast_nullable_to_non_nullable
as List<Cosmetic>,shadow: freezed == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as Shadow?,
  ));
}

/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<$Res> get baseAppearance {
  
  return $PlanetAppearanceCopyWith<$Res>(_self.baseAppearance, (value) {
    return _then(_self.copyWith(baseAppearance: value));
  });
}/// Create a copy of MyPlanet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShadowCopyWith<$Res>? get shadow {
    if (_self.shadow == null) {
    return null;
  }

  return $ShadowCopyWith<$Res>(_self.shadow!, (value) {
    return _then(_self.copyWith(shadow: value));
  });
}
}

// dart format on
