// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Planning _$PlanningFromJson(Map<String, dynamic> json) {
  return _Planning.fromJson(json);
}

/// @nodoc
mixin _$Planning {
  int get id => throw _privateConstructorUsedError;
  String? get planningStart => throw _privateConstructorUsedError;
  String? get planningEnd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlanningCopyWith<Planning> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanningCopyWith<$Res> {
  factory $PlanningCopyWith(Planning value, $Res Function(Planning) then) =
      _$PlanningCopyWithImpl<$Res, Planning>;
  @useResult
  $Res call({int id, String? planningStart, String? planningEnd});
}

/// @nodoc
class _$PlanningCopyWithImpl<$Res, $Val extends Planning>
    implements $PlanningCopyWith<$Res> {
  _$PlanningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? planningStart = freezed,
    Object? planningEnd = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      planningStart: freezed == planningStart
          ? _value.planningStart
          : planningStart // ignore: cast_nullable_to_non_nullable
              as String?,
      planningEnd: freezed == planningEnd
          ? _value.planningEnd
          : planningEnd // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanningImplCopyWith<$Res>
    implements $PlanningCopyWith<$Res> {
  factory _$$PlanningImplCopyWith(
          _$PlanningImpl value, $Res Function(_$PlanningImpl) then) =
      __$$PlanningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? planningStart, String? planningEnd});
}

/// @nodoc
class __$$PlanningImplCopyWithImpl<$Res>
    extends _$PlanningCopyWithImpl<$Res, _$PlanningImpl>
    implements _$$PlanningImplCopyWith<$Res> {
  __$$PlanningImplCopyWithImpl(
      _$PlanningImpl _value, $Res Function(_$PlanningImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? planningStart = freezed,
    Object? planningEnd = freezed,
  }) {
    return _then(_$PlanningImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      planningStart: freezed == planningStart
          ? _value.planningStart
          : planningStart // ignore: cast_nullable_to_non_nullable
              as String?,
      planningEnd: freezed == planningEnd
          ? _value.planningEnd
          : planningEnd // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanningImpl implements _Planning {
  const _$PlanningImpl(
      {required this.id,
      required this.planningStart,
      required this.planningEnd});

  factory _$PlanningImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanningImplFromJson(json);

  @override
  final int id;
  @override
  final String? planningStart;
  @override
  final String? planningEnd;

  @override
  String toString() {
    return 'Planning(id: $id, planningStart: $planningStart, planningEnd: $planningEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanningImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.planningStart, planningStart) ||
                other.planningStart == planningStart) &&
            (identical(other.planningEnd, planningEnd) ||
                other.planningEnd == planningEnd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, planningStart, planningEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanningImplCopyWith<_$PlanningImpl> get copyWith =>
      __$$PlanningImplCopyWithImpl<_$PlanningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanningImplToJson(
      this,
    );
  }
}

abstract class _Planning implements Planning {
  const factory _Planning(
      {required final int id,
      required final String? planningStart,
      required final String? planningEnd}) = _$PlanningImpl;

  factory _Planning.fromJson(Map<String, dynamic> json) =
      _$PlanningImpl.fromJson;

  @override
  int get id;
  @override
  String? get planningStart;
  @override
  String? get planningEnd;
  @override
  @JsonKey(ignore: true)
  _$$PlanningImplCopyWith<_$PlanningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
