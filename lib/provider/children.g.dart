// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$childListHash() => r'97a9f10f695dfe3068ced4f57d3939fb861e130c';

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

/// See also [childList].
@ProviderFor(childList)
const childListProvider = ChildListFamily();

/// See also [childList].
class ChildListFamily extends Family<Raw<FutureOr<List<Child>>>> {
  /// See also [childList].
  const ChildListFamily();

  /// See also [childList].
  ChildListProvider call(
    int? excludeId,
  ) {
    return ChildListProvider(
      excludeId,
    );
  }

  @override
  ChildListProvider getProviderOverride(
    covariant ChildListProvider provider,
  ) {
    return call(
      provider.excludeId,
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
  String? get name => r'childListProvider';
}

/// See also [childList].
class ChildListProvider
    extends AutoDisposeProvider<Raw<FutureOr<List<Child>>>> {
  /// See also [childList].
  ChildListProvider(
    int? excludeId,
  ) : this._internal(
          (ref) => childList(
            ref as ChildListRef,
            excludeId,
          ),
          from: childListProvider,
          name: r'childListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$childListHash,
          dependencies: ChildListFamily._dependencies,
          allTransitiveDependencies: ChildListFamily._allTransitiveDependencies,
          excludeId: excludeId,
        );

  ChildListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.excludeId,
  }) : super.internal();

  final int? excludeId;

  @override
  Override overrideWith(
    Raw<FutureOr<List<Child>>> Function(ChildListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChildListProvider._internal(
        (ref) => create(ref as ChildListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        excludeId: excludeId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Raw<FutureOr<List<Child>>>> createElement() {
    return _ChildListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChildListProvider && other.excludeId == excludeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, excludeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChildListRef on AutoDisposeProviderRef<Raw<FutureOr<List<Child>>>> {
  /// The parameter `excludeId` of this provider.
  int? get excludeId;
}

class _ChildListProviderElement
    extends AutoDisposeProviderElement<Raw<FutureOr<List<Child>>>>
    with ChildListRef {
  _ChildListProviderElement(super.provider);

  @override
  int? get excludeId => (origin as ChildListProvider).excludeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
