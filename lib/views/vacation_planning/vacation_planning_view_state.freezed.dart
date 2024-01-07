// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacation_planning_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VacationPlanningViewState _$VacationPlanningViewStateFromJson(
    Map<String, dynamic> json) {
  return _VacationPlanningViewState.fromJson(json);
}

/// @nodoc
mixin _$VacationPlanningViewState {
  int get year => throw _privateConstructorUsedError;
  List<VacationPeriod> get periods => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VacationPlanningViewStateCopyWith<VacationPlanningViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VacationPlanningViewStateCopyWith<$Res> {
  factory $VacationPlanningViewStateCopyWith(VacationPlanningViewState value,
          $Res Function(VacationPlanningViewState) then) =
      _$VacationPlanningViewStateCopyWithImpl<$Res, VacationPlanningViewState>;
  @useResult
  $Res call({int year, List<VacationPeriod> periods});
}

/// @nodoc
class _$VacationPlanningViewStateCopyWithImpl<$Res,
        $Val extends VacationPlanningViewState>
    implements $VacationPlanningViewStateCopyWith<$Res> {
  _$VacationPlanningViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? periods = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      periods: null == periods
          ? _value.periods
          : periods // ignore: cast_nullable_to_non_nullable
              as List<VacationPeriod>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VacationPlanningViewStateImplCopyWith<$Res>
    implements $VacationPlanningViewStateCopyWith<$Res> {
  factory _$$VacationPlanningViewStateImplCopyWith(
          _$VacationPlanningViewStateImpl value,
          $Res Function(_$VacationPlanningViewStateImpl) then) =
      __$$VacationPlanningViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year, List<VacationPeriod> periods});
}

/// @nodoc
class __$$VacationPlanningViewStateImplCopyWithImpl<$Res>
    extends _$VacationPlanningViewStateCopyWithImpl<$Res,
        _$VacationPlanningViewStateImpl>
    implements _$$VacationPlanningViewStateImplCopyWith<$Res> {
  __$$VacationPlanningViewStateImplCopyWithImpl(
      _$VacationPlanningViewStateImpl _value,
      $Res Function(_$VacationPlanningViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? periods = null,
  }) {
    return _then(_$VacationPlanningViewStateImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      periods: null == periods
          ? _value._periods
          : periods // ignore: cast_nullable_to_non_nullable
              as List<VacationPeriod>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VacationPlanningViewStateImpl implements _VacationPlanningViewState {
  const _$VacationPlanningViewStateImpl(
      {required this.year, required final List<VacationPeriod> periods})
      : _periods = periods;

  factory _$VacationPlanningViewStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$VacationPlanningViewStateImplFromJson(json);

  @override
  final int year;
  final List<VacationPeriod> _periods;
  @override
  List<VacationPeriod> get periods {
    if (_periods is EqualUnmodifiableListView) return _periods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_periods);
  }

  @override
  String toString() {
    return 'VacationPlanningViewState(year: $year, periods: $periods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VacationPlanningViewStateImpl &&
            (identical(other.year, year) || other.year == year) &&
            const DeepCollectionEquality().equals(other._periods, _periods));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, year, const DeepCollectionEquality().hash(_periods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VacationPlanningViewStateImplCopyWith<_$VacationPlanningViewStateImpl>
      get copyWith => __$$VacationPlanningViewStateImplCopyWithImpl<
          _$VacationPlanningViewStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VacationPlanningViewStateImplToJson(
      this,
    );
  }
}

abstract class _VacationPlanningViewState implements VacationPlanningViewState {
  const factory _VacationPlanningViewState(
          {required final int year,
          required final List<VacationPeriod> periods}) =
      _$VacationPlanningViewStateImpl;

  factory _VacationPlanningViewState.fromJson(Map<String, dynamic> json) =
      _$VacationPlanningViewStateImpl.fromJson;

  @override
  int get year;
  @override
  List<VacationPeriod> get periods;
  @override
  @JsonKey(ignore: true)
  _$$VacationPlanningViewStateImplCopyWith<_$VacationPlanningViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
