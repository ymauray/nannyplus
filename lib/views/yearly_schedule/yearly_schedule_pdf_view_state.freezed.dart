// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yearly_schedule_pdf_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

YearlySchedulePdfViewState _$YearlySchedulePdfViewStateFromJson(
    Map<String, dynamic> json) {
  return _YearlySchedulePdfViewState.fromJson(json);
}

/// @nodoc
mixin _$YearlySchedulePdfViewState {
  int get year => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YearlySchedulePdfViewStateCopyWith<YearlySchedulePdfViewState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearlySchedulePdfViewStateCopyWith<$Res> {
  factory $YearlySchedulePdfViewStateCopyWith(YearlySchedulePdfViewState value,
          $Res Function(YearlySchedulePdfViewState) then) =
      _$YearlySchedulePdfViewStateCopyWithImpl<$Res,
          YearlySchedulePdfViewState>;
  @useResult
  $Res call({int year});
}

/// @nodoc
class _$YearlySchedulePdfViewStateCopyWithImpl<$Res,
        $Val extends YearlySchedulePdfViewState>
    implements $YearlySchedulePdfViewStateCopyWith<$Res> {
  _$YearlySchedulePdfViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YearlySchedulePdfViewStateImplCopyWith<$Res>
    implements $YearlySchedulePdfViewStateCopyWith<$Res> {
  factory _$$YearlySchedulePdfViewStateImplCopyWith(
          _$YearlySchedulePdfViewStateImpl value,
          $Res Function(_$YearlySchedulePdfViewStateImpl) then) =
      __$$YearlySchedulePdfViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year});
}

/// @nodoc
class __$$YearlySchedulePdfViewStateImplCopyWithImpl<$Res>
    extends _$YearlySchedulePdfViewStateCopyWithImpl<$Res,
        _$YearlySchedulePdfViewStateImpl>
    implements _$$YearlySchedulePdfViewStateImplCopyWith<$Res> {
  __$$YearlySchedulePdfViewStateImplCopyWithImpl(
      _$YearlySchedulePdfViewStateImpl _value,
      $Res Function(_$YearlySchedulePdfViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
  }) {
    return _then(_$YearlySchedulePdfViewStateImpl(
      null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YearlySchedulePdfViewStateImpl implements _YearlySchedulePdfViewState {
  const _$YearlySchedulePdfViewStateImpl(this.year);

  factory _$YearlySchedulePdfViewStateImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$YearlySchedulePdfViewStateImplFromJson(json);

  @override
  final int year;

  @override
  String toString() {
    return 'YearlySchedulePdfViewState(year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearlySchedulePdfViewStateImpl &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, year);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YearlySchedulePdfViewStateImplCopyWith<_$YearlySchedulePdfViewStateImpl>
      get copyWith => __$$YearlySchedulePdfViewStateImplCopyWithImpl<
          _$YearlySchedulePdfViewStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlySchedulePdfViewStateImplToJson(
      this,
    );
  }
}

abstract class _YearlySchedulePdfViewState
    implements YearlySchedulePdfViewState {
  const factory _YearlySchedulePdfViewState(final int year) =
      _$YearlySchedulePdfViewStateImpl;

  factory _YearlySchedulePdfViewState.fromJson(Map<String, dynamic> json) =
      _$YearlySchedulePdfViewStateImpl.fromJson;

  @override
  int get year;
  @override
  @JsonKey(ignore: true)
  _$$YearlySchedulePdfViewStateImplCopyWith<_$YearlySchedulePdfViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
