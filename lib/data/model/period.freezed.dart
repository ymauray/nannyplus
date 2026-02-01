// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Period {
  int get childId;
  String get day;
  TimeOfDay get to;
  TimeOfDay get from;
  int? get sortOrder;
  int? get id;

  /// Create a copy of Period
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PeriodCopyWith<Period> get copyWith =>
      _$PeriodCopyWithImpl<Period>(this as Period, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Period &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, childId, day, to, from, sortOrder, id);

  @override
  String toString() {
    return 'Period(childId: $childId, day: $day, to: $to, from: $from, sortOrder: $sortOrder, id: $id)';
  }
}

/// @nodoc
abstract mixin class $PeriodCopyWith<$Res> {
  factory $PeriodCopyWith(Period value, $Res Function(Period) _then) =
      _$PeriodCopyWithImpl;
  @useResult
  $Res call(
      {int childId,
      String day,
      TimeOfDay to,
      TimeOfDay from,
      int? sortOrder,
      int? id});
}

/// @nodoc
class _$PeriodCopyWithImpl<$Res> implements $PeriodCopyWith<$Res> {
  _$PeriodCopyWithImpl(this._self, this._then);

  final Period _self;
  final $Res Function(Period) _then;

  /// Create a copy of Period
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? childId = null,
    Object? day = null,
    Object? to = null,
    Object? from = null,
    Object? sortOrder = freezed,
    Object? id = freezed,
  }) {
    return _then(_self.copyWith(
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      sortOrder: freezed == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Period].
extension PeriodPatterns on Period {
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
    TResult Function(_Period value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Period() when $default != null:
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
    TResult Function(_Period value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Period():
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
    TResult? Function(_Period value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Period() when $default != null:
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
    TResult Function(int childId, String day, TimeOfDay to, TimeOfDay from,
            int? sortOrder, int? id)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Period() when $default != null:
        return $default(_that.childId, _that.day, _that.to, _that.from,
            _that.sortOrder, _that.id);
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
    TResult Function(int childId, String day, TimeOfDay to, TimeOfDay from,
            int? sortOrder, int? id)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Period():
        return $default(_that.childId, _that.day, _that.to, _that.from,
            _that.sortOrder, _that.id);
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
    TResult? Function(int childId, String day, TimeOfDay to, TimeOfDay from,
            int? sortOrder, int? id)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Period() when $default != null:
        return $default(_that.childId, _that.day, _that.to, _that.from,
            _that.sortOrder, _that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Period extends Period {
  _Period(
      {required this.childId,
      required this.day,
      required this.to,
      required this.from,
      this.sortOrder,
      this.id})
      : super._();

  @override
  final int childId;
  @override
  final String day;
  @override
  final TimeOfDay to;
  @override
  final TimeOfDay from;
  @override
  final int? sortOrder;
  @override
  final int? id;

  /// Create a copy of Period
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PeriodCopyWith<_Period> get copyWith =>
      __$PeriodCopyWithImpl<_Period>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Period &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, childId, day, to, from, sortOrder, id);

  @override
  String toString() {
    return 'Period(childId: $childId, day: $day, to: $to, from: $from, sortOrder: $sortOrder, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$PeriodCopyWith<$Res> implements $PeriodCopyWith<$Res> {
  factory _$PeriodCopyWith(_Period value, $Res Function(_Period) _then) =
      __$PeriodCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int childId,
      String day,
      TimeOfDay to,
      TimeOfDay from,
      int? sortOrder,
      int? id});
}

/// @nodoc
class __$PeriodCopyWithImpl<$Res> implements _$PeriodCopyWith<$Res> {
  __$PeriodCopyWithImpl(this._self, this._then);

  final _Period _self;
  final $Res Function(_Period) _then;

  /// Create a copy of Period
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? childId = null,
    Object? day = null,
    Object? to = null,
    Object? from = null,
    Object? sortOrder = freezed,
    Object? id = freezed,
  }) {
    return _then(_Period(
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      sortOrder: freezed == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
