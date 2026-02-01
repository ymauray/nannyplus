// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacation_period.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VacationPeriod {
  int get sortOrder;
  String get start;
  int? get id;
  String? get end;

  /// Create a copy of VacationPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VacationPeriodCopyWith<VacationPeriod> get copyWith =>
      _$VacationPeriodCopyWithImpl<VacationPeriod>(
          this as VacationPeriod, _$identity);

  /// Serializes this VacationPeriod to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VacationPeriod &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sortOrder, start, id, end);

  @override
  String toString() {
    return 'VacationPeriod(sortOrder: $sortOrder, start: $start, id: $id, end: $end)';
  }
}

/// @nodoc
abstract mixin class $VacationPeriodCopyWith<$Res> {
  factory $VacationPeriodCopyWith(
          VacationPeriod value, $Res Function(VacationPeriod) _then) =
      _$VacationPeriodCopyWithImpl;
  @useResult
  $Res call({int sortOrder, String start, int? id, String? end});
}

/// @nodoc
class _$VacationPeriodCopyWithImpl<$Res>
    implements $VacationPeriodCopyWith<$Res> {
  _$VacationPeriodCopyWithImpl(this._self, this._then);

  final VacationPeriod _self;
  final $Res Function(VacationPeriod) _then;

  /// Create a copy of VacationPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortOrder = null,
    Object? start = null,
    Object? id = freezed,
    Object? end = freezed,
  }) {
    return _then(_self.copyWith(
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      end: freezed == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VacationPeriod].
extension VacationPeriodPatterns on VacationPeriod {
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
    TResult Function(_VacationPeriod value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VacationPeriod() when $default != null:
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
    TResult Function(_VacationPeriod value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VacationPeriod():
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
    TResult? Function(_VacationPeriod value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VacationPeriod() when $default != null:
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
    TResult Function(int sortOrder, String start, int? id, String? end)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VacationPeriod() when $default != null:
        return $default(_that.sortOrder, _that.start, _that.id, _that.end);
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
    TResult Function(int sortOrder, String start, int? id, String? end)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VacationPeriod():
        return $default(_that.sortOrder, _that.start, _that.id, _that.end);
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
    TResult? Function(int sortOrder, String start, int? id, String? end)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VacationPeriod() when $default != null:
        return $default(_that.sortOrder, _that.start, _that.id, _that.end);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VacationPeriod implements VacationPeriod {
  const _VacationPeriod(
      {required this.sortOrder, required this.start, this.id, this.end});
  factory _VacationPeriod.fromJson(Map<String, dynamic> json) =>
      _$VacationPeriodFromJson(json);

  @override
  final int sortOrder;
  @override
  final String start;
  @override
  final int? id;
  @override
  final String? end;

  /// Create a copy of VacationPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VacationPeriodCopyWith<_VacationPeriod> get copyWith =>
      __$VacationPeriodCopyWithImpl<_VacationPeriod>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VacationPeriodToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VacationPeriod &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sortOrder, start, id, end);

  @override
  String toString() {
    return 'VacationPeriod(sortOrder: $sortOrder, start: $start, id: $id, end: $end)';
  }
}

/// @nodoc
abstract mixin class _$VacationPeriodCopyWith<$Res>
    implements $VacationPeriodCopyWith<$Res> {
  factory _$VacationPeriodCopyWith(
          _VacationPeriod value, $Res Function(_VacationPeriod) _then) =
      __$VacationPeriodCopyWithImpl;
  @override
  @useResult
  $Res call({int sortOrder, String start, int? id, String? end});
}

/// @nodoc
class __$VacationPeriodCopyWithImpl<$Res>
    implements _$VacationPeriodCopyWith<$Res> {
  __$VacationPeriodCopyWithImpl(this._self, this._then);

  final _VacationPeriod _self;
  final $Res Function(_VacationPeriod) _then;

  /// Create a copy of VacationPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sortOrder = null,
    Object? start = null,
    Object? id = freezed,
    Object? end = freezed,
  }) {
    return _then(_VacationPeriod(
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      end: freezed == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
