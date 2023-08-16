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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_InvoiceFormChildCopyWith<$Res>
    implements $InvoiceFormChildCopyWith<$Res> {
  factory _$$_InvoiceFormChildCopyWith(
          _$_InvoiceFormChild value, $Res Function(_$_InvoiceFormChild) then) =
      __$$_InvoiceFormChildCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Child child, bool selected});
}

/// @nodoc
class __$$_InvoiceFormChildCopyWithImpl<$Res>
    extends _$InvoiceFormChildCopyWithImpl<$Res, _$_InvoiceFormChild>
    implements _$$_InvoiceFormChildCopyWith<$Res> {
  __$$_InvoiceFormChildCopyWithImpl(
      _$_InvoiceFormChild _value, $Res Function(_$_InvoiceFormChild) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? selected = null,
  }) {
    return _then(_$_InvoiceFormChild(
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
class _$_InvoiceFormChild implements _InvoiceFormChild {
  const _$_InvoiceFormChild({required this.child, required this.selected});

  factory _$_InvoiceFormChild.fromJson(Map<String, dynamic> json) =>
      _$$_InvoiceFormChildFromJson(json);

  @override
  final Child child;
  @override
  final bool selected;

  @override
  String toString() {
    return 'InvoiceFormChild(child: $child, selected: $selected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InvoiceFormChild &&
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
  _$$_InvoiceFormChildCopyWith<_$_InvoiceFormChild> get copyWith =>
      __$$_InvoiceFormChildCopyWithImpl<_$_InvoiceFormChild>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InvoiceFormChildToJson(
      this,
    );
  }
}

abstract class _InvoiceFormChild implements InvoiceFormChild {
  const factory _InvoiceFormChild(
      {required final Child child,
      required final bool selected}) = _$_InvoiceFormChild;

  factory _InvoiceFormChild.fromJson(Map<String, dynamic> json) =
      _$_InvoiceFormChild.fromJson;

  @override
  Child get child;
  @override
  bool get selected;
  @override
  @JsonKey(ignore: true)
  _$$_InvoiceFormChildCopyWith<_$_InvoiceFormChild> get copyWith =>
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
abstract class _$$_InvoiceFormStateCopyWith<$Res>
    implements $InvoiceFormStateCopyWith<$Res> {
  factory _$$_InvoiceFormStateCopyWith(
          _$_InvoiceFormState value, $Res Function(_$_InvoiceFormState) then) =
      __$$_InvoiceFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Child child,
      List<InvoiceFormChild> children,
      List<String> months,
      String? selectedMonth});
}

/// @nodoc
class __$$_InvoiceFormStateCopyWithImpl<$Res>
    extends _$InvoiceFormStateCopyWithImpl<$Res, _$_InvoiceFormState>
    implements _$$_InvoiceFormStateCopyWith<$Res> {
  __$$_InvoiceFormStateCopyWithImpl(
      _$_InvoiceFormState _value, $Res Function(_$_InvoiceFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? children = null,
    Object? months = null,
    Object? selectedMonth = freezed,
  }) {
    return _then(_$_InvoiceFormState(
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
class _$_InvoiceFormState implements _InvoiceFormState {
  const _$_InvoiceFormState(
      {required this.child,
      required final List<InvoiceFormChild> children,
      required final List<String> months,
      required this.selectedMonth})
      : _children = children,
        _months = months;

  factory _$_InvoiceFormState.fromJson(Map<String, dynamic> json) =>
      _$$_InvoiceFormStateFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InvoiceFormState &&
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
  _$$_InvoiceFormStateCopyWith<_$_InvoiceFormState> get copyWith =>
      __$$_InvoiceFormStateCopyWithImpl<_$_InvoiceFormState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InvoiceFormStateToJson(
      this,
    );
  }
}

abstract class _InvoiceFormState implements InvoiceFormState {
  const factory _InvoiceFormState(
      {required final Child child,
      required final List<InvoiceFormChild> children,
      required final List<String> months,
      required final String? selectedMonth}) = _$_InvoiceFormState;

  factory _InvoiceFormState.fromJson(Map<String, dynamic> json) =
      _$_InvoiceFormState.fromJson;

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
  _$$_InvoiceFormStateCopyWith<_$_InvoiceFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
