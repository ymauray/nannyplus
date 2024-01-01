// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scheduleColorHash() => r'19f2b242d4970c703b921d8372e20f9797e60f03';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ScheduleColor
    extends BuildlessAutoDisposeAsyncNotifier<Color> {
  late final int childId;

  FutureOr<Color> build(
    int childId,
  );
}

/// See also [ScheduleColor].
@ProviderFor(ScheduleColor)
const scheduleColorProvider = ScheduleColorFamily();

/// See also [ScheduleColor].
class ScheduleColorFamily extends Family<AsyncValue<Color>> {
  /// See also [ScheduleColor].
  const ScheduleColorFamily();

  /// See also [ScheduleColor].
  ScheduleColorProvider call(
    int childId,
  ) {
    return ScheduleColorProvider(
      childId,
    );
  }

  @override
  ScheduleColorProvider getProviderOverride(
    covariant ScheduleColorProvider provider,
  ) {
    return call(
      provider.childId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'scheduleColorProvider';
}

/// See also [ScheduleColor].
class ScheduleColorProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ScheduleColor, Color> {
  /// See also [ScheduleColor].
  ScheduleColorProvider(
    int childId,
  ) : this._internal(
          () => ScheduleColor()..childId = childId,
          from: scheduleColorProvider,
          name: r'scheduleColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$scheduleColorHash,
          dependencies: ScheduleColorFamily._dependencies,
          allTransitiveDependencies:
              ScheduleColorFamily._allTransitiveDependencies,
          childId: childId,
        );

  ScheduleColorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.childId,
  }) : super.internal();

  final int childId;

  @override
  FutureOr<Color> runNotifierBuild(
    covariant ScheduleColor notifier,
  ) {
    return notifier.build(
      childId,
    );
  }

  @override
  Override overrideWith(ScheduleColor Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScheduleColorProvider._internal(
        () => create()..childId = childId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        childId: childId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ScheduleColor, Color>
      createElement() {
    return _ScheduleColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScheduleColorProvider && other.childId == childId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, childId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ScheduleColorRef on AutoDisposeAsyncNotifierProviderRef<Color> {
  /// The parameter `childId` of this provider.
  int get childId;
}

class _ScheduleColorProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ScheduleColor, Color>
    with ScheduleColorRef {
  _ScheduleColorProviderElement(super.provider);

  @override
  int get childId => (origin as ScheduleColorProvider).childId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
