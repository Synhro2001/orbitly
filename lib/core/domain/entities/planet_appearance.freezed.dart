// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planet_appearance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanetAppearance {

 PlanetType get type; int get seed;/// Основной оттенок, градусы 0–360.
 double get hue; int get moons; bool get hasRings; GlowStyle get glow; MoonSkin get moonSkin; bool get hasCometTrail;
/// Create a copy of PlanetAppearance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<PlanetAppearance> get copyWith => _$PlanetAppearanceCopyWithImpl<PlanetAppearance>(this as PlanetAppearance, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlanetAppearance;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanetAppearance&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.seed, _this.seed) || other.seed == _this.seed)&&(identical(other.hue, _this.hue) || other.hue == _this.hue)&&(identical(other.moons, _this.moons) || other.moons == _this.moons)&&(identical(other.hasRings, _this.hasRings) || other.hasRings == _this.hasRings)&&(identical(other.glow, _this.glow) || other.glow == _this.glow)&&(identical(other.moonSkin, _this.moonSkin) || other.moonSkin == _this.moonSkin)&&(identical(other.hasCometTrail, _this.hasCometTrail) || other.hasCometTrail == _this.hasCometTrail));
}


@override
int get hashCode {
  final _this = this as PlanetAppearance;
  return Object.hash(runtimeType,_this.type,_this.seed,_this.hue,_this.moons,_this.hasRings,_this.glow,_this.moonSkin,_this.hasCometTrail);
}

@override
String toString() {
  final _this = this as PlanetAppearance;
  return 'PlanetAppearance(type: ${_this.type}, seed: ${_this.seed}, hue: ${_this.hue}, moons: ${_this.moons}, hasRings: ${_this.hasRings}, glow: ${_this.glow}, moonSkin: ${_this.moonSkin}, hasCometTrail: ${_this.hasCometTrail})';
}


}

/// @nodoc
abstract mixin class $PlanetAppearanceCopyWith<$Res>  {
  factory $PlanetAppearanceCopyWith(PlanetAppearance value, $Res Function(PlanetAppearance) _then) = _$PlanetAppearanceCopyWithImpl;
@useResult
$Res call({
 PlanetType type, int seed, double hue, int moons, bool hasRings, GlowStyle glow, MoonSkin moonSkin, bool hasCometTrail
});




}
/// @nodoc
class _$PlanetAppearanceCopyWithImpl<$Res>
    implements $PlanetAppearanceCopyWith<$Res> {
  _$PlanetAppearanceCopyWithImpl(this._self, this._then);

  final PlanetAppearance _self;
  final $Res Function(PlanetAppearance) _then;

/// Create a copy of PlanetAppearance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? seed = null,Object? hue = null,Object? moons = null,Object? hasRings = null,Object? glow = null,Object? moonSkin = null,Object? hasCometTrail = null,}) {
  return _then(PlanetAppearance(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PlanetType,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,hue: null == hue ? _self.hue : hue // ignore: cast_nullable_to_non_nullable
as double,moons: null == moons ? _self.moons : moons // ignore: cast_nullable_to_non_nullable
as int,hasRings: null == hasRings ? _self.hasRings : hasRings // ignore: cast_nullable_to_non_nullable
as bool,glow: null == glow ? _self.glow : glow // ignore: cast_nullable_to_non_nullable
as GlowStyle,moonSkin: null == moonSkin ? _self.moonSkin : moonSkin // ignore: cast_nullable_to_non_nullable
as MoonSkin,hasCometTrail: null == hasCometTrail ? _self.hasCometTrail : hasCometTrail // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanetAppearance].
extension PlanetAppearancePatterns on PlanetAppearance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanetAppearance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanetAppearance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanetAppearance value)  $default,){
final _that = this;
switch (_that) {
case _PlanetAppearance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanetAppearance value)?  $default,){
final _that = this;
switch (_that) {
case _PlanetAppearance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlanetType type,  int seed,  double hue,  int moons,  bool hasRings,  GlowStyle glow,  MoonSkin moonSkin,  bool hasCometTrail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanetAppearance() when $default != null:
return $default(_that.type,_that.seed,_that.hue,_that.moons,_that.hasRings,_that.glow,_that.moonSkin,_that.hasCometTrail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlanetType type,  int seed,  double hue,  int moons,  bool hasRings,  GlowStyle glow,  MoonSkin moonSkin,  bool hasCometTrail)  $default,) {final _that = this;
switch (_that) {
case _PlanetAppearance():
return $default(_that.type,_that.seed,_that.hue,_that.moons,_that.hasRings,_that.glow,_that.moonSkin,_that.hasCometTrail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlanetType type,  int seed,  double hue,  int moons,  bool hasRings,  GlowStyle glow,  MoonSkin moonSkin,  bool hasCometTrail)?  $default,) {final _that = this;
switch (_that) {
case _PlanetAppearance() when $default != null:
return $default(_that.type,_that.seed,_that.hue,_that.moons,_that.hasRings,_that.glow,_that.moonSkin,_that.hasCometTrail);case _:
  return null;

}
}

}

/// @nodoc


class _PlanetAppearance implements PlanetAppearance {
  const _PlanetAppearance({required this.type, required this.seed, required this.hue, this.moons = 0, this.hasRings = false, this.glow = GlowStyle.none, this.moonSkin = MoonSkin.plain, this.hasCometTrail = false});
  

@override final  PlanetType type;
@override final  int seed;
/// Основной оттенок, градусы 0–360.
@override final  double hue;
@override@JsonKey() final  int moons;
@override@JsonKey() final  bool hasRings;
@override@JsonKey() final  GlowStyle glow;
@override@JsonKey() final  MoonSkin moonSkin;
@override@JsonKey() final  bool hasCometTrail;

/// Create a copy of PlanetAppearance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanetAppearanceCopyWith<_PlanetAppearance> get copyWith => __$PlanetAppearanceCopyWithImpl<_PlanetAppearance>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanetAppearance&&(identical(other.type, type) || other.type == type)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.hue, hue) || other.hue == hue)&&(identical(other.moons, moons) || other.moons == moons)&&(identical(other.hasRings, hasRings) || other.hasRings == hasRings)&&(identical(other.glow, glow) || other.glow == glow)&&(identical(other.moonSkin, moonSkin) || other.moonSkin == moonSkin)&&(identical(other.hasCometTrail, hasCometTrail) || other.hasCometTrail == hasCometTrail));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,seed,hue,moons,hasRings,glow,moonSkin,hasCometTrail);
}

@override
String toString() {
    return 'PlanetAppearance(type: $type, seed: $seed, hue: $hue, moons: $moons, hasRings: $hasRings, glow: $glow, moonSkin: $moonSkin, hasCometTrail: $hasCometTrail)';
}


}

/// @nodoc
abstract mixin class _$PlanetAppearanceCopyWith<$Res> implements $PlanetAppearanceCopyWith<$Res> {
  factory _$PlanetAppearanceCopyWith(_PlanetAppearance value, $Res Function(_PlanetAppearance) _then) = __$PlanetAppearanceCopyWithImpl;
@override @useResult
$Res call({
 PlanetType type, int seed, double hue, int moons, bool hasRings, GlowStyle glow, MoonSkin moonSkin, bool hasCometTrail
});




}
/// @nodoc
class __$PlanetAppearanceCopyWithImpl<$Res>
    implements _$PlanetAppearanceCopyWith<$Res> {
  __$PlanetAppearanceCopyWithImpl(this._self, this._then);

  final _PlanetAppearance _self;
  final $Res Function(_PlanetAppearance) _then;

/// Create a copy of PlanetAppearance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? seed = null,Object? hue = null,Object? moons = null,Object? hasRings = null,Object? glow = null,Object? moonSkin = null,Object? hasCometTrail = null,}) {
  return _then(_PlanetAppearance(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PlanetType,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,hue: null == hue ? _self.hue : hue // ignore: cast_nullable_to_non_nullable
as double,moons: null == moons ? _self.moons : moons // ignore: cast_nullable_to_non_nullable
as int,hasRings: null == hasRings ? _self.hasRings : hasRings // ignore: cast_nullable_to_non_nullable
as bool,glow: null == glow ? _self.glow : glow // ignore: cast_nullable_to_non_nullable
as GlowStyle,moonSkin: null == moonSkin ? _self.moonSkin : moonSkin // ignore: cast_nullable_to_non_nullable
as MoonSkin,hasCometTrail: null == hasCometTrail ? _self.hasCometTrail : hasCometTrail // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
