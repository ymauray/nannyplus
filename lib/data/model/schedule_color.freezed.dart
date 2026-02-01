// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_color.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScheduleColor {
  int get id;
  int get childId;
  int get color;

  /// Create a copy of ScheduleColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScheduleColorCopyWith<ScheduleColor> get copyWith =>
      _$ScheduleColorCopyWithImpl<ScheduleColor>(
          this as ScheduleColor, _$identity);

  /// Serializes this ScheduleColor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScheduleColor &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, childId, color);

  @override
  String toString() {
    return 'ScheduleColor(id: $id, childId: $childId, color: $color)';
  }
}

/// @nodoc
abstract mixin class $ScheduleColorCopyWith<$Res> {
  factory $ScheduleColorCopyWith(
          ScheduleColor value, $Res Function(ScheduleColor) _then) =
      _$ScheduleColorCopyWithImpl;
  @useResult
  $Res call({int id, int childId, int color});
}

/// @nodoc
class _$ScheduleColorCopyWithImpl<$Res>
    implements $ScheduleColorCopyWith<$Res> {
  _$ScheduleColorCopyWithImpl(this._self, this._then);

  final ScheduleColor _self;
  final $Res Function(ScheduleColor) _then;

  /// Create a copy of ScheduleColor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? color = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ScheduleColor].
extension ScheduleColorPatterns on ScheduleColor {
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
    TResult Function(_ScheduleColor value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScheduleColor() when $default != null:
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
    TResult Function(_ScheduleColor value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduleColor():
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
    TResult? Function(_ScheduleColor value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduleColor() when $default != null:
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
    TResult Function(int id, int childId, int color)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScheduleColor() when $default != null:
        return $default(_that.id, _that.childId, _that.color);
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
    TResult Function(int id, int childId, int color) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduleColor():
        return $default(_that.id, _that.childId, _that.color);
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
    TResult? Function(int id, int childId, int color)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduleColor() when $default != null:
        return $default(_that.id, _that.childId, _that.color);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ScheduleColor implements ScheduleColor {
  _ScheduleColor(
      {required this.id, required this.childId, required this.color});
  factory _ScheduleColor.fromJson(Map<String, dynamic> json) =>
      _$ScheduleColorFromJson(json);

  @override
  final int id;
  @override
  final int childId;
  @override
  final int color;

  /// Create a copy of ScheduleColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScheduleColorCopyWith<_ScheduleColor> get copyWith =>
      __$ScheduleColorCopyWithImpl<_ScheduleColor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScheduleColorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScheduleColor &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, childId, color);

  @override
  String toString() {
    return 'ScheduleColor(id: $id, childId: $childId, color: $color)';
  }
}

/// @nodoc
abstract mixin class _$ScheduleColorCopyWith<$Res>
    implements $ScheduleColorCopyWith<$Res> {
  factory _$ScheduleColorCopyWith(
          _ScheduleColor value, $Res Function(_ScheduleColor) _then) =
      __$ScheduleColorCopyWithImpl;
  @override
  @useResult
  $Res call({int id, int childId, int color});
}

/// @nodoc
class __$ScheduleColorCopyWithImpl<$Res>
    implements _$ScheduleColorCopyWith<$Res> {
  __$ScheduleColorCopyWithImpl(this._self, this._then);

  final _ScheduleColor _self;
  final $Res Function(_ScheduleColor) _then;

  /// Create a copy of ScheduleColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? color = null,
  }) {
    return _then(_ScheduleColor(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      childId: null == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
