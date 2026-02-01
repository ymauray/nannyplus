// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacation_planning_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VacationPlanningViewState {

 int get year; List<VacationPeriod> get periods;
/// Create a copy of VacationPlanningViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VacationPlanningViewStateCopyWith<VacationPlanningViewState> get copyWith => _$VacationPlanningViewStateCopyWithImpl<VacationPlanningViewState>(this as VacationPlanningViewState, _$identity);

  /// Serializes this VacationPlanningViewState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VacationPlanningViewState&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other.periods, periods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,const DeepCollectionEquality().hash(periods));

@override
String toString() {
  return 'VacationPlanningViewState(year: $year, periods: $periods)';
}


}

/// @nodoc
abstract mixin class $VacationPlanningViewStateCopyWith<$Res>  {
  factory $VacationPlanningViewStateCopyWith(VacationPlanningViewState value, $Res Function(VacationPlanningViewState) _then) = _$VacationPlanningViewStateCopyWithImpl;
@useResult
$Res call({
 int year, List<VacationPeriod> periods
});




}
/// @nodoc
class _$VacationPlanningViewStateCopyWithImpl<$Res>
    implements $VacationPlanningViewStateCopyWith<$Res> {
  _$VacationPlanningViewStateCopyWithImpl(this._self, this._then);

  final VacationPlanningViewState _self;
  final $Res Function(VacationPlanningViewState) _then;

/// Create a copy of VacationPlanningViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? periods = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<VacationPeriod>,
  ));
}

}


/// Adds pattern-matching-related methods to [VacationPlanningViewState].
extension VacationPlanningViewStatePatterns on VacationPlanningViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VacationPlanningViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VacationPlanningViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VacationPlanningViewState value)  $default,){
final _that = this;
switch (_that) {
case _VacationPlanningViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VacationPlanningViewState value)?  $default,){
final _that = this;
switch (_that) {
case _VacationPlanningViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  List<VacationPeriod> periods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VacationPlanningViewState() when $default != null:
return $default(_that.year,_that.periods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  List<VacationPeriod> periods)  $default,) {final _that = this;
switch (_that) {
case _VacationPlanningViewState():
return $default(_that.year,_that.periods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  List<VacationPeriod> periods)?  $default,) {final _that = this;
switch (_that) {
case _VacationPlanningViewState() when $default != null:
return $default(_that.year,_that.periods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VacationPlanningViewState implements VacationPlanningViewState {
  const _VacationPlanningViewState({required this.year, required final  List<VacationPeriod> periods}): _periods = periods;
  factory _VacationPlanningViewState.fromJson(Map<String, dynamic> json) => _$VacationPlanningViewStateFromJson(json);

@override final  int year;
 final  List<VacationPeriod> _periods;
@override List<VacationPeriod> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}


/// Create a copy of VacationPlanningViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VacationPlanningViewStateCopyWith<_VacationPlanningViewState> get copyWith => __$VacationPlanningViewStateCopyWithImpl<_VacationPlanningViewState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VacationPlanningViewStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VacationPlanningViewState&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other._periods, _periods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,const DeepCollectionEquality().hash(_periods));

@override
String toString() {
  return 'VacationPlanningViewState(year: $year, periods: $periods)';
}


}

/// @nodoc
abstract mixin class _$VacationPlanningViewStateCopyWith<$Res> implements $VacationPlanningViewStateCopyWith<$Res> {
  factory _$VacationPlanningViewStateCopyWith(_VacationPlanningViewState value, $Res Function(_VacationPlanningViewState) _then) = __$VacationPlanningViewStateCopyWithImpl;
@override @useResult
$Res call({
 int year, List<VacationPeriod> periods
});




}
/// @nodoc
class __$VacationPlanningViewStateCopyWithImpl<$Res>
    implements _$VacationPlanningViewStateCopyWith<$Res> {
  __$VacationPlanningViewStateCopyWithImpl(this._self, this._then);

  final _VacationPlanningViewState _self;
  final $Res Function(_VacationPlanningViewState) _then;

/// Create a copy of VacationPlanningViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? periods = null,}) {
  return _then(_VacationPlanningViewState(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<VacationPeriod>,
  ));
}


}

// dart format on
