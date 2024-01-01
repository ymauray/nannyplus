// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$childInfoHash() => r'da523306f3e68eacb8a76c1a5026a8e4a726d5d9';

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

/// See also [childInfo].
@ProviderFor(childInfo)
const childInfoProvider = ChildInfoFamily();

/// See also [childInfo].
class ChildInfoFamily extends Family<AsyncValue<Child>> {
  /// See also [childInfo].
  const ChildInfoFamily();

  /// See also [childInfo].
  ChildInfoProvider call(
    int childId,
  ) {
    return ChildInfoProvider(
      childId,
    );
  }

  @override
  ChildInfoProvider getProviderOverride(
    covariant ChildInfoProvider provider,
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
  String? get name => r'childInfoProvider';
}

/// See also [childInfo].
class ChildInfoProvider extends AutoDisposeFutureProvider<Child> {
  /// See also [childInfo].
  ChildInfoProvider(
    int childId,
  ) : this._internal(
          (ref) => childInfo(
            ref as ChildInfoRef,
            childId,
          ),
          from: childInfoProvider,
          name: r'childInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$childInfoHash,
          dependencies: ChildInfoFamily._dependencies,
          allTransitiveDependencies: ChildInfoFamily._allTransitiveDependencies,
          childId: childId,
        );

  ChildInfoProvider._internal(
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
  Override overrideWith(
    FutureOr<Child> Function(ChildInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChildInfoProvider._internal(
        (ref) => create(ref as ChildInfoRef),
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
  AutoDisposeFutureProviderElement<Child> createElement() {
    return _ChildInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChildInfoProvider && other.childId == childId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, childId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChildInfoRef on AutoDisposeFutureProviderRef<Child> {
  /// The parameter `childId` of this provider.
  int get childId;
}

class _ChildInfoProviderElement extends AutoDisposeFutureProviderElement<Child>
    with ChildInfoRef {
  _ChildInfoProviderElement(super.provider);

  @override
  int get childId => (origin as ChildInfoProvider).childId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
