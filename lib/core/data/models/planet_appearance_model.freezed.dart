// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planet_appearance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanetAppearanceModel {

 PlanetType get type; int get seed; double get hue; int get moons; bool get hasRings; bool get glows;
/// Create a copy of PlanetAppearanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanetAppearanceModelCopyWith<PlanetAppearanceModel> get copyWith => _$PlanetAppearanceModelCopyWithImpl<PlanetAppearanceModel>(this as PlanetAppearanceModel, _$identity);

  /// Serializes this PlanetAppearanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlanetAppearanceModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanetAppearanceModel&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.seed, _this.seed) || other.seed == _this.seed)&&(identical(other.hue, _this.hue) || other.hue == _this.hue)&&(identical(other.moons, _this.moons) || other.moons == _this.moons)&&(identical(other.hasRings, _this.hasRings) || other.hasRings == _this.hasRings)&&(identical(other.glows, _this.glows) || other.glows == _this.glows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlanetAppearanceModel;
  return Object.hash(runtimeType,_this.type,_this.seed,_this.hue,_this.moons,_this.hasRings,_this.glows);
}

@override
String toString() {
  final _this = this as PlanetAppearanceModel;
  return 'PlanetAppearanceModel(type: ${_this.type}, seed: ${_this.seed}, hue: ${_this.hue}, moons: ${_this.moons}, hasRings: ${_this.hasRings}, glows: ${_this.glows})';
}


}

/// @nodoc
abstract mixin class $PlanetAppearanceModelCopyWith<$Res>  {
  factory $PlanetAppearanceModelCopyWith(PlanetAppearanceModel value, $Res Function(PlanetAppearanceModel) _then) = _$PlanetAppearanceModelCopyWithImpl;
@useResult
$Res call({
 PlanetType type, int seed, double hue, int moons, bool hasRings, bool glows
});




}
/// @nodoc
class _$PlanetAppearanceModelCopyWithImpl<$Res>
    implements $PlanetAppearanceModelCopyWith<$Res> {
  _$PlanetAppearanceModelCopyWithImpl(this._self, this._then);

  final PlanetAppearanceModel _self;
  final $Res Function(PlanetAppearanceModel) _then;

/// Create a copy of PlanetAppearanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? seed = null,Object? hue = null,Object? moons = null,Object? hasRings = null,Object? glows = null,}) {
  return _then(PlanetAppearanceModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PlanetType,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,hue: null == hue ? _self.hue : hue // ignore: cast_nullable_to_non_nullable
as double,moons: null == moons ? _self.moons : moons // ignore: cast_nullable_to_non_nullable
as int,hasRings: null == hasRings ? _self.hasRings : hasRings // ignore: cast_nullable_to_non_nullable
as bool,glows: null == glows ? _self.glows : glows // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanetAppearanceModel].
extension PlanetAppearanceModelPatterns on PlanetAppearanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanetAppearanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanetAppearanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanetAppearanceModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanetAppearanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanetAppearanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanetAppearanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlanetType type,  int seed,  double hue,  int moons,  bool hasRings,  bool glows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanetAppearanceModel() when $default != null:
return $default(_that.type,_that.seed,_that.hue,_that.moons,_that.hasRings,_that.glows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlanetType type,  int seed,  double hue,  int moons,  bool hasRings,  bool glows)  $default,) {final _that = this;
switch (_that) {
case _PlanetAppearanceModel():
return $default(_that.type,_that.seed,_that.hue,_that.moons,_that.hasRings,_that.glows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlanetType type,  int seed,  double hue,  int moons,  bool hasRings,  bool glows)?  $default,) {final _that = this;
switch (_that) {
case _PlanetAppearanceModel() when $default != null:
return $default(_that.type,_that.seed,_that.hue,_that.moons,_that.hasRings,_that.glows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanetAppearanceModel implements PlanetAppearanceModel {
  const _PlanetAppearanceModel({required this.type, required this.seed, required this.hue, this.moons = 0, this.hasRings = false, this.glows = false});
  factory _PlanetAppearanceModel.fromJson(Map<String, dynamic> json) => _$PlanetAppearanceModelFromJson(json);

@override final  PlanetType type;
@override final  int seed;
@override final  double hue;
@override@JsonKey() final  int moons;
@override@JsonKey() final  bool hasRings;
@override@JsonKey() final  bool glows;

/// Create a copy of PlanetAppearanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanetAppearanceModelCopyWith<_PlanetAppearanceModel> get copyWith => __$PlanetAppearanceModelCopyWithImpl<_PlanetAppearanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanetAppearanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanetAppearanceModel&&(identical(other.type, type) || other.type == type)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.hue, hue) || other.hue == hue)&&(identical(other.moons, moons) || other.moons == moons)&&(identical(other.hasRings, hasRings) || other.hasRings == hasRings)&&(identical(other.glows, glows) || other.glows == glows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,seed,hue,moons,hasRings,glows);
}

@override
String toString() {
    return 'PlanetAppearanceModel(type: $type, seed: $seed, hue: $hue, moons: $moons, hasRings: $hasRings, glows: $glows)';
}


}

/// @nodoc
abstract mixin class _$PlanetAppearanceModelCopyWith<$Res> implements $PlanetAppearanceModelCopyWith<$Res> {
  factory _$PlanetAppearanceModelCopyWith(_PlanetAppearanceModel value, $Res Function(_PlanetAppearanceModel) _then) = __$PlanetAppearanceModelCopyWithImpl;
@override @useResult
$Res call({
 PlanetType type, int seed, double hue, int moons, bool hasRings, bool glows
});




}
/// @nodoc
class __$PlanetAppearanceModelCopyWithImpl<$Res>
    implements _$PlanetAppearanceModelCopyWith<$Res> {
  __$PlanetAppearanceModelCopyWithImpl(this._self, this._then);

  final _PlanetAppearanceModel _self;
  final $Res Function(_PlanetAppearanceModel) _then;

/// Create a copy of PlanetAppearanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? seed = null,Object? hue = null,Object? moons = null,Object? hasRings = null,Object? glows = null,}) {
  return _then(_PlanetAppearanceModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PlanetType,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,hue: null == hue ? _self.hue : hue // ignore: cast_nullable_to_non_nullable
as double,moons: null == moons ? _self.moons : moons // ignore: cast_nullable_to_non_nullable
as int,hasRings: null == hasRings ? _self.hasRings : hasRings // ignore: cast_nullable_to_non_nullable
as bool,glows: null == glows ? _self.glows : glows // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
