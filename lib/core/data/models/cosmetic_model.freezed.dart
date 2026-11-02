// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cosmetic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CosmeticModel {

 String get id; String get title; String get kind;@JsonKey(unknownEnumValue: Rarity.common) Rarity get rarity; Map<String, Object?> get params; bool get equipped;
/// Create a copy of CosmeticModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CosmeticModelCopyWith<CosmeticModel> get copyWith => _$CosmeticModelCopyWithImpl<CosmeticModel>(this as CosmeticModel, _$identity);

  /// Serializes this CosmeticModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CosmeticModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CosmeticModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.rarity, _this.rarity) || other.rarity == _this.rarity)&&const DeepCollectionEquality().equals(other.params, _this.params)&&(identical(other.equipped, _this.equipped) || other.equipped == _this.equipped));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CosmeticModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.kind,_this.rarity,const DeepCollectionEquality().hash(_this.params),_this.equipped);
}

@override
String toString() {
  final _this = this as CosmeticModel;
  return 'CosmeticModel(id: ${_this.id}, title: ${_this.title}, kind: ${_this.kind}, rarity: ${_this.rarity}, params: ${_this.params}, equipped: ${_this.equipped})';
}


}

/// @nodoc
abstract mixin class $CosmeticModelCopyWith<$Res>  {
  factory $CosmeticModelCopyWith(CosmeticModel value, $Res Function(CosmeticModel) _then) = _$CosmeticModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String kind,@JsonKey(unknownEnumValue: Rarity.common) Rarity rarity, Map<String, Object?> params, bool equipped
});




}
/// @nodoc
class _$CosmeticModelCopyWithImpl<$Res>
    implements $CosmeticModelCopyWith<$Res> {
  _$CosmeticModelCopyWithImpl(this._self, this._then);

  final CosmeticModel _self;
  final $Res Function(CosmeticModel) _then;

/// Create a copy of CosmeticModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? rarity = null,Object? params = null,Object? equipped = null,}) {
  return _then(CosmeticModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as Rarity,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,equipped: null == equipped ? _self.equipped : equipped // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CosmeticModel].
extension CosmeticModelPatterns on CosmeticModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CosmeticModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CosmeticModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CosmeticModel value)  $default,){
final _that = this;
switch (_that) {
case _CosmeticModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CosmeticModel value)?  $default,){
final _that = this;
switch (_that) {
case _CosmeticModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String kind, @JsonKey(unknownEnumValue: Rarity.common)  Rarity rarity,  Map<String, Object?> params,  bool equipped)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CosmeticModel() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.rarity,_that.params,_that.equipped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String kind, @JsonKey(unknownEnumValue: Rarity.common)  Rarity rarity,  Map<String, Object?> params,  bool equipped)  $default,) {final _that = this;
switch (_that) {
case _CosmeticModel():
return $default(_that.id,_that.title,_that.kind,_that.rarity,_that.params,_that.equipped);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String kind, @JsonKey(unknownEnumValue: Rarity.common)  Rarity rarity,  Map<String, Object?> params,  bool equipped)?  $default,) {final _that = this;
switch (_that) {
case _CosmeticModel() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.rarity,_that.params,_that.equipped);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CosmeticModel implements CosmeticModel {
  const _CosmeticModel({required this.id, required this.title, required this.kind, @JsonKey(unknownEnumValue: Rarity.common) this.rarity = Rarity.common,  Map<String, Object?> params = const <String, Object?>{}, this.equipped = false}): _params = params;
  factory _CosmeticModel.fromJson(Map<String, dynamic> json) => _$CosmeticModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String kind;
@override@JsonKey(unknownEnumValue: Rarity.common) final  Rarity rarity;
 final  Map<String, Object?> _params;
@override@JsonKey() Map<String, Object?> get params {
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_params);
}

@override@JsonKey() final  bool equipped;

/// Create a copy of CosmeticModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CosmeticModelCopyWith<_CosmeticModel> get copyWith => __$CosmeticModelCopyWithImpl<_CosmeticModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CosmeticModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CosmeticModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&const DeepCollectionEquality().equals(other.params, _params)&&(identical(other.equipped, equipped) || other.equipped == equipped));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,kind,rarity,const DeepCollectionEquality().hash(_params),equipped);
}

@override
String toString() {
    return 'CosmeticModel(id: $id, title: $title, kind: $kind, rarity: $rarity, params: $params, equipped: $equipped)';
}


}

/// @nodoc
abstract mixin class _$CosmeticModelCopyWith<$Res> implements $CosmeticModelCopyWith<$Res> {
  factory _$CosmeticModelCopyWith(_CosmeticModel value, $Res Function(_CosmeticModel) _then) = __$CosmeticModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String kind,@JsonKey(unknownEnumValue: Rarity.common) Rarity rarity, Map<String, Object?> params, bool equipped
});




}
/// @nodoc
class __$CosmeticModelCopyWithImpl<$Res>
    implements _$CosmeticModelCopyWith<$Res> {
  __$CosmeticModelCopyWithImpl(this._self, this._then);

  final _CosmeticModel _self;
  final $Res Function(_CosmeticModel) _then;

/// Create a copy of CosmeticModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? rarity = null,Object? params = null,Object? equipped = null,}) {
  return _then(_CosmeticModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as Rarity,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,equipped: null == equipped ? _self.equipped : equipped // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
