// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friends_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSummary {

 String get id; String get name; String get handle; PlanetAppearance get appearance;
/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSummaryCopyWith<UserSummary> get copyWith => _$UserSummaryCopyWithImpl<UserSummary>(this as UserSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.appearance, _this.appearance) || other.appearance == _this.appearance));
}


@override
int get hashCode {
  final _this = this as UserSummary;
  return Object.hash(runtimeType,_this.id,_this.name,_this.handle,_this.appearance);
}

@override
String toString() {
  final _this = this as UserSummary;
  return 'UserSummary(id: ${_this.id}, name: ${_this.name}, handle: ${_this.handle}, appearance: ${_this.appearance})';
}


}

/// @nodoc
abstract mixin class $UserSummaryCopyWith<$Res>  {
  factory $UserSummaryCopyWith(UserSummary value, $Res Function(UserSummary) _then) = _$UserSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String handle, PlanetAppearance appearance
});


$PlanetAppearanceCopyWith<$Res> get appearance;

}
/// @nodoc
class _$UserSummaryCopyWithImpl<$Res>
    implements $UserSummaryCopyWith<$Res> {
  _$UserSummaryCopyWithImpl(this._self, this._then);

  final UserSummary _self;
  final $Res Function(UserSummary) _then;

/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? appearance = null,}) {
  return _then(UserSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearance,
  ));
}
/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserSummary].
extension UserSummaryPatterns on UserSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSummary value)  $default,){
final _that = this;
switch (_that) {
case _UserSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSummary value)?  $default,){
final _that = this;
switch (_that) {
case _UserSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String handle,  PlanetAppearance appearance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSummary() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String handle,  PlanetAppearance appearance)  $default,) {final _that = this;
switch (_that) {
case _UserSummary():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String handle,  PlanetAppearance appearance)?  $default,) {final _that = this;
switch (_that) {
case _UserSummary() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.appearance);case _:
  return null;

}
}

}

/// @nodoc


class _UserSummary implements UserSummary {
  const _UserSummary({required this.id, required this.name, required this.handle, required this.appearance});
  

@override final  String id;
@override final  String name;
@override final  String handle;
@override final  PlanetAppearance appearance;

/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSummaryCopyWith<_UserSummary> get copyWith => __$UserSummaryCopyWithImpl<_UserSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.appearance, appearance) || other.appearance == appearance));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,handle,appearance);
}

@override
String toString() {
    return 'UserSummary(id: $id, name: $name, handle: $handle, appearance: $appearance)';
}


}

/// @nodoc
abstract mixin class _$UserSummaryCopyWith<$Res> implements $UserSummaryCopyWith<$Res> {
  factory _$UserSummaryCopyWith(_UserSummary value, $Res Function(_UserSummary) _then) = __$UserSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String handle, PlanetAppearance appearance
});


@override $PlanetAppearanceCopyWith<$Res> get appearance;

}
/// @nodoc
class __$UserSummaryCopyWithImpl<$Res>
    implements _$UserSummaryCopyWith<$Res> {
  __$UserSummaryCopyWithImpl(this._self, this._then);

  final _UserSummary _self;
  final $Res Function(_UserSummary) _then;

/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? appearance = null,}) {
  return _then(_UserSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearance,
  ));
}

/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}
}

/// @nodoc
mixin _$FriendRequest {

 String get id; UserSummary get from; DateTime get sentAt;
/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestCopyWith<FriendRequest> get copyWith => _$FriendRequestCopyWithImpl<FriendRequest>(this as FriendRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FriendRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}


@override
int get hashCode {
  final _this = this as FriendRequest;
  return Object.hash(runtimeType,_this.id,_this.from,_this.sentAt);
}

@override
String toString() {
  final _this = this as FriendRequest;
  return 'FriendRequest(id: ${_this.id}, from: ${_this.from}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $FriendRequestCopyWith<$Res>  {
  factory $FriendRequestCopyWith(FriendRequest value, $Res Function(FriendRequest) _then) = _$FriendRequestCopyWithImpl;
@useResult
$Res call({
 String id, UserSummary from, DateTime sentAt
});


$UserSummaryCopyWith<$Res> get from;

}
/// @nodoc
class _$FriendRequestCopyWithImpl<$Res>
    implements $FriendRequestCopyWith<$Res> {
  _$FriendRequestCopyWithImpl(this._self, this._then);

  final FriendRequest _self;
  final $Res Function(FriendRequest) _then;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? from = null,Object? sentAt = null,}) {
  return _then(FriendRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as UserSummary,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSummaryCopyWith<$Res> get from {
  
  return $UserSummaryCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}
}


/// Adds pattern-matching-related methods to [FriendRequest].
extension FriendRequestPatterns on FriendRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendRequest value)  $default,){
final _that = this;
switch (_that) {
case _FriendRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UserSummary from,  DateTime sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
return $default(_that.id,_that.from,_that.sentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UserSummary from,  DateTime sentAt)  $default,) {final _that = this;
switch (_that) {
case _FriendRequest():
return $default(_that.id,_that.from,_that.sentAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UserSummary from,  DateTime sentAt)?  $default,) {final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
return $default(_that.id,_that.from,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc


class _FriendRequest implements FriendRequest {
  const _FriendRequest({required this.id, required this.from, required this.sentAt});
  

@override final  String id;
@override final  UserSummary from;
@override final  DateTime sentAt;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendRequestCopyWith<_FriendRequest> get copyWith => __$FriendRequestCopyWithImpl<_FriendRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.from, from) || other.from == from)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,from,sentAt);
}

@override
String toString() {
    return 'FriendRequest(id: $id, from: $from, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$FriendRequestCopyWith<$Res> implements $FriendRequestCopyWith<$Res> {
  factory _$FriendRequestCopyWith(_FriendRequest value, $Res Function(_FriendRequest) _then) = __$FriendRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, UserSummary from, DateTime sentAt
});


@override $UserSummaryCopyWith<$Res> get from;

}
/// @nodoc
class __$FriendRequestCopyWithImpl<$Res>
    implements _$FriendRequestCopyWith<$Res> {
  __$FriendRequestCopyWithImpl(this._self, this._then);

  final _FriendRequest _self;
  final $Res Function(_FriendRequest) _then;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? from = null,Object? sentAt = null,}) {
  return _then(_FriendRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as UserSummary,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSummaryCopyWith<$Res> get from {
  
  return $UserSummaryCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}
}

// dart format on
