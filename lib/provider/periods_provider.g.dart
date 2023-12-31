// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periods_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$periodsHash() => r'70805101408e30ea4a1b1ff5b3de259ff7ada77e';

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

abstract class _$Periods
    extends BuildlessAutoDisposeAsyncNotifier<List<Period>> {
  late final int childId;

  FutureOr<List<Period>> build(
    int childId,
  );
}

/// See also [Periods].
@ProviderFor(Periods)
const periodsProvider = PeriodsFamily();

/// See also [Periods].
class PeriodsFamily extends Family<AsyncValue<List<Period>>> {
  /// See also [Periods].
  const PeriodsFamily();

  /// See also [Periods].
  PeriodsProvider call(
    int childId,
  ) {
    return PeriodsProvider(
      childId,
    );
  }

  @override
  PeriodsProvider getProviderOverride(
    covariant PeriodsProvider provider,
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
  String? get name => r'periodsProvider';
}

/// See also [Periods].
class PeriodsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Periods, List<Period>> {
  /// See also [Periods].
  PeriodsProvider(
    int childId,
  ) : this._internal(
          () => Periods()..childId = childId,
          from: periodsProvider,
          name: r'periodsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$periodsHash,
          dependencies: PeriodsFamily._dependencies,
          allTransitiveDependencies: PeriodsFamily._allTransitiveDependencies,
          childId: childId,
        );

  PeriodsProvider._internal(
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
  FutureOr<List<Period>> runNotifierBuild(
    covariant Periods notifier,
  ) {
    return notifier.build(
      childId,
    );
  }

  @override
  Override overrideWith(Periods Function() create) {
    return ProviderOverride(
      origin: this,
      override: PeriodsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<Periods, List<Period>>
      createElement() {
    return _PeriodsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PeriodsProvider && other.childId == childId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, childId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PeriodsRef on AutoDisposeAsyncNotifierProviderRef<List<Period>> {
  /// The parameter `childId` of this provider.
  int get childId;
}

class _PeriodsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Periods, List<Period>>
    with PeriodsRef {
  _PeriodsProviderElement(super.provider);

  @override
  int get childId => (origin as PeriodsProvider).childId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
