// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'award_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AwardModel {

 String get id;@JsonKey(unknownEnumValue: AwardCategory.collection) AwardCategory get category;@JsonKey(unknownEnumValue: Rarity.common) Rarity get rarity;@LocalizedTextConverter() LocalizedText? get title;@LocalizedTextConverter() LocalizedText? get description; String? get icon; bool get hidden; bool get pair; int? get progress; int? get target; DateTime? get unlockedAt; DateTime? get seenAt; String? get rewardCosmeticId;@LocalizedTextConverter() LocalizedText? get rewardTitle;
/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AwardModelCopyWith<AwardModel> get copyWith => _$AwardModelCopyWithImpl<AwardModel>(this as AwardModel, _$identity);

  /// Serializes this AwardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AwardModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AwardModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.rarity, _this.rarity) || other.rarity == _this.rarity)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.hidden, _this.hidden) || other.hidden == _this.hidden)&&(identical(other.pair, _this.pair) || other.pair == _this.pair)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.unlockedAt, _this.unlockedAt) || other.unlockedAt == _this.unlockedAt)&&(identical(other.seenAt, _this.seenAt) || other.seenAt == _this.seenAt)&&(identical(other.rewardCosmeticId, _this.rewardCosmeticId) || other.rewardCosmeticId == _this.rewardCosmeticId)&&(identical(other.rewardTitle, _this.rewardTitle) || other.rewardTitle == _this.rewardTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AwardModel;
  return Object.hash(runtimeType,_this.id,_this.category,_this.rarity,_this.title,_this.description,_this.icon,_this.hidden,_this.pair,_this.progress,_this.target,_this.unlockedAt,_this.seenAt,_this.rewardCosmeticId,_this.rewardTitle);
}

@override
String toString() {
  final _this = this as AwardModel;
  return 'AwardModel(id: ${_this.id}, category: ${_this.category}, rarity: ${_this.rarity}, title: ${_this.title}, description: ${_this.description}, icon: ${_this.icon}, hidden: ${_this.hidden}, pair: ${_this.pair}, progress: ${_this.progress}, target: ${_this.target}, unlockedAt: ${_this.unlockedAt}, seenAt: ${_this.seenAt}, rewardCosmeticId: ${_this.rewardCosmeticId}, rewardTitle: ${_this.rewardTitle})';
}


}

/// @nodoc
abstract mixin class $AwardModelCopyWith<$Res>  {
  factory $AwardModelCopyWith(AwardModel value, $Res Function(AwardModel) _then) = _$AwardModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: AwardCategory.collection) AwardCategory category,@JsonKey(unknownEnumValue: Rarity.common) Rarity rarity,@LocalizedTextConverter() LocalizedText? title,@LocalizedTextConverter() LocalizedText? description, String? icon, bool hidden, bool pair, int? progress, int? target, DateTime? unlockedAt, DateTime? seenAt, String? rewardCosmeticId,@LocalizedTextConverter() LocalizedText? rewardTitle
});


$LocalizedTextCopyWith<$Res>? get title;$LocalizedTextCopyWith<$Res>? get description;$LocalizedTextCopyWith<$Res>? get rewardTitle;

}
/// @nodoc
class _$AwardModelCopyWithImpl<$Res>
    implements $AwardModelCopyWith<$Res> {
  _$AwardModelCopyWithImpl(this._self, this._then);

  final AwardModel _self;
  final $Res Function(AwardModel) _then;

/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? rarity = null,Object? title = freezed,Object? description = freezed,Object? icon = freezed,Object? hidden = null,Object? pair = null,Object? progress = freezed,Object? target = freezed,Object? unlockedAt = freezed,Object? seenAt = freezed,Object? rewardCosmeticId = freezed,Object? rewardTitle = freezed,}) {
  return _then(AwardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AwardCategory,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as Rarity,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,pair: null == pair ? _self.pair : pair // ignore: cast_nullable_to_non_nullable
as bool,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int?,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rewardCosmeticId: freezed == rewardCosmeticId ? _self.rewardCosmeticId : rewardCosmeticId // ignore: cast_nullable_to_non_nullable
as String?,rewardTitle: freezed == rewardTitle ? _self.rewardTitle : rewardTitle // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get title {
    if (_self.title == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.title!, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get rewardTitle {
    if (_self.rewardTitle == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.rewardTitle!, (value) {
    return _then(_self.copyWith(rewardTitle: value));
  });
}
}


/// Adds pattern-matching-related methods to [AwardModel].
extension AwardModelPatterns on AwardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AwardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AwardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AwardModel value)  $default,){
final _that = this;
switch (_that) {
case _AwardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AwardModel value)?  $default,){
final _that = this;
switch (_that) {
case _AwardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: AwardCategory.collection)  AwardCategory category, @JsonKey(unknownEnumValue: Rarity.common)  Rarity rarity, @LocalizedTextConverter()  LocalizedText? title, @LocalizedTextConverter()  LocalizedText? description,  String? icon,  bool hidden,  bool pair,  int? progress,  int? target,  DateTime? unlockedAt,  DateTime? seenAt,  String? rewardCosmeticId, @LocalizedTextConverter()  LocalizedText? rewardTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AwardModel() when $default != null:
return $default(_that.id,_that.category,_that.rarity,_that.title,_that.description,_that.icon,_that.hidden,_that.pair,_that.progress,_that.target,_that.unlockedAt,_that.seenAt,_that.rewardCosmeticId,_that.rewardTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: AwardCategory.collection)  AwardCategory category, @JsonKey(unknownEnumValue: Rarity.common)  Rarity rarity, @LocalizedTextConverter()  LocalizedText? title, @LocalizedTextConverter()  LocalizedText? description,  String? icon,  bool hidden,  bool pair,  int? progress,  int? target,  DateTime? unlockedAt,  DateTime? seenAt,  String? rewardCosmeticId, @LocalizedTextConverter()  LocalizedText? rewardTitle)  $default,) {final _that = this;
switch (_that) {
case _AwardModel():
return $default(_that.id,_that.category,_that.rarity,_that.title,_that.description,_that.icon,_that.hidden,_that.pair,_that.progress,_that.target,_that.unlockedAt,_that.seenAt,_that.rewardCosmeticId,_that.rewardTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(unknownEnumValue: AwardCategory.collection)  AwardCategory category, @JsonKey(unknownEnumValue: Rarity.common)  Rarity rarity, @LocalizedTextConverter()  LocalizedText? title, @LocalizedTextConverter()  LocalizedText? description,  String? icon,  bool hidden,  bool pair,  int? progress,  int? target,  DateTime? unlockedAt,  DateTime? seenAt,  String? rewardCosmeticId, @LocalizedTextConverter()  LocalizedText? rewardTitle)?  $default,) {final _that = this;
switch (_that) {
case _AwardModel() when $default != null:
return $default(_that.id,_that.category,_that.rarity,_that.title,_that.description,_that.icon,_that.hidden,_that.pair,_that.progress,_that.target,_that.unlockedAt,_that.seenAt,_that.rewardCosmeticId,_that.rewardTitle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AwardModel implements AwardModel {
  const _AwardModel({required this.id, @JsonKey(unknownEnumValue: AwardCategory.collection) this.category = AwardCategory.collection, @JsonKey(unknownEnumValue: Rarity.common) this.rarity = Rarity.common, @LocalizedTextConverter() this.title, @LocalizedTextConverter() this.description, this.icon, this.hidden = false, this.pair = false, this.progress, this.target, this.unlockedAt, this.seenAt, this.rewardCosmeticId, @LocalizedTextConverter() this.rewardTitle});
  factory _AwardModel.fromJson(Map<String, dynamic> json) => _$AwardModelFromJson(json);

@override final  String id;
@override@JsonKey(unknownEnumValue: AwardCategory.collection) final  AwardCategory category;
@override@JsonKey(unknownEnumValue: Rarity.common) final  Rarity rarity;
@override@LocalizedTextConverter() final  LocalizedText? title;
@override@LocalizedTextConverter() final  LocalizedText? description;
@override final  String? icon;
@override@JsonKey() final  bool hidden;
@override@JsonKey() final  bool pair;
@override final  int? progress;
@override final  int? target;
@override final  DateTime? unlockedAt;
@override final  DateTime? seenAt;
@override final  String? rewardCosmeticId;
@override@LocalizedTextConverter() final  LocalizedText? rewardTitle;

/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AwardModelCopyWith<_AwardModel> get copyWith => __$AwardModelCopyWithImpl<_AwardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AwardModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AwardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.pair, pair) || other.pair == pair)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.target, target) || other.target == target)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&(identical(other.seenAt, seenAt) || other.seenAt == seenAt)&&(identical(other.rewardCosmeticId, rewardCosmeticId) || other.rewardCosmeticId == rewardCosmeticId)&&(identical(other.rewardTitle, rewardTitle) || other.rewardTitle == rewardTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,category,rarity,title,description,icon,hidden,pair,progress,target,unlockedAt,seenAt,rewardCosmeticId,rewardTitle);
}

@override
String toString() {
    return 'AwardModel(id: $id, category: $category, rarity: $rarity, title: $title, description: $description, icon: $icon, hidden: $hidden, pair: $pair, progress: $progress, target: $target, unlockedAt: $unlockedAt, seenAt: $seenAt, rewardCosmeticId: $rewardCosmeticId, rewardTitle: $rewardTitle)';
}


}

/// @nodoc
abstract mixin class _$AwardModelCopyWith<$Res> implements $AwardModelCopyWith<$Res> {
  factory _$AwardModelCopyWith(_AwardModel value, $Res Function(_AwardModel) _then) = __$AwardModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: AwardCategory.collection) AwardCategory category,@JsonKey(unknownEnumValue: Rarity.common) Rarity rarity,@LocalizedTextConverter() LocalizedText? title,@LocalizedTextConverter() LocalizedText? description, String? icon, bool hidden, bool pair, int? progress, int? target, DateTime? unlockedAt, DateTime? seenAt, String? rewardCosmeticId,@LocalizedTextConverter() LocalizedText? rewardTitle
});


@override $LocalizedTextCopyWith<$Res>? get title;@override $LocalizedTextCopyWith<$Res>? get description;@override $LocalizedTextCopyWith<$Res>? get rewardTitle;

}
/// @nodoc
class __$AwardModelCopyWithImpl<$Res>
    implements _$AwardModelCopyWith<$Res> {
  __$AwardModelCopyWithImpl(this._self, this._then);

  final _AwardModel _self;
  final $Res Function(_AwardModel) _then;

/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? rarity = null,Object? title = freezed,Object? description = freezed,Object? icon = freezed,Object? hidden = null,Object? pair = null,Object? progress = freezed,Object? target = freezed,Object? unlockedAt = freezed,Object? seenAt = freezed,Object? rewardCosmeticId = freezed,Object? rewardTitle = freezed,}) {
  return _then(_AwardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AwardCategory,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as Rarity,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,pair: null == pair ? _self.pair : pair // ignore: cast_nullable_to_non_nullable
as bool,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int?,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,seenAt: freezed == seenAt ? _self.seenAt : seenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rewardCosmeticId: freezed == rewardCosmeticId ? _self.rewardCosmeticId : rewardCosmeticId // ignore: cast_nullable_to_non_nullable
as String?,rewardTitle: freezed == rewardTitle ? _self.rewardTitle : rewardTitle // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get title {
    if (_self.title == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.title!, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of AwardModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get rewardTitle {
    if (_self.rewardTitle == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.rewardTitle!, (value) {
    return _then(_self.copyWith(rewardTitle: value));
  });
}
}

// dart format on
