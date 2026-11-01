// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatThread {

 Friend get friend; List<Message> get messages; List<Award> get sharedTrophies;/// Подсказки, с чего начать разговор. Сервер присылает их, когда друг
/// отдаляется или серия дала трещину; иначе список пуст.
 List<String> get conversationStarters;
/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThreadCopyWith<ChatThread> get copyWith => _$ChatThreadCopyWithImpl<ChatThread>(this as ChatThread, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatThread;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThread&&(identical(other.friend, _this.friend) || other.friend == _this.friend)&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&const DeepCollectionEquality().equals(other.sharedTrophies, _this.sharedTrophies)&&const DeepCollectionEquality().equals(other.conversationStarters, _this.conversationStarters));
}


@override
int get hashCode {
  final _this = this as ChatThread;
  return Object.hash(runtimeType,_this.friend,const DeepCollectionEquality().hash(_this.messages),const DeepCollectionEquality().hash(_this.sharedTrophies),const DeepCollectionEquality().hash(_this.conversationStarters));
}

@override
String toString() {
  final _this = this as ChatThread;
  return 'ChatThread(friend: ${_this.friend}, messages: ${_this.messages}, sharedTrophies: ${_this.sharedTrophies}, conversationStarters: ${_this.conversationStarters})';
}


}

/// @nodoc
abstract mixin class $ChatThreadCopyWith<$Res>  {
  factory $ChatThreadCopyWith(ChatThread value, $Res Function(ChatThread) _then) = _$ChatThreadCopyWithImpl;
@useResult
$Res call({
 Friend friend, List<Message> messages, List<Award> sharedTrophies, List<String> conversationStarters
});


$FriendCopyWith<$Res> get friend;

}
/// @nodoc
class _$ChatThreadCopyWithImpl<$Res>
    implements $ChatThreadCopyWith<$Res> {
  _$ChatThreadCopyWithImpl(this._self, this._then);

  final ChatThread _self;
  final $Res Function(ChatThread) _then;

/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friend = null,Object? messages = null,Object? sharedTrophies = null,Object? conversationStarters = null,}) {
  return _then(ChatThread(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as Friend,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,sharedTrophies: null == sharedTrophies ? _self.sharedTrophies : sharedTrophies // ignore: cast_nullable_to_non_nullable
as List<Award>,conversationStarters: null == conversationStarters ? _self.conversationStarters : conversationStarters // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendCopyWith<$Res> get friend {
  
  return $FriendCopyWith<$Res>(_self.friend, (value) {
    return _then(_self.copyWith(friend: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatThread].
extension ChatThreadPatterns on ChatThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatThread value)  $default,){
final _that = this;
switch (_that) {
case _ChatThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatThread value)?  $default,){
final _that = this;
switch (_that) {
case _ChatThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Friend friend,  List<Message> messages,  List<Award> sharedTrophies,  List<String> conversationStarters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatThread() when $default != null:
return $default(_that.friend,_that.messages,_that.sharedTrophies,_that.conversationStarters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Friend friend,  List<Message> messages,  List<Award> sharedTrophies,  List<String> conversationStarters)  $default,) {final _that = this;
switch (_that) {
case _ChatThread():
return $default(_that.friend,_that.messages,_that.sharedTrophies,_that.conversationStarters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Friend friend,  List<Message> messages,  List<Award> sharedTrophies,  List<String> conversationStarters)?  $default,) {final _that = this;
switch (_that) {
case _ChatThread() when $default != null:
return $default(_that.friend,_that.messages,_that.sharedTrophies,_that.conversationStarters);case _:
  return null;

}
}

}

/// @nodoc


class _ChatThread implements ChatThread {
  const _ChatThread({required this.friend, required  List<Message> messages, required  List<Award> sharedTrophies,  List<String> conversationStarters = const []}): _messages = messages,_sharedTrophies = sharedTrophies,_conversationStarters = conversationStarters;
  

@override final  Friend friend;
 final  List<Message> _messages;
@override List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

 final  List<Award> _sharedTrophies;
@override List<Award> get sharedTrophies {
  if (_sharedTrophies is EqualUnmodifiableListView) return _sharedTrophies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedTrophies);
}

/// Подсказки, с чего начать разговор. Сервер присылает их, когда друг
/// отдаляется или серия дала трещину; иначе список пуст.
 final  List<String> _conversationStarters;
/// Подсказки, с чего начать разговор. Сервер присылает их, когда друг
/// отдаляется или серия дала трещину; иначе список пуст.
@override@JsonKey() List<String> get conversationStarters {
  if (_conversationStarters is EqualUnmodifiableListView) return _conversationStarters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversationStarters);
}


/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatThreadCopyWith<_ChatThread> get copyWith => __$ChatThreadCopyWithImpl<_ChatThread>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatThread&&(identical(other.friend, friend) || other.friend == friend)&&const DeepCollectionEquality().equals(other.messages, _messages)&&const DeepCollectionEquality().equals(other.sharedTrophies, _sharedTrophies)&&const DeepCollectionEquality().equals(other.conversationStarters, _conversationStarters));
}


@override
int get hashCode {
    return Object.hash(runtimeType,friend,const DeepCollectionEquality().hash(_messages),const DeepCollectionEquality().hash(_sharedTrophies),const DeepCollectionEquality().hash(_conversationStarters));
}

@override
String toString() {
    return 'ChatThread(friend: $friend, messages: $messages, sharedTrophies: $sharedTrophies, conversationStarters: $conversationStarters)';
}


}

/// @nodoc
abstract mixin class _$ChatThreadCopyWith<$Res> implements $ChatThreadCopyWith<$Res> {
  factory _$ChatThreadCopyWith(_ChatThread value, $Res Function(_ChatThread) _then) = __$ChatThreadCopyWithImpl;
@override @useResult
$Res call({
 Friend friend, List<Message> messages, List<Award> sharedTrophies, List<String> conversationStarters
});


@override $FriendCopyWith<$Res> get friend;

}
/// @nodoc
class __$ChatThreadCopyWithImpl<$Res>
    implements _$ChatThreadCopyWith<$Res> {
  __$ChatThreadCopyWithImpl(this._self, this._then);

  final _ChatThread _self;
  final $Res Function(_ChatThread) _then;

/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friend = null,Object? messages = null,Object? sharedTrophies = null,Object? conversationStarters = null,}) {
  return _then(_ChatThread(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as Friend,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,sharedTrophies: null == sharedTrophies ? _self._sharedTrophies : sharedTrophies // ignore: cast_nullable_to_non_nullable
as List<Award>,conversationStarters: null == conversationStarters ? _self._conversationStarters : conversationStarters // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ChatThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendCopyWith<$Res> get friend {
  
  return $FriendCopyWith<$Res>(_self.friend, (value) {
    return _then(_self.copyWith(friend: value));
  });
}
}

/// @nodoc
mixin _$ChatPreview {

 Friend get friend; Message? get lastMessage;
/// Create a copy of ChatPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPreviewCopyWith<ChatPreview> get copyWith => _$ChatPreviewCopyWithImpl<ChatPreview>(this as ChatPreview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatPreview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPreview&&(identical(other.friend, _this.friend) || other.friend == _this.friend)&&(identical(other.lastMessage, _this.lastMessage) || other.lastMessage == _this.lastMessage));
}


@override
int get hashCode {
  final _this = this as ChatPreview;
  return Object.hash(runtimeType,_this.friend,_this.lastMessage);
}

@override
String toString() {
  final _this = this as ChatPreview;
  return 'ChatPreview(friend: ${_this.friend}, lastMessage: ${_this.lastMessage})';
}


}

/// @nodoc
abstract mixin class $ChatPreviewCopyWith<$Res>  {
  factory $ChatPreviewCopyWith(ChatPreview value, $Res Function(ChatPreview) _then) = _$ChatPreviewCopyWithImpl;
@useResult
$Res call({
 Friend friend, Message? lastMessage
});


$FriendCopyWith<$Res> get friend;$MessageCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class _$ChatPreviewCopyWithImpl<$Res>
    implements $ChatPreviewCopyWith<$Res> {
  _$ChatPreviewCopyWithImpl(this._self, this._then);

  final ChatPreview _self;
  final $Res Function(ChatPreview) _then;

/// Create a copy of ChatPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friend = null,Object? lastMessage = freezed,}) {
  return _then(ChatPreview(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as Friend,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as Message?,
  ));
}
/// Create a copy of ChatPreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendCopyWith<$Res> get friend {
  
  return $FriendCopyWith<$Res>(_self.friend, (value) {
    return _then(_self.copyWith(friend: value));
  });
}/// Create a copy of ChatPreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $MessageCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatPreview].
extension ChatPreviewPatterns on ChatPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatPreview value)  $default,){
final _that = this;
switch (_that) {
case _ChatPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatPreview value)?  $default,){
final _that = this;
switch (_that) {
case _ChatPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Friend friend,  Message? lastMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatPreview() when $default != null:
return $default(_that.friend,_that.lastMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Friend friend,  Message? lastMessage)  $default,) {final _that = this;
switch (_that) {
case _ChatPreview():
return $default(_that.friend,_that.lastMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Friend friend,  Message? lastMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChatPreview() when $default != null:
return $default(_that.friend,_that.lastMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ChatPreview implements ChatPreview {
  const _ChatPreview({required this.friend, required this.lastMessage});
  

@override final  Friend friend;
@override final  Message? lastMessage;

/// Create a copy of ChatPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatPreviewCopyWith<_ChatPreview> get copyWith => __$ChatPreviewCopyWithImpl<_ChatPreview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatPreview&&(identical(other.friend, friend) || other.friend == friend)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,friend,lastMessage);
}

@override
String toString() {
    return 'ChatPreview(friend: $friend, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class _$ChatPreviewCopyWith<$Res> implements $ChatPreviewCopyWith<$Res> {
  factory _$ChatPreviewCopyWith(_ChatPreview value, $Res Function(_ChatPreview) _then) = __$ChatPreviewCopyWithImpl;
@override @useResult
$Res call({
 Friend friend, Message? lastMessage
});


@override $FriendCopyWith<$Res> get friend;@override $MessageCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class __$ChatPreviewCopyWithImpl<$Res>
    implements _$ChatPreviewCopyWith<$Res> {
  __$ChatPreviewCopyWithImpl(this._self, this._then);

  final _ChatPreview _self;
  final $Res Function(_ChatPreview) _then;

/// Create a copy of ChatPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friend = null,Object? lastMessage = freezed,}) {
  return _then(_ChatPreview(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as Friend,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as Message?,
  ));
}

/// Create a copy of ChatPreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendCopyWith<$Res> get friend {
  
  return $FriendCopyWith<$Res>(_self.friend, (value) {
    return _then(_self.copyWith(friend: value));
  });
}/// Create a copy of ChatPreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $MessageCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}

// dart format on
