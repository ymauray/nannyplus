// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_color.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleColor _$ScheduleColorFromJson(Map<String, dynamic> json) {
  return _ScheduleColor.fromJson(json);
}

/// @nodoc
mixin _$ScheduleColor {
  int get id => throw _privateConstructorUsedError;
  int get childId => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleColorCopyWith<ScheduleColor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleColorCopyWith<$Res> {
  factory $ScheduleColorCopyWith(
          ScheduleColor value, $Res Function(ScheduleColor) then) =
      _$ScheduleColorCopyWithImpl<$Res, ScheduleColor>;
  @useResult
  $Res call({int id, int childId, int color});
}

/// @nodoc
class _$ScheduleColorCopyWithImpl<$Res, $Val extends ScheduleColor>
    implements $ScheduleColorCopyWith<$Res> {
  _$ScheduleColorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduleColorImplCopyWith<$Res>
    implements $ScheduleColorCopyWith<$Res> {
  factory _$$ScheduleColorImplCopyWith(
          _$ScheduleColorImpl value, $Res Function(_$ScheduleColorImpl) then) =
      __$$ScheduleColorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int childId, int color});
}

/// @nodoc
class __$$ScheduleColorImplCopyWithImpl<$Res>
    extends _$ScheduleColorCopyWithImpl<$Res, _$ScheduleColorImpl>
    implements _$$ScheduleColorImplCopyWith<$Res> {
  __$$ScheduleColorImplCopyWithImpl(
      _$ScheduleColorImpl _value, $Res Function(_$ScheduleColorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? color = null,
  }) {
    return _then(_$ScheduleColorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleColorImpl implements _ScheduleColor {
  _$ScheduleColorImpl(
      {required this.id, required this.childId, required this.color});

  factory _$ScheduleColorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleColorImplFromJson(json);

  @override
  final int id;
  @override
  final int childId;
  @override
  final int color;

  @override
  String toString() {
    return 'ScheduleColor(id: $id, childId: $childId, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleColorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, childId, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleColorImplCopyWith<_$ScheduleColorImpl> get copyWith =>
      __$$ScheduleColorImplCopyWithImpl<_$ScheduleColorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleColorImplToJson(
      this,
    );
  }
}

abstract class _ScheduleColor implements ScheduleColor {
  factory _ScheduleColor(
      {required final int id,
      required final int childId,
      required final int color}) = _$ScheduleColorImpl;

  factory _ScheduleColor.fromJson(Map<String, dynamic> json) =
      _$ScheduleColorImpl.fromJson;

  @override
  int get id;
  @override
  int get childId;
  @override
  int get color;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleColorImplCopyWith<_$ScheduleColorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
