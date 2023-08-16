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
