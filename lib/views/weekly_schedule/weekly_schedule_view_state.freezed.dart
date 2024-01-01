// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_schedule_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeeklyScheduleViewState {
  int get index => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeeklyScheduleViewStateCopyWith<WeeklyScheduleViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyScheduleViewStateCopyWith<$Res> {
  factory $WeeklyScheduleViewStateCopyWith(WeeklyScheduleViewState value,
          $Res Function(WeeklyScheduleViewState) then) =
      _$WeeklyScheduleViewStateCopyWithImpl<$Res, WeeklyScheduleViewState>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class _$WeeklyScheduleViewStateCopyWithImpl<$Res,
        $Val extends WeeklyScheduleViewState>
    implements $WeeklyScheduleViewStateCopyWith<$Res> {
  _$WeeklyScheduleViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeeklyScheduleViewStateImplCopyWith<$Res>
    implements $WeeklyScheduleViewStateCopyWith<$Res> {
  factory _$$WeeklyScheduleViewStateImplCopyWith(
          _$WeeklyScheduleViewStateImpl value,
          $Res Function(_$WeeklyScheduleViewStateImpl) then) =
      __$$WeeklyScheduleViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$WeeklyScheduleViewStateImplCopyWithImpl<$Res>
    extends _$WeeklyScheduleViewStateCopyWithImpl<$Res,
        _$WeeklyScheduleViewStateImpl>
    implements _$$WeeklyScheduleViewStateImplCopyWith<$Res> {
  __$$WeeklyScheduleViewStateImplCopyWithImpl(
      _$WeeklyScheduleViewStateImpl _value,
      $Res Function(_$WeeklyScheduleViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$WeeklyScheduleViewStateImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$WeeklyScheduleViewStateImpl extends _WeeklyScheduleViewState {
  const _$WeeklyScheduleViewStateImpl({required this.index}) : super._();

  @override
  final int index;

  @override
  String toString() {
    return 'WeeklyScheduleViewState(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyScheduleViewStateImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyScheduleViewStateImplCopyWith<_$WeeklyScheduleViewStateImpl>
      get copyWith => __$$WeeklyScheduleViewStateImplCopyWithImpl<
          _$WeeklyScheduleViewStateImpl>(this, _$identity);
}

abstract class _WeeklyScheduleViewState extends WeeklyScheduleViewState {
  const factory _WeeklyScheduleViewState({required final int index}) =
      _$WeeklyScheduleViewStateImpl;
  const _WeeklyScheduleViewState._() : super._();

  @override
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$WeeklyScheduleViewStateImplCopyWith<_$WeeklyScheduleViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
