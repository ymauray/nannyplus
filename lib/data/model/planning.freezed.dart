// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Planning {
  int get id;
  String? get planningStart;
  String? get planningEnd;

  /// Create a copy of Planning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlanningCopyWith<Planning> get copyWith =>
      _$PlanningCopyWithImpl<Planning>(this as Planning, _$identity);

  /// Serializes this Planning to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Planning &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.planningStart, planningStart) ||
                other.planningStart == planningStart) &&
            (identical(other.planningEnd, planningEnd) ||
                other.planningEnd == planningEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, planningStart, planningEnd);

  @override
  String toString() {
    return 'Planning(id: $id, planningStart: $planningStart, planningEnd: $planningEnd)';
  }
}

/// @nodoc
abstract mixin class $PlanningCopyWith<$Res> {
  factory $PlanningCopyWith(Planning value, $Res Function(Planning) _then) =
      _$PlanningCopyWithImpl;
  @useResult
  $Res call({int id, String? planningStart, String? planningEnd});
}

/// @nodoc
class _$PlanningCopyWithImpl<$Res> implements $PlanningCopyWith<$Res> {
  _$PlanningCopyWithImpl(this._self, this._then);

  final Planning _self;
  final $Res Function(Planning) _then;

  /// Create a copy of Planning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? planningStart = freezed,
    Object? planningEnd = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      planningStart: freezed == planningStart
          ? _self.planningStart
          : planningStart // ignore: cast_nullable_to_non_nullable
              as String?,
      planningEnd: freezed == planningEnd
          ? _self.planningEnd
          : planningEnd // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Planning].
extension PlanningPatterns on Planning {
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
    TResult Function(_Planning value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Planning() when $default != null:
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
    TResult Function(_Planning value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Planning():
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
    TResult? Function(_Planning value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Planning() when $default != null:
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
    TResult Function(int id, String? planningStart, String? planningEnd)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Planning() when $default != null:
        return $default(_that.id, _that.planningStart, _that.planningEnd);
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
    TResult Function(int id, String? planningStart, String? planningEnd)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Planning():
        return $default(_that.id, _that.planningStart, _that.planningEnd);
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
    TResult? Function(int id, String? planningStart, String? planningEnd)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Planning() when $default != null:
        return $default(_that.id, _that.planningStart, _that.planningEnd);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Planning implements Planning {
  const _Planning(
      {required this.id,
      required this.planningStart,
      required this.planningEnd});
  factory _Planning.fromJson(Map<String, dynamic> json) =>
      _$PlanningFromJson(json);

  @override
  final int id;
  @override
  final String? planningStart;
  @override
  final String? planningEnd;

  /// Create a copy of Planning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlanningCopyWith<_Planning> get copyWith =>
      __$PlanningCopyWithImpl<_Planning>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlanningToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Planning &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.planningStart, planningStart) ||
                other.planningStart == planningStart) &&
            (identical(other.planningEnd, planningEnd) ||
                other.planningEnd == planningEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, planningStart, planningEnd);

  @override
  String toString() {
    return 'Planning(id: $id, planningStart: $planningStart, planningEnd: $planningEnd)';
  }
}

/// @nodoc
abstract mixin class _$PlanningCopyWith<$Res>
    implements $PlanningCopyWith<$Res> {
  factory _$PlanningCopyWith(_Planning value, $Res Function(_Planning) _then) =
      __$PlanningCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String? planningStart, String? planningEnd});
}

/// @nodoc
class __$PlanningCopyWithImpl<$Res> implements _$PlanningCopyWith<$Res> {
  __$PlanningCopyWithImpl(this._self, this._then);

  final _Planning _self;
  final $Res Function(_Planning) _then;

  /// Create a copy of Planning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? planningStart = freezed,
    Object? planningEnd = freezed,
  }) {
    return _then(_Planning(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      planningStart: freezed == planningStart
          ? _self.planningStart
          : planningStart // ignore: cast_nullable_to_non_nullable
              as String?,
      planningEnd: freezed == planningEnd
          ? _self.planningEnd
          : planningEnd // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
