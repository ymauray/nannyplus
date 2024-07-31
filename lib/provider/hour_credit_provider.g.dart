// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hour_credit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hourCreditHash() => r'2b82a600d6a427f12864a23e59c23b8b28441102';

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

abstract class _$HourCredit extends BuildlessAutoDisposeAsyncNotifier<int> {
  late final int childId;

  FutureOr<int> build(
    int childId,
  );
}

/// See also [HourCredit].
@ProviderFor(HourCredit)
const hourCreditProvider = HourCreditFamily();

/// See also [HourCredit].
class HourCreditFamily extends Family<AsyncValue<int>> {
  /// See also [HourCredit].
  const HourCreditFamily();

  /// See also [HourCredit].
  HourCreditProvider call(
    int childId,
  ) {
    return HourCreditProvider(
      childId,
    );
  }

  @override
  HourCreditProvider getProviderOverride(
    covariant HourCreditProvider provider,
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
  String? get name => r'hourCreditProvider';
}

/// See also [HourCredit].
class HourCreditProvider
    extends AutoDisposeAsyncNotifierProviderImpl<HourCredit, int> {
  /// See also [HourCredit].
  HourCreditProvider(
    int childId,
  ) : this._internal(
          () => HourCredit()..childId = childId,
          from: hourCreditProvider,
          name: r'hourCreditProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hourCreditHash,
          dependencies: HourCreditFamily._dependencies,
          allTransitiveDependencies:
              HourCreditFamily._allTransitiveDependencies,
          childId: childId,
        );

  HourCreditProvider._internal(
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
  FutureOr<int> runNotifierBuild(
    covariant HourCredit notifier,
  ) {
    return notifier.build(
      childId,
    );
  }

  @override
  Override overrideWith(HourCredit Function() create) {
    return ProviderOverride(
      origin: this,
      override: HourCreditProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<HourCredit, int> createElement() {
    return _HourCreditProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HourCreditProvider && other.childId == childId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, childId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HourCreditRef on AutoDisposeAsyncNotifierProviderRef<int> {
  /// The parameter `childId` of this provider.
  int get childId;
}

class _HourCreditProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HourCredit, int>
    with HourCreditRef {
  _HourCreditProviderElement(super.provider);

  @override
  int get childId => (origin as HourCreditProvider).childId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
