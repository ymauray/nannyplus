// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_form_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InvoiceFormChild _$InvoiceFormChildFromJson(Map<String, dynamic> json) {
  return _InvoiceFormChild.fromJson(json);
}

/// @nodoc
mixin _$InvoiceFormChild {
  Child get child => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceFormChildCopyWith<InvoiceFormChild> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceFormChildCopyWith<$Res> {
  factory $InvoiceFormChildCopyWith(
          InvoiceFormChild value, $Res Function(InvoiceFormChild) then) =
      _$InvoiceFormChildCopyWithImpl<$Res, InvoiceFormChild>;
  @useResult
  $Res call({Child child, bool selected});
}

/// @nodoc
class _$InvoiceFormChildCopyWithImpl<$Res, $Val extends InvoiceFormChild>
    implements $InvoiceFormChildCopyWith<$Res> {
  _$InvoiceFormChildCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? selected = null,
  }) {
    return _then(_value.copyWith(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceFormChildImplCopyWith<$Res>
    implements $InvoiceFormChildCopyWith<$Res> {
  factory _$$InvoiceFormChildImplCopyWith(_$InvoiceFormChildImpl value,
          $Res Function(_$InvoiceFormChildImpl) then) =
      __$$InvoiceFormChildImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Child child, bool selected});
}

/// @nodoc
class __$$InvoiceFormChildImplCopyWithImpl<$Res>
    extends _$InvoiceFormChildCopyWithImpl<$Res, _$InvoiceFormChildImpl>
    implements _$$InvoiceFormChildImplCopyWith<$Res> {
  __$$InvoiceFormChildImplCopyWithImpl(_$InvoiceFormChildImpl _value,
      $Res Function(_$InvoiceFormChildImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? selected = null,
  }) {
    return _then(_$InvoiceFormChildImpl(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceFormChildImpl implements _InvoiceFormChild {
  const _$InvoiceFormChildImpl({required this.child, required this.selected});

  factory _$InvoiceFormChildImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceFormChildImplFromJson(json);

  @override
  final Child child;
  @override
  final bool selected;

  @override
  String toString() {
    return 'InvoiceFormChild(child: $child, selected: $selected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceFormChildImpl &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, child, selected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceFormChildImplCopyWith<_$InvoiceFormChildImpl> get copyWith =>
      __$$InvoiceFormChildImplCopyWithImpl<_$InvoiceFormChildImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceFormChildImplToJson(
      this,
    );
  }
}

abstract class _InvoiceFormChild implements InvoiceFormChild {
  const factory _InvoiceFormChild(
      {required final Child child,
      required final bool selected}) = _$InvoiceFormChildImpl;

  factory _InvoiceFormChild.fromJson(Map<String, dynamic> json) =
      _$InvoiceFormChildImpl.fromJson;

  @override
  Child get child;
  @override
  bool get selected;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceFormChildImplCopyWith<_$InvoiceFormChildImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoiceFormState _$InvoiceFormStateFromJson(Map<String, dynamic> json) {
  return _InvoiceFormState.fromJson(json);
}

/// @nodoc
mixin _$InvoiceFormState {
  Child get child => throw _privateConstructorUsedError;
  List<InvoiceFormChild> get children => throw _privateConstructorUsedError;
  List<String> get months => throw _privateConstructorUsedError;
  String? get selectedMonth => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceFormStateCopyWith<InvoiceFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceFormStateCopyWith<$Res> {
  factory $InvoiceFormStateCopyWith(
          InvoiceFormState value, $Res Function(InvoiceFormState) then) =
      _$InvoiceFormStateCopyWithImpl<$Res, InvoiceFormState>;
  @useResult
  $Res call(
      {Child child,
      List<InvoiceFormChild> children,
      List<String> months,
      String? selectedMonth});
}

/// @nodoc
class _$InvoiceFormStateCopyWithImpl<$Res, $Val extends InvoiceFormState>
    implements $InvoiceFormStateCopyWith<$Res> {
  _$InvoiceFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? children = null,
    Object? months = null,
    Object? selectedMonth = freezed,
  }) {
    return _then(_value.copyWith(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<InvoiceFormChild>,
      months: null == months
          ? _value.months
          : months // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedMonth: freezed == selectedMonth
          ? _value.selectedMonth
          : selectedMonth // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceFormStateImplCopyWith<$Res>
    implements $InvoiceFormStateCopyWith<$Res> {
  factory _$$InvoiceFormStateImplCopyWith(_$InvoiceFormStateImpl value,
          $Res Function(_$InvoiceFormStateImpl) then) =
      __$$InvoiceFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Child child,
      List<InvoiceFormChild> children,
      List<String> months,
      String? selectedMonth});
}

/// @nodoc
class __$$InvoiceFormStateImplCopyWithImpl<$Res>
    extends _$InvoiceFormStateCopyWithImpl<$Res, _$InvoiceFormStateImpl>
    implements _$$InvoiceFormStateImplCopyWith<$Res> {
  __$$InvoiceFormStateImplCopyWithImpl(_$InvoiceFormStateImpl _value,
      $Res Function(_$InvoiceFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? children = null,
    Object? months = null,
    Object? selectedMonth = freezed,
  }) {
    return _then(_$InvoiceFormStateImpl(
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<InvoiceFormChild>,
      months: null == months
          ? _value._months
          : months // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedMonth: freezed == selectedMonth
          ? _value.selectedMonth
          : selectedMonth // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceFormStateImpl implements _InvoiceFormState {
  const _$InvoiceFormStateImpl(
      {required this.child,
      required final List<InvoiceFormChild> children,
      required final List<String> months,
      required this.selectedMonth})
      : _children = children,
        _months = months;

  factory _$InvoiceFormStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceFormStateImplFromJson(json);

  @override
  final Child child;
  final List<InvoiceFormChild> _children;
  @override
  List<InvoiceFormChild> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final List<String> _months;
  @override
  List<String> get months {
    if (_months is EqualUnmodifiableListView) return _months;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_months);
  }

  @override
  final String? selectedMonth;

  @override
  String toString() {
    return 'InvoiceFormState(child: $child, children: $children, months: $months, selectedMonth: $selectedMonth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceFormStateImpl &&
            (identical(other.child, child) || other.child == child) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            const DeepCollectionEquality().equals(other._months, _months) &&
            (identical(other.selectedMonth, selectedMonth) ||
                other.selectedMonth == selectedMonth));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      child,
      const DeepCollectionEquality().hash(_children),
      const DeepCollectionEquality().hash(_months),
      selectedMonth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceFormStateImplCopyWith<_$InvoiceFormStateImpl> get copyWith =>
      __$$InvoiceFormStateImplCopyWithImpl<_$InvoiceFormStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceFormStateImplToJson(
      this,
    );
  }
}

abstract class _InvoiceFormState implements InvoiceFormState {
  const factory _InvoiceFormState(
      {required final Child child,
      required final List<InvoiceFormChild> children,
      required final List<String> months,
      required final String? selectedMonth}) = _$InvoiceFormStateImpl;

  factory _InvoiceFormState.fromJson(Map<String, dynamic> json) =
      _$InvoiceFormStateImpl.fromJson;

  @override
  Child get child;
  @override
  List<InvoiceFormChild> get children;
  @override
  List<String> get months;
  @override
  String? get selectedMonth;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceFormStateImplCopyWith<_$InvoiceFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
