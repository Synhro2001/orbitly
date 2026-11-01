// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'award.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Award {

 String get id; AwardCategory get category; Rarity get rarity; String? get title; String? get description; String? get emoji; int get progress; int get target; bool get hidden;/// Общее для двух друзей: открывается у обоих.
 bool get pair;/// Косметика, которую даёт достижение.
 String? get rewardId; String? get rewardTitle; DateTime? get unlockedAt; DateTime? get seenAt;
/// Create a copy of Award
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AwardCopyWith<Award> get copyWith => _$AwardCopyWithImpl<Award>(this as Award, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Award;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Award&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.rarity, _this.rarity) || other.rarity == _this.rarity)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.emoji, _this.emoji) || other.emoji == _this.emoji)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.hidden, _this.hidden) || other.hidden == _this.hidden)&&(identical(other.pair, _this.pair) || other.pair == _this.pair)&&(identical(other.rewardId, _this.rewardId) || other.rewardId == _this.rewardId)&&(identical(other.rewardTitle, _this.rewardTitle) || other.rewardTitle == _this.rewardTitle)&&(identical(other.unlockedAt, _this.unlockedAt) || other.unlockedAt == _this.unlockedAt)&&(identical(other.seenAt, _this.seenAt) || other.seenAt == _this.seenAt));
}


@override
int get hashCode {
  final _this = this as Award;
  return Object.hash(runtimeType,_this.id,_this.category,_this.rarity,_this.title,_this.description,_this.emoji,_this.progress,_this.target,_this.hidden,_this.pair,_this.rewardId,_this.rewardTitle,_this.unlockedAt,_this.seenAt);
}

@override
String toString() {
  final _this = this as Award;
  return 'Award(id: ${_this.id}, category: ${_this.category}, rarity: ${_this.rarity}, title: ${_this.title}, description: ${_this.description}, emoji: ${_this.emoji}, progress: ${_this.progress}, target: ${_this.target}, hidden: ${_this.hidden}, pair: ${_this.pair}, rewardId: ${_this.rewardId}, rewardTitle: ${_this.rewardTitle}, unlockedAt: ${_this.unlockedAt}, seenAt: ${_this.seenAt})';
}


}

/// @nodoc
abstract mixin class $AwardCopyWith<$Res>  {
  factory $AwardCopyWith(Award value, $Res Function(Award) _then) = _$AwardCopyWithImpl;
@useResult
$Res call({
 String id, AwardCategory category, Rarity rarity, String? title, String? description, String? emoji, int progress, int target, bool hidden, bool pair, String? rewardId, String? rewardTitle, DateTime? unlockedAt, DateTime? seenAt
});




}
/// @nodoc
class _$AwardCopyWithImpl<$Res>
    implements $AwardCopyWith<$Res> {
  _$AwardCopyWithImpl(this._self, this._then);

  final Award _self;
  final $Res Function(Award) _then;

/// Create a copy of Award
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? rarity = null,Object? title = freezed,Object? description = freezed,Object? emoji = freezed,Object? progress = null,Object? target = null,Object? hidden = null,Object? pair = null,Object? rewardId = freezed,Object? rewardTitle = freezed,Object? unlockedAt = freezed,Object? seenAt = freezed,}) {
  return _then(Award(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AwardCategory,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as Rarity,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,pair: null == pair ? _self.pair : pair // ignore: cast_nullable_to_non_nullable
as bool,rewardId: freezed == rewardId ? _self.rewardId : rewardId // ignore: cast_nullable_to_non_nullable
as String?,rewardTitle: freezed == rewardTitle ? _self.rewardTitle : rewardTitle // ignore: cast_nullable_to_non_nullable
as String?,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Award].
extension AwardPatterns on Award {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Award value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Award() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Award value)  $default,){
final _that = this;
switch (_that) {
case _Award():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Award value)?  $default,){
final _that = this;
switch (_that) {
case _Award() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  AwardCategory category,  Rarity rarity,  String? title,  String? description,  String? emoji,  int progress,  int target,  bool hidden,  bool pair,  String? rewardId,  String? rewardTitle,  DateTime? unlockedAt,  DateTime? seenAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Award() when $default != null:
return $default(_that.id,_that.category,_that.rarity,_that.title,_that.description,_that.emoji,_that.progress,_that.target,_that.hidden,_that.pair,_that.rewardId,_that.rewardTitle,_that.unlockedAt,_that.seenAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  AwardCategory category,  Rarity rarity,  String? title,  String? description,  String? emoji,  int progress,  int target,  bool hidden,  bool pair,  String? rewardId,  String? rewardTitle,  DateTime? unlockedAt,  DateTime? seenAt)  $default,) {final _that = this;
switch (_that) {
case _Award():
return $default(_that.id,_that.category,_that.rarity,_that.title,_that.description,_that.emoji,_that.progress,_that.target,_that.hidden,_that.pair,_that.rewardId,_that.rewardTitle,_that.unlockedAt,_that.seenAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  AwardCategory category,  Rarity rarity,  String? title,  String? description,  String? emoji,  int progress,  int target,  bool hidden,  bool pair,  String? rewardId,  String? rewardTitle,  DateTime? unlockedAt,  DateTime? seenAt)?  $default,) {final _that = this;
switch (_that) {
case _Award() when $default != null:
return $default(_that.id,_that.category,_that.rarity,_that.title,_that.description,_that.emoji,_that.progress,_that.target,_that.hidden,_that.pair,_that.rewardId,_that.rewardTitle,_that.unlockedAt,_that.seenAt);case _:
  return null;

}
}

}

/// @nodoc


class _Award extends Award {
  const _Award({required this.id, required this.category, required this.rarity, this.title, this.description, this.emoji, this.progress = 0, this.target = 1, this.hidden = false, this.pair = false, this.rewardId, this.rewardTitle, this.unlockedAt, this.seenAt}): super._();
  

@override final  String id;
@override final  AwardCategory category;
@override final  Rarity rarity;
@override final  String? title;
@override final  String? description;
@override final  String? emoji;
@override@JsonKey() final  int progress;
@override@JsonKey() final  int target;
@override@JsonKey() final  bool hidden;
/// Общее для двух друзей: открывается у обоих.
@override@JsonKey() final  bool pair;
/// Косметика, которую даёт достижение.
@override final  String? rewardId;
@override final  String? rewardTitle;
@override final  DateTime? unlockedAt;
@override final  DateTime? seenAt;

/// Create a copy of Award
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AwardCopyWith<_Award> get copyWith => __$AwardCopyWithImpl<_Award>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Award&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.target, target) || other.target == target)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.pair, pair) || other.pair == pair)&&(identical(other.rewardId, rewardId) || other.rewardId == rewardId)&&(identical(other.rewardTitle, rewardTitle) || other.rewardTitle == rewardTitle)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,category,rarity,title,description,emoji,progress,target,hidden,pair,rewardId,rewardTitle,unlockedAt,seenAt);
}

@override
String toString() {
    return 'Award(id: $id, category: $category, rarity: $rarity, title: $title, description: $description, emoji: $emoji, progress: $progress, target: $target, hidden: $hidden, pair: $pair, rewardId: $rewardId, rewardTitle: $rewardTitle, unlockedAt: $unlockedAt, seenAt: $seenAt)';
}


}

/// @nodoc
abstract mixin class _$AwardCopyWith<$Res> implements $AwardCopyWith<$Res> {
  factory _$AwardCopyWith(_Award value, $Res Function(_Award) _then) = __$AwardCopyWithImpl;
@override @useResult
$Res call({
 String id, AwardCategory category, Rarity rarity, String? title, String? description, String? emoji, int progress, int target, bool hidden, bool pair, String? rewardId, String? rewardTitle, DateTime? unlockedAt, DateTime? seenAt
});




}
/// @nodoc
class __$AwardCopyWithImpl<$Res>
    implements _$AwardCopyWith<$Res> {
  __$AwardCopyWithImpl(this._self, this._then);

  final _Award _self;
  final $Res Function(_Award) _then;

/// Create a copy of Award
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? rarity = null,Object? title = freezed,Object? description = freezed,Object? emoji = freezed,Object? progress = null,Object? target = null,Object? hidden = null,Object? pair = null,Object? rewardId = freezed,Object? rewardTitle = freezed,Object? unlockedAt = freezed,Object? seenAt = freezed,}) {
  return _then(_Award(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AwardCategory,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as Rarity,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,pair: null == pair ? _self.pair : pair // ignore: cast_nullable_to_non_nullable
as bool,rewardId: freezed == rewardId ? _self.rewardId : rewardId // ignore: cast_nullable_to_non_nullable
as String?,rewardTitle: freezed == rewardTitle ? _self.rewardTitle : rewardTitle // ignore: cast_nullable_to_non_nullable
as String?,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
