// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yearly_schedule_pdf_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearlySchedulePdfViewState {

 int get year;
/// Create a copy of YearlySchedulePdfViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YearlySchedulePdfViewStateCopyWith<YearlySchedulePdfViewState> get copyWith => _$YearlySchedulePdfViewStateCopyWithImpl<YearlySchedulePdfViewState>(this as YearlySchedulePdfViewState, _$identity);

  /// Serializes this YearlySchedulePdfViewState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YearlySchedulePdfViewState&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year);

@override
String toString() {
  return 'YearlySchedulePdfViewState(year: $year)';
}


}

/// @nodoc
abstract mixin class $YearlySchedulePdfViewStateCopyWith<$Res>  {
  factory $YearlySchedulePdfViewStateCopyWith(YearlySchedulePdfViewState value, $Res Function(YearlySchedulePdfViewState) _then) = _$YearlySchedulePdfViewStateCopyWithImpl;
@useResult
$Res call({
 int year
});




}
/// @nodoc
class _$YearlySchedulePdfViewStateCopyWithImpl<$Res>
    implements $YearlySchedulePdfViewStateCopyWith<$Res> {
  _$YearlySchedulePdfViewStateCopyWithImpl(this._self, this._then);

  final YearlySchedulePdfViewState _self;
  final $Res Function(YearlySchedulePdfViewState) _then;

/// Create a copy of YearlySchedulePdfViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [YearlySchedulePdfViewState].
extension YearlySchedulePdfViewStatePatterns on YearlySchedulePdfViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YearlySchedulePdfViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YearlySchedulePdfViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YearlySchedulePdfViewState value)  $default,){
final _that = this;
switch (_that) {
case _YearlySchedulePdfViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YearlySchedulePdfViewState value)?  $default,){
final _that = this;
switch (_that) {
case _YearlySchedulePdfViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YearlySchedulePdfViewState() when $default != null:
return $default(_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year)  $default,) {final _that = this;
switch (_that) {
case _YearlySchedulePdfViewState():
return $default(_that.year);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year)?  $default,) {final _that = this;
switch (_that) {
case _YearlySchedulePdfViewState() when $default != null:
return $default(_that.year);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YearlySchedulePdfViewState implements YearlySchedulePdfViewState {
  const _YearlySchedulePdfViewState(this.year);
  factory _YearlySchedulePdfViewState.fromJson(Map<String, dynamic> json) => _$YearlySchedulePdfViewStateFromJson(json);

@override final  int year;

/// Create a copy of YearlySchedulePdfViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YearlySchedulePdfViewStateCopyWith<_YearlySchedulePdfViewState> get copyWith => __$YearlySchedulePdfViewStateCopyWithImpl<_YearlySchedulePdfViewState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YearlySchedulePdfViewStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _YearlySchedulePdfViewState&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year);

@override
String toString() {
  return 'YearlySchedulePdfViewState(year: $year)';
}


}

/// @nodoc
abstract mixin class _$YearlySchedulePdfViewStateCopyWith<$Res> implements $YearlySchedulePdfViewStateCopyWith<$Res> {
  factory _$YearlySchedulePdfViewStateCopyWith(_YearlySchedulePdfViewState value, $Res Function(_YearlySchedulePdfViewState) _then) = __$YearlySchedulePdfViewStateCopyWithImpl;
@override @useResult
$Res call({
 int year
});




}
/// @nodoc
class __$YearlySchedulePdfViewStateCopyWithImpl<$Res>
    implements _$YearlySchedulePdfViewStateCopyWith<$Res> {
  __$YearlySchedulePdfViewStateCopyWithImpl(this._self, this._then);

  final _YearlySchedulePdfViewState _self;
  final $Res Function(_YearlySchedulePdfViewState) _then;

/// Create a copy of YearlySchedulePdfViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,}) {
  return _then(_YearlySchedulePdfViewState(
null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
