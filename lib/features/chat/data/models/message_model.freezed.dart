// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
MessageModel _$MessageModelFromJson(
  Map<String, dynamic> json
) {
        switch (json['kind']) {
                  case 'text':
          return TextMessageModel.fromJson(
            json
          );
                case 'snap':
          return SnapMessageModel.fromJson(
            json
          );
                case 'capsule':
          return CapsuleMessageModel.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'kind',
  'MessageModel',
  'Invalid union type "${json['kind']}"!'
);
        }
      
}

/// @nodoc
mixin _$MessageModel {

 String get id; bool get isMine; DateTime get sentAt;
/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageModelCopyWith<MessageModel> get copyWith => _$MessageModelCopyWithImpl<MessageModel>(this as MessageModel, _$identity);

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MessageModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.isMine, _this.isMine) || other.isMine == _this.isMine)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MessageModel;
  return Object.hash(runtimeType,_this.id,_this.isMine,_this.sentAt);
}

@override
String toString() {
  final _this = this as MessageModel;
  return 'MessageModel(id: ${_this.id}, isMine: ${_this.isMine}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $MessageModelCopyWith<$Res>  {
  factory $MessageModelCopyWith(MessageModel value, $Res Function(MessageModel) _then) = _$MessageModelCopyWithImpl;
@useResult
$Res call({
 String id, bool isMine, DateTime sentAt
});




}
/// @nodoc
class _$MessageModelCopyWithImpl<$Res>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._self, this._then);

  final MessageModel _self;
  final $Res Function(MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? isMine = null,Object? sentAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageModel].
extension MessageModelPatterns on MessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TextMessageModel value)?  text,TResult Function( SnapMessageModel value)?  snap,TResult Function( CapsuleMessageModel value)?  capsule,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextMessageModel() when text != null:
return text(_that);case SnapMessageModel() when snap != null:
return snap(_that);case CapsuleMessageModel() when capsule != null:
return capsule(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TextMessageModel value)  text,required TResult Function( SnapMessageModel value)  snap,required TResult Function( CapsuleMessageModel value)  capsule,}){
final _that = this;
switch (_that) {
case TextMessageModel():
return text(_that);case SnapMessageModel():
return snap(_that);case CapsuleMessageModel():
return capsule(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TextMessageModel value)?  text,TResult? Function( SnapMessageModel value)?  snap,TResult? Function( CapsuleMessageModel value)?  capsule,}){
final _that = this;
switch (_that) {
case TextMessageModel() when text != null:
return text(_that);case SnapMessageModel() when snap != null:
return snap(_that);case CapsuleMessageModel() when capsule != null:
return capsule(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  bool isMine,  DateTime sentAt,  String text)?  text,TResult Function( String id,  bool isMine,  DateTime sentAt,  bool opened)?  snap,TResult Function( String id,  bool isMine,  DateTime sentAt,  DateTime opensAt,  String text)?  capsule,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextMessageModel() when text != null:
return text(_that.id,_that.isMine,_that.sentAt,_that.text);case SnapMessageModel() when snap != null:
return snap(_that.id,_that.isMine,_that.sentAt,_that.opened);case CapsuleMessageModel() when capsule != null:
return capsule(_that.id,_that.isMine,_that.sentAt,_that.opensAt,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  bool isMine,  DateTime sentAt,  String text)  text,required TResult Function( String id,  bool isMine,  DateTime sentAt,  bool opened)  snap,required TResult Function( String id,  bool isMine,  DateTime sentAt,  DateTime opensAt,  String text)  capsule,}) {final _that = this;
switch (_that) {
case TextMessageModel():
return text(_that.id,_that.isMine,_that.sentAt,_that.text);case SnapMessageModel():
return snap(_that.id,_that.isMine,_that.sentAt,_that.opened);case CapsuleMessageModel():
return capsule(_that.id,_that.isMine,_that.sentAt,_that.opensAt,_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  bool isMine,  DateTime sentAt,  String text)?  text,TResult? Function( String id,  bool isMine,  DateTime sentAt,  bool opened)?  snap,TResult? Function( String id,  bool isMine,  DateTime sentAt,  DateTime opensAt,  String text)?  capsule,}) {final _that = this;
switch (_that) {
case TextMessageModel() when text != null:
return text(_that.id,_that.isMine,_that.sentAt,_that.text);case SnapMessageModel() when snap != null:
return snap(_that.id,_that.isMine,_that.sentAt,_that.opened);case CapsuleMessageModel() when capsule != null:
return capsule(_that.id,_that.isMine,_that.sentAt,_that.opensAt,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TextMessageModel implements MessageModel {
  const TextMessageModel({required this.id, required this.isMine, required this.sentAt, required this.text,  String? $type}): $type = $type ?? 'text';
  factory TextMessageModel.fromJson(Map<String, dynamic> json) => _$TextMessageModelFromJson(json);

@override final  String id;
@override final  bool isMine;
@override final  DateTime sentAt;
 final  String text;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextMessageModelCopyWith<TextMessageModel> get copyWith => _$TextMessageModelCopyWithImpl<TextMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TextMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,isMine,sentAt,text);
}

@override
String toString() {
    return 'MessageModel.text(id: $id, isMine: $isMine, sentAt: $sentAt, text: $text)';
}


}

/// @nodoc
abstract mixin class $TextMessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory $TextMessageModelCopyWith(TextMessageModel value, $Res Function(TextMessageModel) _then) = _$TextMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isMine, DateTime sentAt, String text
});




}
/// @nodoc
class _$TextMessageModelCopyWithImpl<$Res>
    implements $TextMessageModelCopyWith<$Res> {
  _$TextMessageModelCopyWithImpl(this._self, this._then);

  final TextMessageModel _self;
  final $Res Function(TextMessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isMine = null,Object? sentAt = null,Object? text = null,}) {
  return _then(TextMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SnapMessageModel implements MessageModel {
  const SnapMessageModel({required this.id, required this.isMine, required this.sentAt, required this.opened,  String? $type}): $type = $type ?? 'snap';
  factory SnapMessageModel.fromJson(Map<String, dynamic> json) => _$SnapMessageModelFromJson(json);

@override final  String id;
@override final  bool isMine;
@override final  DateTime sentAt;
 final  bool opened;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnapMessageModelCopyWith<SnapMessageModel> get copyWith => _$SnapMessageModelCopyWithImpl<SnapMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SnapMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SnapMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.opened, opened) || other.opened == opened));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,isMine,sentAt,opened);
}

@override
String toString() {
    return 'MessageModel.snap(id: $id, isMine: $isMine, sentAt: $sentAt, opened: $opened)';
}


}

/// @nodoc
abstract mixin class $SnapMessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory $SnapMessageModelCopyWith(SnapMessageModel value, $Res Function(SnapMessageModel) _then) = _$SnapMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isMine, DateTime sentAt, bool opened
});




}
/// @nodoc
class _$SnapMessageModelCopyWithImpl<$Res>
    implements $SnapMessageModelCopyWith<$Res> {
  _$SnapMessageModelCopyWithImpl(this._self, this._then);

  final SnapMessageModel _self;
  final $Res Function(SnapMessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isMine = null,Object? sentAt = null,Object? opened = null,}) {
  return _then(SnapMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,opened: null == opened ? _self.opened : opened // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CapsuleMessageModel implements MessageModel {
  const CapsuleMessageModel({required this.id, required this.isMine, required this.sentAt, required this.opensAt, required this.text,  String? $type}): $type = $type ?? 'capsule';
  factory CapsuleMessageModel.fromJson(Map<String, dynamic> json) => _$CapsuleMessageModelFromJson(json);

@override final  String id;
@override final  bool isMine;
@override final  DateTime sentAt;
 final  DateTime opensAt;
 final  String text;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapsuleMessageModelCopyWith<CapsuleMessageModel> get copyWith => _$CapsuleMessageModelCopyWithImpl<CapsuleMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CapsuleMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CapsuleMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,isMine,sentAt,opensAt,text);
}

@override
String toString() {
    return 'MessageModel.capsule(id: $id, isMine: $isMine, sentAt: $sentAt, opensAt: $opensAt, text: $text)';
}


}

/// @nodoc
abstract mixin class $CapsuleMessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory $CapsuleMessageModelCopyWith(CapsuleMessageModel value, $Res Function(CapsuleMessageModel) _then) = _$CapsuleMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isMine, DateTime sentAt, DateTime opensAt, String text
});




}
/// @nodoc
class _$CapsuleMessageModelCopyWithImpl<$Res>
    implements $CapsuleMessageModelCopyWith<$Res> {
  _$CapsuleMessageModelCopyWithImpl(this._self, this._then);

  final CapsuleMessageModel _self;
  final $Res Function(CapsuleMessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isMine = null,Object? sentAt = null,Object? opensAt = null,Object? text = null,}) {
  return _then(CapsuleMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,opensAt: null == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
