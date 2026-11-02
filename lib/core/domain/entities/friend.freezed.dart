// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Friend {

 String get id; String get name; String get handle; PlanetAppearance get appearance;/// Closeness, 0–100. The higher it is, the closer the orbit.
 int get closeness; Streak get streak;/// Null when the friend does not share it with me.
 Mood? get mood; bool get hasUnreadSnaps;/// Set when the friend is in shadow (or has scheduled one).
 Shadow? get shadow;/// Trophies we earned together.
 List<Award> get sharedTrophies;
/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendCopyWith<Friend> get copyWith => _$FriendCopyWithImpl<Friend>(this as Friend, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Friend;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Friend&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.appearance, _this.appearance) || other.appearance == _this.appearance)&&(identical(other.closeness, _this.closeness) || other.closeness == _this.closeness)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&(identical(other.hasUnreadSnaps, _this.hasUnreadSnaps) || other.hasUnreadSnaps == _this.hasUnreadSnaps)&&(identical(other.shadow, _this.shadow) || other.shadow == _this.shadow)&&const DeepCollectionEquality().equals(other.sharedTrophies, _this.sharedTrophies));
}


@override
int get hashCode {
  final _this = this as Friend;
  return Object.hash(runtimeType,_this.id,_this.name,_this.handle,_this.appearance,_this.closeness,_this.streak,_this.mood,_this.hasUnreadSnaps,_this.shadow,const DeepCollectionEquality().hash(_this.sharedTrophies));
}

@override
String toString() {
  final _this = this as Friend;
  return 'Friend(id: ${_this.id}, name: ${_this.name}, handle: ${_this.handle}, appearance: ${_this.appearance}, closeness: ${_this.closeness}, streak: ${_this.streak}, mood: ${_this.mood}, hasUnreadSnaps: ${_this.hasUnreadSnaps}, shadow: ${_this.shadow}, sharedTrophies: ${_this.sharedTrophies})';
}


}

/// @nodoc
abstract mixin class $FriendCopyWith<$Res>  {
  factory $FriendCopyWith(Friend value, $Res Function(Friend) _then) = _$FriendCopyWithImpl;
@useResult
$Res call({
 String id, String name, String handle, PlanetAppearance appearance, int closeness, Streak streak, Mood? mood, bool hasUnreadSnaps, Shadow? shadow, List<Award> sharedTrophies
});


$PlanetAppearanceCopyWith<$Res> get appearance;$StreakCopyWith<$Res> get streak;$ShadowCopyWith<$Res>? get shadow;

}
/// @nodoc
class _$FriendCopyWithImpl<$Res>
    implements $FriendCopyWith<$Res> {
  _$FriendCopyWithImpl(this._self, this._then);

  final Friend _self;
  final $Res Function(Friend) _then;

/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? appearance = null,Object? closeness = null,Object? streak = null,Object? mood = freezed,Object? hasUnreadSnaps = null,Object? shadow = freezed,Object? sharedTrophies = null,}) {
  return _then(Friend(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearance,closeness: null == closeness ? _self.closeness : closeness // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as Streak,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood?,hasUnreadSnaps: null == hasUnreadSnaps ? _self.hasUnreadSnaps : hasUnreadSnaps // ignore: cast_nullable_to_non_nullable
as bool,shadow: freezed == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as Shadow?,sharedTrophies: null == sharedTrophies ? _self.sharedTrophies : sharedTrophies // ignore: cast_nullable_to_non_nullable
as List<Award>,
  ));
}
/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StreakCopyWith<$Res> get streak {
  
  return $StreakCopyWith<$Res>(_self.streak, (value) {
    return _then(_self.copyWith(streak: value));
  });
}/// Create a copy of Friend
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


/// Adds pattern-matching-related methods to [Friend].
extension FriendPatterns on Friend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Friend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Friend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Friend value)  $default,){
final _that = this;
switch (_that) {
case _Friend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Friend value)?  $default,){
final _that = this;
switch (_that) {
case _Friend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String handle,  PlanetAppearance appearance,  int closeness,  Streak streak,  Mood? mood,  bool hasUnreadSnaps,  Shadow? shadow,  List<Award> sharedTrophies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Friend() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.appearance,_that.closeness,_that.streak,_that.mood,_that.hasUnreadSnaps,_that.shadow,_that.sharedTrophies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String handle,  PlanetAppearance appearance,  int closeness,  Streak streak,  Mood? mood,  bool hasUnreadSnaps,  Shadow? shadow,  List<Award> sharedTrophies)  $default,) {final _that = this;
switch (_that) {
case _Friend():
return $default(_that.id,_that.name,_that.handle,_that.appearance,_that.closeness,_that.streak,_that.mood,_that.hasUnreadSnaps,_that.shadow,_that.sharedTrophies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String handle,  PlanetAppearance appearance,  int closeness,  Streak streak,  Mood? mood,  bool hasUnreadSnaps,  Shadow? shadow,  List<Award> sharedTrophies)?  $default,) {final _that = this;
switch (_that) {
case _Friend() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.appearance,_that.closeness,_that.streak,_that.mood,_that.hasUnreadSnaps,_that.shadow,_that.sharedTrophies);case _:
  return null;

}
}

}

/// @nodoc


class _Friend implements Friend {
  const _Friend({required this.id, required this.name, required this.handle, required this.appearance, required this.closeness, required this.streak, required this.mood, required this.hasUnreadSnaps, this.shadow,  List<Award> sharedTrophies = const []}): _sharedTrophies = sharedTrophies;
  

@override final  String id;
@override final  String name;
@override final  String handle;
@override final  PlanetAppearance appearance;
/// Closeness, 0–100. The higher it is, the closer the orbit.
@override final  int closeness;
@override final  Streak streak;
/// Null when the friend does not share it with me.
@override final  Mood? mood;
@override final  bool hasUnreadSnaps;
/// Set when the friend is in shadow (or has scheduled one).
@override final  Shadow? shadow;
/// Trophies we earned together.
 final  List<Award> _sharedTrophies;
/// Trophies we earned together.
@override@JsonKey() List<Award> get sharedTrophies {
  if (_sharedTrophies is EqualUnmodifiableListView) return _sharedTrophies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedTrophies);
}


/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendCopyWith<_Friend> get copyWith => __$FriendCopyWithImpl<_Friend>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Friend&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.appearance, appearance) || other.appearance == appearance)&&(identical(other.closeness, closeness) || other.closeness == closeness)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.hasUnreadSnaps, hasUnreadSnaps) || other.hasUnreadSnaps == hasUnreadSnaps)&&(identical(other.shadow, shadow) || other.shadow == shadow)&&const DeepCollectionEquality().equals(other.sharedTrophies, _sharedTrophies));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,handle,appearance,closeness,streak,mood,hasUnreadSnaps,shadow,const DeepCollectionEquality().hash(_sharedTrophies));
}

@override
String toString() {
    return 'Friend(id: $id, name: $name, handle: $handle, appearance: $appearance, closeness: $closeness, streak: $streak, mood: $mood, hasUnreadSnaps: $hasUnreadSnaps, shadow: $shadow, sharedTrophies: $sharedTrophies)';
}


}

/// @nodoc
abstract mixin class _$FriendCopyWith<$Res> implements $FriendCopyWith<$Res> {
  factory _$FriendCopyWith(_Friend value, $Res Function(_Friend) _then) = __$FriendCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String handle, PlanetAppearance appearance, int closeness, Streak streak, Mood? mood, bool hasUnreadSnaps, Shadow? shadow, List<Award> sharedTrophies
});


@override $PlanetAppearanceCopyWith<$Res> get appearance;@override $StreakCopyWith<$Res> get streak;@override $ShadowCopyWith<$Res>? get shadow;

}
/// @nodoc
class __$FriendCopyWithImpl<$Res>
    implements _$FriendCopyWith<$Res> {
  __$FriendCopyWithImpl(this._self, this._then);

  final _Friend _self;
  final $Res Function(_Friend) _then;

/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? appearance = null,Object? closeness = null,Object? streak = null,Object? mood = freezed,Object? hasUnreadSnaps = null,Object? shadow = freezed,Object? sharedTrophies = null,}) {
  return _then(_Friend(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as PlanetAppearance,closeness: null == closeness ? _self.closeness : closeness // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as Streak,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood?,hasUnreadSnaps: null == hasUnreadSnaps ? _self.hasUnreadSnaps : hasUnreadSnaps // ignore: cast_nullable_to_non_nullable
as bool,shadow: freezed == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as Shadow?,sharedTrophies: null == sharedTrophies ? _self._sharedTrophies : sharedTrophies // ignore: cast_nullable_to_non_nullable
as List<Award>,
  ));
}

/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanetAppearanceCopyWith<$Res> get appearance {
  
  return $PlanetAppearanceCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StreakCopyWith<$Res> get streak {
  
  return $StreakCopyWith<$Res>(_self.streak, (value) {
    return _then(_self.copyWith(streak: value));
  });
}/// Create a copy of Friend
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
