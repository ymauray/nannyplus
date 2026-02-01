// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deduction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Deduction {
  int? get id;
  int? get sortOrder;
  String get label;
  double get value;
  String get type;
  String get periodicity;

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeductionCopyWith<Deduction> get copyWith =>
      _$DeductionCopyWithImpl<Deduction>(this as Deduction, _$identity);

  /// Serializes this Deduction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Deduction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.periodicity, periodicity) ||
                other.periodicity == periodicity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, sortOrder, label, value, type, periodicity);

  @override
  String toString() {
    return 'Deduction(id: $id, sortOrder: $sortOrder, label: $label, value: $value, type: $type, periodicity: $periodicity)';
  }
}

/// @nodoc
abstract mixin class $DeductionCopyWith<$Res> {
  factory $DeductionCopyWith(Deduction value, $Res Function(Deduction) _then) =
      _$DeductionCopyWithImpl;
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
class _$DeductionCopyWithImpl<$Res> implements $DeductionCopyWith<$Res> {
  _$DeductionCopyWithImpl(this._self, this._then);

  final Deduction _self;
  final $Res Function(Deduction) _then;

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sortOrder: freezed == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      periodicity: null == periodicity
          ? _self.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Deduction].
extension DeductionPatterns on Deduction {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Deduction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Deduction() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Deduction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Deduction():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Deduction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Deduction() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? id, int? sortOrder, String label, double value,
            String type, String periodicity)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Deduction() when $default != null:
        return $default(_that.id, _that.sortOrder, _that.label, _that.value,
            _that.type, _that.periodicity);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? id, int? sortOrder, String label, double value,
            String type, String periodicity)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Deduction():
        return $default(_that.id, _that.sortOrder, _that.label, _that.value,
            _that.type, _that.periodicity);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? id, int? sortOrder, String label, double value,
            String type, String periodicity)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Deduction() when $default != null:
        return $default(_that.id, _that.sortOrder, _that.label, _that.value,
            _that.type, _that.periodicity);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Deduction implements Deduction {
  _Deduction(
      {required this.id,
      required this.sortOrder,
      required this.label,
      required this.value,
      required this.type,
      required this.periodicity});
  factory _Deduction.fromJson(Map<String, dynamic> json) =>
      _$DeductionFromJson(json);

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

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeductionCopyWith<_Deduction> get copyWith =>
      __$DeductionCopyWithImpl<_Deduction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DeductionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Deduction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.periodicity, periodicity) ||
                other.periodicity == periodicity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, sortOrder, label, value, type, periodicity);

  @override
  String toString() {
    return 'Deduction(id: $id, sortOrder: $sortOrder, label: $label, value: $value, type: $type, periodicity: $periodicity)';
  }
}

/// @nodoc
abstract mixin class _$DeductionCopyWith<$Res>
    implements $DeductionCopyWith<$Res> {
  factory _$DeductionCopyWith(
          _Deduction value, $Res Function(_Deduction) _then) =
      __$DeductionCopyWithImpl;
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
class __$DeductionCopyWithImpl<$Res> implements _$DeductionCopyWith<$Res> {
  __$DeductionCopyWithImpl(this._self, this._then);

  final _Deduction _self;
  final $Res Function(_Deduction) _then;

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? label = null,
    Object? value = null,
    Object? type = null,
    Object? periodicity = null,
  }) {
    return _then(_Deduction(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sortOrder: freezed == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      periodicity: null == periodicity
          ? _self.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
