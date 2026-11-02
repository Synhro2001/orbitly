// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeeklyReport {

 List<ReportEntry> get closer; List<ReportEntry> get drifting;
/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyReportCopyWith<WeeklyReport> get copyWith => _$WeeklyReportCopyWithImpl<WeeklyReport>(this as WeeklyReport, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WeeklyReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyReport&&const DeepCollectionEquality().equals(other.closer, _this.closer)&&const DeepCollectionEquality().equals(other.drifting, _this.drifting));
}


@override
int get hashCode {
  final _this = this as WeeklyReport;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.closer),const DeepCollectionEquality().hash(_this.drifting));
}

@override
String toString() {
  final _this = this as WeeklyReport;
  return 'WeeklyReport(closer: ${_this.closer}, drifting: ${_this.drifting})';
}


}

/// @nodoc
abstract mixin class $WeeklyReportCopyWith<$Res>  {
  factory $WeeklyReportCopyWith(WeeklyReport value, $Res Function(WeeklyReport) _then) = _$WeeklyReportCopyWithImpl;
@useResult
$Res call({
 List<ReportEntry> closer, List<ReportEntry> drifting
});




}
/// @nodoc
class _$WeeklyReportCopyWithImpl<$Res>
    implements $WeeklyReportCopyWith<$Res> {
  _$WeeklyReportCopyWithImpl(this._self, this._then);

  final WeeklyReport _self;
  final $Res Function(WeeklyReport) _then;

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? closer = null,Object? drifting = null,}) {
  return _then(WeeklyReport(
closer: null == closer ? _self.closer : closer // ignore: cast_nullable_to_non_nullable
as List<ReportEntry>,drifting: null == drifting ? _self.drifting : drifting // ignore: cast_nullable_to_non_nullable
as List<ReportEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyReport].
extension WeeklyReportPatterns on WeeklyReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyReport value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyReport value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReportEntry> closer,  List<ReportEntry> drifting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
return $default(_that.closer,_that.drifting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReportEntry> closer,  List<ReportEntry> drifting)  $default,) {final _that = this;
switch (_that) {
case _WeeklyReport():
return $default(_that.closer,_that.drifting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReportEntry> closer,  List<ReportEntry> drifting)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
return $default(_that.closer,_that.drifting);case _:
  return null;

}
}

}

/// @nodoc


class _WeeklyReport implements WeeklyReport {
  const _WeeklyReport({required  List<ReportEntry> closer, required  List<ReportEntry> drifting}): _closer = closer,_drifting = drifting;
  

 final  List<ReportEntry> _closer;
@override List<ReportEntry> get closer {
  if (_closer is EqualUnmodifiableListView) return _closer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_closer);
}

 final  List<ReportEntry> _drifting;
@override List<ReportEntry> get drifting {
  if (_drifting is EqualUnmodifiableListView) return _drifting;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drifting);
}


/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyReportCopyWith<_WeeklyReport> get copyWith => __$WeeklyReportCopyWithImpl<_WeeklyReport>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyReport&&const DeepCollectionEquality().equals(other.closer, _closer)&&const DeepCollectionEquality().equals(other.drifting, _drifting));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_closer),const DeepCollectionEquality().hash(_drifting));
}

@override
String toString() {
    return 'WeeklyReport(closer: $closer, drifting: $drifting)';
}


}

/// @nodoc
abstract mixin class _$WeeklyReportCopyWith<$Res> implements $WeeklyReportCopyWith<$Res> {
  factory _$WeeklyReportCopyWith(_WeeklyReport value, $Res Function(_WeeklyReport) _then) = __$WeeklyReportCopyWithImpl;
@override @useResult
$Res call({
 List<ReportEntry> closer, List<ReportEntry> drifting
});




}
/// @nodoc
class __$WeeklyReportCopyWithImpl<$Res>
    implements _$WeeklyReportCopyWith<$Res> {
  __$WeeklyReportCopyWithImpl(this._self, this._then);

  final _WeeklyReport _self;
  final $Res Function(_WeeklyReport) _then;

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? closer = null,Object? drifting = null,}) {
  return _then(_WeeklyReport(
closer: null == closer ? _self._closer : closer // ignore: cast_nullable_to_non_nullable
as List<ReportEntry>,drifting: null == drifting ? _self._drifting : drifting // ignore: cast_nullable_to_non_nullable
as List<ReportEntry>,
  ));
}


}

/// @nodoc
mixin _$ReportEntry {

 Friend get friend;/// Change in closeness over the week, in points.
 int get closenessDelta;
/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportEntryCopyWith<ReportEntry> get copyWith => _$ReportEntryCopyWithImpl<ReportEntry>(this as ReportEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReportEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportEntry&&(identical(other.friend, _this.friend) || other.friend == _this.friend)&&(identical(other.closenessDelta, _this.closenessDelta) || other.closenessDelta == _this.closenessDelta));
}


@override
int get hashCode {
  final _this = this as ReportEntry;
  return Object.hash(runtimeType,_this.friend,_this.closenessDelta);
}

@override
String toString() {
  final _this = this as ReportEntry;
  return 'ReportEntry(friend: ${_this.friend}, closenessDelta: ${_this.closenessDelta})';
}


}

/// @nodoc
abstract mixin class $ReportEntryCopyWith<$Res>  {
  factory $ReportEntryCopyWith(ReportEntry value, $Res Function(ReportEntry) _then) = _$ReportEntryCopyWithImpl;
@useResult
$Res call({
 Friend friend, int closenessDelta
});


$FriendCopyWith<$Res> get friend;

}
/// @nodoc
class _$ReportEntryCopyWithImpl<$Res>
    implements $ReportEntryCopyWith<$Res> {
  _$ReportEntryCopyWithImpl(this._self, this._then);

  final ReportEntry _self;
  final $Res Function(ReportEntry) _then;

/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friend = null,Object? closenessDelta = null,}) {
  return _then(ReportEntry(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as Friend,closenessDelta: null == closenessDelta ? _self.closenessDelta : closenessDelta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendCopyWith<$Res> get friend {
  
  return $FriendCopyWith<$Res>(_self.friend, (value) {
    return _then(_self.copyWith(friend: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportEntry].
extension ReportEntryPatterns on ReportEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportEntry value)  $default,){
final _that = this;
switch (_that) {
case _ReportEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ReportEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Friend friend,  int closenessDelta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportEntry() when $default != null:
return $default(_that.friend,_that.closenessDelta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Friend friend,  int closenessDelta)  $default,) {final _that = this;
switch (_that) {
case _ReportEntry():
return $default(_that.friend,_that.closenessDelta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Friend friend,  int closenessDelta)?  $default,) {final _that = this;
switch (_that) {
case _ReportEntry() when $default != null:
return $default(_that.friend,_that.closenessDelta);case _:
  return null;

}
}

}

/// @nodoc


class _ReportEntry implements ReportEntry {
  const _ReportEntry({required this.friend, required this.closenessDelta});
  

@override final  Friend friend;
/// Change in closeness over the week, in points.
@override final  int closenessDelta;

/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportEntryCopyWith<_ReportEntry> get copyWith => __$ReportEntryCopyWithImpl<_ReportEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportEntry&&(identical(other.friend, friend) || other.friend == friend)&&(identical(other.closenessDelta, closenessDelta) || other.closenessDelta == closenessDelta));
}


@override
int get hashCode {
    return Object.hash(runtimeType,friend,closenessDelta);
}

@override
String toString() {
    return 'ReportEntry(friend: $friend, closenessDelta: $closenessDelta)';
}


}

/// @nodoc
abstract mixin class _$ReportEntryCopyWith<$Res> implements $ReportEntryCopyWith<$Res> {
  factory _$ReportEntryCopyWith(_ReportEntry value, $Res Function(_ReportEntry) _then) = __$ReportEntryCopyWithImpl;
@override @useResult
$Res call({
 Friend friend, int closenessDelta
});


@override $FriendCopyWith<$Res> get friend;

}
/// @nodoc
class __$ReportEntryCopyWithImpl<$Res>
    implements _$ReportEntryCopyWith<$Res> {
  __$ReportEntryCopyWithImpl(this._self, this._then);

  final _ReportEntry _self;
  final $Res Function(_ReportEntry) _then;

/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friend = null,Object? closenessDelta = null,}) {
  return _then(_ReportEntry(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as Friend,closenessDelta: null == closenessDelta ? _self.closenessDelta : closenessDelta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ReportEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendCopyWith<$Res> get friend {
  
  return $FriendCopyWith<$Res>(_self.friend, (value) {
    return _then(_self.copyWith(friend: value));
  });
}
}

// dart format on
