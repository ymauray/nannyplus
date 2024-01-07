// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacation_period.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VacationPeriod _$VacationPeriodFromJson(Map<String, dynamic> json) {
  return _VacationPeriod.fromJson(json);
}

/// @nodoc
mixin _$VacationPeriod {
  int get sortOrder => throw _privateConstructorUsedError;
  String get start => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get end => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VacationPeriodCopyWith<VacationPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VacationPeriodCopyWith<$Res> {
  factory $VacationPeriodCopyWith(
          VacationPeriod value, $Res Function(VacationPeriod) then) =
      _$VacationPeriodCopyWithImpl<$Res, VacationPeriod>;
  @useResult
  $Res call({int sortOrder, String start, int? id, String? end});
}

/// @nodoc
class _$VacationPeriodCopyWithImpl<$Res, $Val extends VacationPeriod>
    implements $VacationPeriodCopyWith<$Res> {
  _$VacationPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortOrder = null,
    Object? start = null,
    Object? id = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VacationPeriodImplCopyWith<$Res>
    implements $VacationPeriodCopyWith<$Res> {
  factory _$$VacationPeriodImplCopyWith(_$VacationPeriodImpl value,
          $Res Function(_$VacationPeriodImpl) then) =
      __$$VacationPeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int sortOrder, String start, int? id, String? end});
}

/// @nodoc
class __$$VacationPeriodImplCopyWithImpl<$Res>
    extends _$VacationPeriodCopyWithImpl<$Res, _$VacationPeriodImpl>
    implements _$$VacationPeriodImplCopyWith<$Res> {
  __$$VacationPeriodImplCopyWithImpl(
      _$VacationPeriodImpl _value, $Res Function(_$VacationPeriodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortOrder = null,
    Object? start = null,
    Object? id = freezed,
    Object? end = freezed,
  }) {
    return _then(_$VacationPeriodImpl(
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VacationPeriodImpl implements _VacationPeriod {
  const _$VacationPeriodImpl(
      {required this.sortOrder, required this.start, this.id, this.end});

  factory _$VacationPeriodImpl.fromJson(Map<String, dynamic> json) =>
      _$$VacationPeriodImplFromJson(json);

  @override
  final int sortOrder;
  @override
  final String start;
  @override
  final int? id;
  @override
  final String? end;

  @override
  String toString() {
    return 'VacationPeriod(sortOrder: $sortOrder, start: $start, id: $id, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VacationPeriodImpl &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sortOrder, start, id, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VacationPeriodImplCopyWith<_$VacationPeriodImpl> get copyWith =>
      __$$VacationPeriodImplCopyWithImpl<_$VacationPeriodImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VacationPeriodImplToJson(
      this,
    );
  }
}

abstract class _VacationPeriod implements VacationPeriod {
  const factory _VacationPeriod(
      {required final int sortOrder,
      required final String start,
      final int? id,
      final String? end}) = _$VacationPeriodImpl;

  factory _VacationPeriod.fromJson(Map<String, dynamic> json) =
      _$VacationPeriodImpl.fromJson;

  @override
  int get sortOrder;
  @override
  String get start;
  @override
  int? get id;
  @override
  String? get end;
  @override
  @JsonKey(ignore: true)
  _$$VacationPeriodImplCopyWith<_$VacationPeriodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
