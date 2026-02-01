// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_form_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvoiceFormChild {
  Child get child;
  bool get selected;

  /// Create a copy of InvoiceFormChild
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvoiceFormChildCopyWith<InvoiceFormChild> get copyWith =>
      _$InvoiceFormChildCopyWithImpl<InvoiceFormChild>(
          this as InvoiceFormChild, _$identity);

  /// Serializes this InvoiceFormChild to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvoiceFormChild &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, child, selected);

  @override
  String toString() {
    return 'InvoiceFormChild(child: $child, selected: $selected)';
  }
}

/// @nodoc
abstract mixin class $InvoiceFormChildCopyWith<$Res> {
  factory $InvoiceFormChildCopyWith(
          InvoiceFormChild value, $Res Function(InvoiceFormChild) _then) =
      _$InvoiceFormChildCopyWithImpl;
  @useResult
  $Res call({Child child, bool selected});
}

/// @nodoc
class _$InvoiceFormChildCopyWithImpl<$Res>
    implements $InvoiceFormChildCopyWith<$Res> {
  _$InvoiceFormChildCopyWithImpl(this._self, this._then);

  final InvoiceFormChild _self;
  final $Res Function(InvoiceFormChild) _then;

  /// Create a copy of InvoiceFormChild
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? selected = null,
  }) {
    return _then(_self.copyWith(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
      selected: null == selected
          ? _self.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [InvoiceFormChild].
extension InvoiceFormChildPatterns on InvoiceFormChild {
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
    TResult Function(_InvoiceFormChild value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormChild() when $default != null:
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
    TResult Function(_InvoiceFormChild value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormChild():
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
    TResult? Function(_InvoiceFormChild value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormChild() when $default != null:
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
    TResult Function(Child child, bool selected)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormChild() when $default != null:
        return $default(_that.child, _that.selected);
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
    TResult Function(Child child, bool selected) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormChild():
        return $default(_that.child, _that.selected);
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
    TResult? Function(Child child, bool selected)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormChild() when $default != null:
        return $default(_that.child, _that.selected);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InvoiceFormChild implements InvoiceFormChild {
  const _InvoiceFormChild({required this.child, required this.selected});
  factory _InvoiceFormChild.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFormChildFromJson(json);

  @override
  final Child child;
  @override
  final bool selected;

  /// Create a copy of InvoiceFormChild
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InvoiceFormChildCopyWith<_InvoiceFormChild> get copyWith =>
      __$InvoiceFormChildCopyWithImpl<_InvoiceFormChild>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InvoiceFormChildToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InvoiceFormChild &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, child, selected);

  @override
  String toString() {
    return 'InvoiceFormChild(child: $child, selected: $selected)';
  }
}

/// @nodoc
abstract mixin class _$InvoiceFormChildCopyWith<$Res>
    implements $InvoiceFormChildCopyWith<$Res> {
  factory _$InvoiceFormChildCopyWith(
          _InvoiceFormChild value, $Res Function(_InvoiceFormChild) _then) =
      __$InvoiceFormChildCopyWithImpl;
  @override
  @useResult
  $Res call({Child child, bool selected});
}

/// @nodoc
class __$InvoiceFormChildCopyWithImpl<$Res>
    implements _$InvoiceFormChildCopyWith<$Res> {
  __$InvoiceFormChildCopyWithImpl(this._self, this._then);

  final _InvoiceFormChild _self;
  final $Res Function(_InvoiceFormChild) _then;

  /// Create a copy of InvoiceFormChild
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? selected = null,
  }) {
    return _then(_InvoiceFormChild(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
      selected: null == selected
          ? _self.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$InvoiceFormState {
  Child get child;
  List<InvoiceFormChild> get children;
  List<String> get months;
  String? get selectedMonth;

  /// Create a copy of InvoiceFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvoiceFormStateCopyWith<InvoiceFormState> get copyWith =>
      _$InvoiceFormStateCopyWithImpl<InvoiceFormState>(
          this as InvoiceFormState, _$identity);

  /// Serializes this InvoiceFormState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvoiceFormState &&
            (identical(other.child, child) || other.child == child) &&
            const DeepCollectionEquality().equals(other.children, children) &&
            const DeepCollectionEquality().equals(other.months, months) &&
            (identical(other.selectedMonth, selectedMonth) ||
                other.selectedMonth == selectedMonth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      child,
      const DeepCollectionEquality().hash(children),
      const DeepCollectionEquality().hash(months),
      selectedMonth);

  @override
  String toString() {
    return 'InvoiceFormState(child: $child, children: $children, months: $months, selectedMonth: $selectedMonth)';
  }
}

/// @nodoc
abstract mixin class $InvoiceFormStateCopyWith<$Res> {
  factory $InvoiceFormStateCopyWith(
          InvoiceFormState value, $Res Function(InvoiceFormState) _then) =
      _$InvoiceFormStateCopyWithImpl;
  @useResult
  $Res call(
      {Child child,
      List<InvoiceFormChild> children,
      List<String> months,
      String? selectedMonth});
}

/// @nodoc
class _$InvoiceFormStateCopyWithImpl<$Res>
    implements $InvoiceFormStateCopyWith<$Res> {
  _$InvoiceFormStateCopyWithImpl(this._self, this._then);

  final InvoiceFormState _self;
  final $Res Function(InvoiceFormState) _then;

  /// Create a copy of InvoiceFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? child = null,
    Object? children = null,
    Object? months = null,
    Object? selectedMonth = freezed,
  }) {
    return _then(_self.copyWith(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
      children: null == children
          ? _self.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<InvoiceFormChild>,
      months: null == months
          ? _self.months
          : months // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedMonth: freezed == selectedMonth
          ? _self.selectedMonth
          : selectedMonth // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [InvoiceFormState].
extension InvoiceFormStatePatterns on InvoiceFormState {
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
    TResult Function(_InvoiceFormState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormState() when $default != null:
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
    TResult Function(_InvoiceFormState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormState():
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
    TResult? Function(_InvoiceFormState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormState() when $default != null:
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
    TResult Function(Child child, List<InvoiceFormChild> children,
            List<String> months, String? selectedMonth)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormState() when $default != null:
        return $default(
            _that.child, _that.children, _that.months, _that.selectedMonth);
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
    TResult Function(Child child, List<InvoiceFormChild> children,
            List<String> months, String? selectedMonth)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormState():
        return $default(
            _that.child, _that.children, _that.months, _that.selectedMonth);
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
    TResult? Function(Child child, List<InvoiceFormChild> children,
            List<String> months, String? selectedMonth)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceFormState() when $default != null:
        return $default(
            _that.child, _that.children, _that.months, _that.selectedMonth);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InvoiceFormState implements InvoiceFormState {
  const _InvoiceFormState(
      {required this.child,
      required final List<InvoiceFormChild> children,
      required final List<String> months,
      required this.selectedMonth})
      : _children = children,
        _months = months;
  factory _InvoiceFormState.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFormStateFromJson(json);

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

  /// Create a copy of InvoiceFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InvoiceFormStateCopyWith<_InvoiceFormState> get copyWith =>
      __$InvoiceFormStateCopyWithImpl<_InvoiceFormState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InvoiceFormStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InvoiceFormState &&
            (identical(other.child, child) || other.child == child) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            const DeepCollectionEquality().equals(other._months, _months) &&
            (identical(other.selectedMonth, selectedMonth) ||
                other.selectedMonth == selectedMonth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      child,
      const DeepCollectionEquality().hash(_children),
      const DeepCollectionEquality().hash(_months),
      selectedMonth);

  @override
  String toString() {
    return 'InvoiceFormState(child: $child, children: $children, months: $months, selectedMonth: $selectedMonth)';
  }
}

/// @nodoc
abstract mixin class _$InvoiceFormStateCopyWith<$Res>
    implements $InvoiceFormStateCopyWith<$Res> {
  factory _$InvoiceFormStateCopyWith(
          _InvoiceFormState value, $Res Function(_InvoiceFormState) _then) =
      __$InvoiceFormStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Child child,
      List<InvoiceFormChild> children,
      List<String> months,
      String? selectedMonth});
}

/// @nodoc
class __$InvoiceFormStateCopyWithImpl<$Res>
    implements _$InvoiceFormStateCopyWith<$Res> {
  __$InvoiceFormStateCopyWithImpl(this._self, this._then);

  final _InvoiceFormState _self;
  final $Res Function(_InvoiceFormState) _then;

  /// Create a copy of InvoiceFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? children = null,
    Object? months = null,
    Object? selectedMonth = freezed,
  }) {
    return _then(_InvoiceFormState(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as Child,
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<InvoiceFormChild>,
      months: null == months
          ? _self._months
          : months // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedMonth: freezed == selectedMonth
          ? _self.selectedMonth
          : selectedMonth // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
