// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendModel {

 String get id; String get name; String get handle; PlanetAppearanceModel get appearance; int get closeness; int get streakDays; DateTime get lastExchangeAt; bool get hasUnreadSnaps;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Mood? get mood; DateTime? get shadowFrom; DateTime? get shadowUntil; List<AwardModel> get trophies;
/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendModelCopyWith<FriendModel> get copyWith => _$FriendModelCopyWithImpl<FriendModel>(this as FriendModel, _$identity);

  /// Serializes this FriendModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.appearance, _this.appearance) || other.appearance == _this.appearance)&&(identical(other.closeness, _this.closeness) || other.closeness == _this.closeness)&&(identical(other.streakDays, _this.streakDays) || other.streakDays == _this.streakDays)&&(identical(other.lastExchangeAt, _this.lastExchangeAt) || other.lastExchangeAt == _this.lastExchangeAt)&&(identical(other.hasUnreadSnaps, _this.hasUnreadSnaps) || other.hasUnreadSnaps == _this.hasUnreadSnaps)&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&(identical(other.shadowFrom, _this.shadowFrom) || other.shadowFrom == _this.shadowFrom)&&(identical(other.shadowUntil, _this.shadowUntil) || other.shadowUntil == _this.shadowUntil)&&const DeepCollectionEquality().equals(other.trophies, _this.trophies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.handle,_this.appearance,_this.closeness,_this.streakDays,_this.lastExchangeAt,_this.hasUnreadSnaps,_this.mood,_this.shadowFrom,_this.shadowUntil,const DeepCollectionEquality().hash(_this.trophies));
}

@override
String toString() {
  final _this = this as FriendModel;
  return 'FriendModel(id: ${_this.id}, name: ${_this.name}, handle: ${_this.handle}, appearance: ${_this.appearance}, closeness: ${_this.closeness}, streakDays: ${_this.streakDays}, lastExchangeAt: ${_this.lastExchangeAt}, hasUnreadSnaps: ${_this.hasUnreadSnaps}, mood: ${_this.mood}, shadowFrom: ${_this.shadowFrom}, shadowUntil: ${_this.shadowUntil}, trophies: ${_this.trophies})';
}


}

/// @nodoc
abstract mixin class $FriendModelCopyWith<$Res>  {
  factory $FriendModelCopyWith(FriendModel value, $Res Function(FriendModel) _then) = _$FriendModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String handle, PlanetAppearanceModel appearance, int closeness, int streakDays, DateTime lastExchangeAt, bool hasUnreadSnaps,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Mood? mood, DateTime? shadowFrom, DateTime? shadowUntil, List<AwardModel> trophies
});


$PlanetAppearanceModelCopyWith<$Res> get appearance;

}
/// @nodoc
class _$FriendModelCopyWithImpl<$Res>
    implements $FriendModelCopyWith<$Res> {
  _$FriendModelCopyWithImpl(this._self, this._then);

  final FriendModel _self;
  final $Res Function(FriendModel) _then;

/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? appearance = null,Object? closeness = null,Object? streakDays = null,Object? lastExchangeAt = null,Object? hasUnreadSnaps = null,Object? mood = freezed,Object? shadowFrom = freezed,Object? shadowUntil = freezed,Object? trophies = null,}) {
  return _then(FriendModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearanceModel,closeness: null == closeness ? _self.closeness : closeness // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,lastExchangeAt: null == lastExchangeAt ? _self.lastExchangeAt : lastExchangeAt // ignore: cast_nullable_to_non_nullable
as DateTime,hasUnreadSnaps: null == hasUnreadSnaps ? _self.hasUnreadSnaps : hasUnreadSnaps // ignore: cast_nullable_to_non_nullable
as bool,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood?,shadowFrom: freezed == shadowFrom ? _self.shadowFrom : shadowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,shadowUntil: freezed == shadowUntil ? _self.shadowUntil : shadowUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,trophies: null == trophies ? _self.trophies : trophies // ignore: cast_nullable_to_non_nullable
as List<AwardModel>,
  ));
}
/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceModelCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceModelCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}


/// Adds pattern-matching-related methods to [FriendModel].
extension FriendModelPatterns on FriendModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendModel value)  $default,){
final _that = this;
switch (_that) {
case _FriendModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendModel value)?  $default,){
final _that = this;
switch (_that) {
case _FriendModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String handle,  PlanetAppearanceModel appearance,  int closeness,  int streakDays,  DateTime lastExchangeAt,  bool hasUnreadSnaps, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  Mood? mood,  DateTime? shadowFrom,  DateTime? shadowUntil,  List<AwardModel> trophies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendModel() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.appearance,_that.closeness,_that.streakDays,_that.lastExchangeAt,_that.hasUnreadSnaps,_that.mood,_that.shadowFrom,_that.shadowUntil,_that.trophies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String handle,  PlanetAppearanceModel appearance,  int closeness,  int streakDays,  DateTime lastExchangeAt,  bool hasUnreadSnaps, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  Mood? mood,  DateTime? shadowFrom,  DateTime? shadowUntil,  List<AwardModel> trophies)  $default,) {final _that = this;
switch (_that) {
case _FriendModel():
return $default(_that.id,_that.name,_that.handle,_that.appearance,_that.closeness,_that.streakDays,_that.lastExchangeAt,_that.hasUnreadSnaps,_that.mood,_that.shadowFrom,_that.shadowUntil,_that.trophies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String handle,  PlanetAppearanceModel appearance,  int closeness,  int streakDays,  DateTime lastExchangeAt,  bool hasUnreadSnaps, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  Mood? mood,  DateTime? shadowFrom,  DateTime? shadowUntil,  List<AwardModel> trophies)?  $default,) {final _that = this;
switch (_that) {
case _FriendModel() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.appearance,_that.closeness,_that.streakDays,_that.lastExchangeAt,_that.hasUnreadSnaps,_that.mood,_that.shadowFrom,_that.shadowUntil,_that.trophies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendModel implements FriendModel {
  const _FriendModel({required this.id, required this.name, required this.handle, required this.appearance, required this.closeness, required this.streakDays, required this.lastExchangeAt, required this.hasUnreadSnaps, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.mood, this.shadowFrom, this.shadowUntil,  List<AwardModel> trophies = const []}): _trophies = trophies;
  factory _FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String handle;
@override final  PlanetAppearanceModel appearance;
@override final  int closeness;
@override final  int streakDays;
@override final  DateTime lastExchangeAt;
@override final  bool hasUnreadSnaps;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  Mood? mood;
@override final  DateTime? shadowFrom;
@override final  DateTime? shadowUntil;
 final  List<AwardModel> _trophies;
@override@JsonKey() List<AwardModel> get trophies {
  if (_trophies is EqualUnmodifiableListView) return _trophies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trophies);
}


/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendModelCopyWith<_FriendModel> get copyWith => __$FriendModelCopyWithImpl<_FriendModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.appearance, appearance) || other.appearance == appearance)&&(identical(other.closeness, closeness) || other.closeness == closeness)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.lastExchangeAt, lastExchangeAt) || other.lastExchangeAt == lastExchangeAt)&&(identical(other.hasUnreadSnaps, hasUnreadSnaps) || other.hasUnreadSnaps == hasUnreadSnaps)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.shadowFrom, shadowFrom) || other.shadowFrom == shadowFrom)&&(identical(other.shadowUntil, shadowUntil) || other.shadowUntil == shadowUntil)&&const DeepCollectionEquality().equals(other.trophies, _trophies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,handle,appearance,closeness,streakDays,lastExchangeAt,hasUnreadSnaps,mood,shadowFrom,shadowUntil,const DeepCollectionEquality().hash(_trophies));
}

@override
String toString() {
    return 'FriendModel(id: $id, name: $name, handle: $handle, appearance: $appearance, closeness: $closeness, streakDays: $streakDays, lastExchangeAt: $lastExchangeAt, hasUnreadSnaps: $hasUnreadSnaps, mood: $mood, shadowFrom: $shadowFrom, shadowUntil: $shadowUntil, trophies: $trophies)';
}


}

/// @nodoc
abstract mixin class _$FriendModelCopyWith<$Res> implements $FriendModelCopyWith<$Res> {
  factory _$FriendModelCopyWith(_FriendModel value, $Res Function(_FriendModel) _then) = __$FriendModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String handle, PlanetAppearanceModel appearance, int closeness, int streakDays, DateTime lastExchangeAt, bool hasUnreadSnaps,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Mood? mood, DateTime? shadowFrom, DateTime? shadowUntil, List<AwardModel> trophies
});


@override $PlanetAppearanceModelCopyWith<$Res> get appearance;

}
/// @nodoc
class __$FriendModelCopyWithImpl<$Res>
    implements _$FriendModelCopyWith<$Res> {
  __$FriendModelCopyWithImpl(this._self, this._then);

  final _FriendModel _self;
  final $Res Function(_FriendModel) _then;

/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? appearance = null,Object? closeness = null,Object? streakDays = null,Object? lastExchangeAt = null,Object? hasUnreadSnaps = null,Object? mood = freezed,Object? shadowFrom = freezed,Object? shadowUntil = freezed,Object? trophies = null,}) {
  return _then(_FriendModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearanceModel,closeness: null == closeness ? _self.closeness : closeness // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,lastExchangeAt: null == lastExchangeAt ? _self.lastExchangeAt : lastExchangeAt // ignore: cast_nullable_to_non_nullable
as DateTime,hasUnreadSnaps: null == hasUnreadSnaps ? _self.hasUnreadSnaps : hasUnreadSnaps // ignore: cast_nullable_to_non_nullable
as bool,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood?,shadowFrom: freezed == shadowFrom ? _self.shadowFrom : shadowFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,shadowUntil: freezed == shadowUntil ? _self.shadowUntil : shadowUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,trophies: null == trophies ? _self._trophies : trophies // ignore: cast_nullable_to_non_nullable
as List<AwardModel>,
  ));
}

/// Create a copy of FriendModel
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
