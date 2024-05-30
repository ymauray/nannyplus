// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deduction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Deduction _$DeductionFromJson(Map<String, dynamic> json) {
  return _Deduction.fromJson(json);
}

/// @nodoc
mixin _$Deduction {
  int? get id => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get periodicity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeductionCopyWith<Deduction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeductionCopyWith<$Res> {
  factory $DeductionCopyWith(Deduction value, $Res Function(Deduction) then) =
      _$DeductionCopyWithImpl<$Res, Deduction>;
  @useResult
  $Res call(
      {int? id,
      int? sortOrder,
      String label,
      double value,
      String type,
      String periodicity});
}

/// @nodoc
class _$DeductionCopyWithImpl<$Res, $Val extends Deduction>
    implements $DeductionCopyWith<$Res> {
  _$DeductionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? label = null,
    Object? value = null,
    Object? type = null,
    Object? periodicity = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sortOrder: freezed == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      periodicity: null == periodicity
          ? _value.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeductionImplCopyWith<$Res>
    implements $DeductionCopyWith<$Res> {
  factory _$$DeductionImplCopyWith(
          _$DeductionImpl value, $Res Function(_$DeductionImpl) then) =
      __$$DeductionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? sortOrder,
      String label,
      double value,
      String type,
      String periodicity});
}

/// @nodoc
class __$$DeductionImplCopyWithImpl<$Res>
    extends _$DeductionCopyWithImpl<$Res, _$DeductionImpl>
    implements _$$DeductionImplCopyWith<$Res> {
  __$$DeductionImplCopyWithImpl(
      _$DeductionImpl _value, $Res Function(_$DeductionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? label = null,
    Object? value = null,
    Object? type = null,
    Object? periodicity = null,
  }) {
    return _then(_$DeductionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sortOrder: freezed == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      periodicity: null == periodicity
          ? _value.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeductionImpl implements _Deduction {
  _$DeductionImpl(
      {required this.id,
      required this.sortOrder,
      required this.label,
      required this.value,
      required this.type,
      required this.periodicity});

  factory _$DeductionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeductionImplFromJson(json);

  @override
  final int? id;
  @override
  final int? sortOrder;
  @override
  final String label;
  @override
  final double value;
  @override
  final String type;
  @override
  final String periodicity;

  @override
  String toString() {
    return 'Deduction(id: $id, sortOrder: $sortOrder, label: $label, value: $value, type: $type, periodicity: $periodicity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeductionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.periodicity, periodicity) ||
                other.periodicity == periodicity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, sortOrder, label, value, type, periodicity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeductionImplCopyWith<_$DeductionImpl> get copyWith =>
      __$$DeductionImplCopyWithImpl<_$DeductionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeductionImplToJson(
      this,
    );
  }
}

abstract class _Deduction implements Deduction {
  factory _Deduction(
      {required final int? id,
      required final int? sortOrder,
      required final String label,
      required final double value,
      required final String type,
      required final String periodicity}) = _$DeductionImpl;

  factory _Deduction.fromJson(Map<String, dynamic> json) =
      _$DeductionImpl.fromJson;

  @override
  int? get id;
  @override
  int? get sortOrder;
  @override
  String get label;
  @override
  double get value;
  @override
  String get type;
  @override
  String get periodicity;
  @override
  @JsonKey(ignore: true)
  _$$DeductionImplCopyWith<_$DeductionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
