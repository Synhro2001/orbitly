// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Message {

 String get id; bool get isMine; DateTime get sentAt;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Message;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.isMine, _this.isMine) || other.isMine == _this.isMine)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}


@override
int get hashCode {
  final _this = this as Message;
  return Object.hash(runtimeType,_this.id,_this.isMine,_this.sentAt);
}

@override
String toString() {
  final _this = this as Message;
  return 'Message(id: ${_this.id}, isMine: ${_this.isMine}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, bool isMine, DateTime sentAt
});




}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
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


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TextMessage value)?  text,TResult Function( SnapMessage value)?  snap,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextMessage() when text != null:
return text(_that);case SnapMessage() when snap != null:
return snap(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TextMessage value)  text,required TResult Function( SnapMessage value)  snap,}){
final _that = this;
switch (_that) {
case TextMessage():
return text(_that);case SnapMessage():
return snap(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TextMessage value)?  text,TResult? Function( SnapMessage value)?  snap,}){
final _that = this;
switch (_that) {
case TextMessage() when text != null:
return text(_that);case SnapMessage() when snap != null:
return snap(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  bool isMine,  DateTime sentAt,  String text)?  text,TResult Function( String id,  bool isMine,  DateTime sentAt,  bool opened)?  snap,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextMessage() when text != null:
return text(_that.id,_that.isMine,_that.sentAt,_that.text);case SnapMessage() when snap != null:
return snap(_that.id,_that.isMine,_that.sentAt,_that.opened);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  bool isMine,  DateTime sentAt,  String text)  text,required TResult Function( String id,  bool isMine,  DateTime sentAt,  bool opened)  snap,}) {final _that = this;
switch (_that) {
case TextMessage():
return text(_that.id,_that.isMine,_that.sentAt,_that.text);case SnapMessage():
return snap(_that.id,_that.isMine,_that.sentAt,_that.opened);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  bool isMine,  DateTime sentAt,  String text)?  text,TResult? Function( String id,  bool isMine,  DateTime sentAt,  bool opened)?  snap,}) {final _that = this;
switch (_that) {
case TextMessage() when text != null:
return text(_that.id,_that.isMine,_that.sentAt,_that.text);case SnapMessage() when snap != null:
return snap(_that.id,_that.isMine,_that.sentAt,_that.opened);case _:
  return null;

}
}

}

/// @nodoc


class TextMessage implements Message {
  const TextMessage({required this.id, required this.isMine, required this.sentAt, required this.text});
  

@override final  String id;
@override final  bool isMine;
@override final  DateTime sentAt;
 final  String text;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextMessageCopyWith<TextMessage> get copyWith => _$TextMessageCopyWithImpl<TextMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TextMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,isMine,sentAt,text);
}

@override
String toString() {
    return 'Message.text(id: $id, isMine: $isMine, sentAt: $sentAt, text: $text)';
}


}

/// @nodoc
abstract mixin class $TextMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $TextMessageCopyWith(TextMessage value, $Res Function(TextMessage) _then) = _$TextMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isMine, DateTime sentAt, String text
});




}
/// @nodoc
class _$TextMessageCopyWithImpl<$Res>
    implements $TextMessageCopyWith<$Res> {
  _$TextMessageCopyWithImpl(this._self, this._then);

  final TextMessage _self;
  final $Res Function(TextMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isMine = null,Object? sentAt = null,Object? text = null,}) {
  return _then(TextMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SnapMessage implements Message {
  const SnapMessage({required this.id, required this.isMine, required this.sentAt, required this.opened});
  

@override final  String id;
@override final  bool isMine;
@override final  DateTime sentAt;
 final  bool opened;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnapMessageCopyWith<SnapMessage> get copyWith => _$SnapMessageCopyWithImpl<SnapMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SnapMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.opened, opened) || other.opened == opened));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,isMine,sentAt,opened);
}

@override
String toString() {
    return 'Message.snap(id: $id, isMine: $isMine, sentAt: $sentAt, opened: $opened)';
}


}

/// @nodoc
abstract mixin class $SnapMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $SnapMessageCopyWith(SnapMessage value, $Res Function(SnapMessage) _then) = _$SnapMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isMine, DateTime sentAt, bool opened
});




}
/// @nodoc
class _$SnapMessageCopyWithImpl<$Res>
    implements $SnapMessageCopyWith<$Res> {
  _$SnapMessageCopyWithImpl(this._self, this._then);

  final SnapMessage _self;
  final $Res Function(SnapMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isMine = null,Object? sentAt = null,Object? opened = null,}) {
  return _then(SnapMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,opened: null == opened ? _self.opened : opened // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
