// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friends_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSummaryModel {

 String get id; String get name; String get handle; PlanetAppearanceModel get appearance;
/// Create a copy of UserSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSummaryModelCopyWith<UserSummaryModel> get copyWith => _$UserSummaryModelCopyWithImpl<UserSummaryModel>(this as UserSummaryModel, _$identity);

  /// Serializes this UserSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserSummaryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSummaryModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.appearance, _this.appearance) || other.appearance == _this.appearance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserSummaryModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.handle,_this.appearance);
}

@override
String toString() {
  final _this = this as UserSummaryModel;
  return 'UserSummaryModel(id: ${_this.id}, name: ${_this.name}, handle: ${_this.handle}, appearance: ${_this.appearance})';
}


}

/// @nodoc
abstract mixin class $UserSummaryModelCopyWith<$Res>  {
  factory $UserSummaryModelCopyWith(UserSummaryModel value, $Res Function(UserSummaryModel) _then) = _$UserSummaryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String handle, PlanetAppearanceModel appearance
});


$PlanetAppearanceModelCopyWith<$Res> get appearance;

}
/// @nodoc
class _$UserSummaryModelCopyWithImpl<$Res>
    implements $UserSummaryModelCopyWith<$Res> {
  _$UserSummaryModelCopyWithImpl(this._self, this._then);

  final UserSummaryModel _self;
  final $Res Function(UserSummaryModel) _then;

/// Create a copy of UserSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? appearance = null,}) {
  return _then(UserSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearanceModel,
  ));
}
/// Create a copy of UserSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceModelCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceModelCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserSummaryModel].
extension UserSummaryModelPatterns on UserSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _UserSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String handle,  PlanetAppearanceModel appearance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSummaryModel() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.appearance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String handle,  PlanetAppearanceModel appearance)  $default,) {final _that = this;
switch (_that) {
case _UserSummaryModel():
return $default(_that.id,_that.name,_that.handle,_that.appearance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String handle,  PlanetAppearanceModel appearance)?  $default,) {final _that = this;
switch (_that) {
case _UserSummaryModel() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.appearance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSummaryModel implements UserSummaryModel {
  const _UserSummaryModel({required this.id, required this.name, required this.handle, required this.appearance});
  factory _UserSummaryModel.fromJson(Map<String, dynamic> json) => _$UserSummaryModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String handle;
@override final  PlanetAppearanceModel appearance;

/// Create a copy of UserSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSummaryModelCopyWith<_UserSummaryModel> get copyWith => __$UserSummaryModelCopyWithImpl<_UserSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.appearance, appearance) || other.appearance == appearance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,handle,appearance);
}

@override
String toString() {
    return 'UserSummaryModel(id: $id, name: $name, handle: $handle, appearance: $appearance)';
}


}

/// @nodoc
abstract mixin class _$UserSummaryModelCopyWith<$Res> implements $UserSummaryModelCopyWith<$Res> {
  factory _$UserSummaryModelCopyWith(_UserSummaryModel value, $Res Function(_UserSummaryModel) _then) = __$UserSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String handle, PlanetAppearanceModel appearance
});


@override $PlanetAppearanceModelCopyWith<$Res> get appearance;

}
/// @nodoc
class __$UserSummaryModelCopyWithImpl<$Res>
    implements _$UserSummaryModelCopyWith<$Res> {
  __$UserSummaryModelCopyWithImpl(this._self, this._then);

  final _UserSummaryModel _self;
  final $Res Function(_UserSummaryModel) _then;

/// Create a copy of UserSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? appearance = null,}) {
  return _then(_UserSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearanceModel,
  ));
}

/// Create a copy of UserSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceModelCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceModelCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}


/// @nodoc
mixin _$FriendRequestModel {

 String get id; UserSummaryModel get user; DateTime get sentAt;
/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestModelCopyWith<FriendRequestModel> get copyWith => _$FriendRequestModelCopyWithImpl<FriendRequestModel>(this as FriendRequestModel, _$identity);

  /// Serializes this FriendRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendRequestModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendRequestModel;
  return Object.hash(runtimeType,_this.id,_this.user,_this.sentAt);
}

@override
String toString() {
  final _this = this as FriendRequestModel;
  return 'FriendRequestModel(id: ${_this.id}, user: ${_this.user}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $FriendRequestModelCopyWith<$Res>  {
  factory $FriendRequestModelCopyWith(FriendRequestModel value, $Res Function(FriendRequestModel) _then) = _$FriendRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, UserSummaryModel user, DateTime sentAt
});


$UserSummaryModelCopyWith<$Res> get user;

}
/// @nodoc
class _$FriendRequestModelCopyWithImpl<$Res>
    implements $FriendRequestModelCopyWith<$Res> {
  _$FriendRequestModelCopyWithImpl(this._self, this._then);

  final FriendRequestModel _self;
  final $Res Function(FriendRequestModel) _then;

/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,Object? sentAt = null,}) {
  return _then(FriendRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserSummaryModel,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSummaryModelCopyWith<$Res> get user {
  
  return $UserSummaryModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [FriendRequestModel].
extension FriendRequestModelPatterns on FriendRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _FriendRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _FriendRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UserSummaryModel user,  DateTime sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendRequestModel() when $default != null:
return $default(_that.id,_that.user,_that.sentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UserSummaryModel user,  DateTime sentAt)  $default,) {final _that = this;
switch (_that) {
case _FriendRequestModel():
return $default(_that.id,_that.user,_that.sentAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UserSummaryModel user,  DateTime sentAt)?  $default,) {final _that = this;
switch (_that) {
case _FriendRequestModel() when $default != null:
return $default(_that.id,_that.user,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendRequestModel implements FriendRequestModel {
  const _FriendRequestModel({required this.id, required this.user, required this.sentAt});
  factory _FriendRequestModel.fromJson(Map<String, dynamic> json) => _$FriendRequestModelFromJson(json);

@override final  String id;
@override final  UserSummaryModel user;
@override final  DateTime sentAt;

/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendRequestModelCopyWith<_FriendRequestModel> get copyWith => __$FriendRequestModelCopyWithImpl<_FriendRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,user,sentAt);
}

@override
String toString() {
    return 'FriendRequestModel(id: $id, user: $user, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$FriendRequestModelCopyWith<$Res> implements $FriendRequestModelCopyWith<$Res> {
  factory _$FriendRequestModelCopyWith(_FriendRequestModel value, $Res Function(_FriendRequestModel) _then) = __$FriendRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, UserSummaryModel user, DateTime sentAt
});


@override $UserSummaryModelCopyWith<$Res> get user;

}
/// @nodoc
class __$FriendRequestModelCopyWithImpl<$Res>
    implements _$FriendRequestModelCopyWith<$Res> {
  __$FriendRequestModelCopyWithImpl(this._self, this._then);

  final _FriendRequestModel _self;
  final $Res Function(_FriendRequestModel) _then;

/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,Object? sentAt = null,}) {
  return _then(_FriendRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserSummaryModel,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSummaryModelCopyWith<$Res> get user {
  
  return $UserSummaryModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
