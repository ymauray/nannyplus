// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_card_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helpCardStatusHash() => r'7cd3dce56edfd7d2f82ba8dec7134a22816b1f18';

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

abstract class _$HelpCardStatus
    extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final int code;

  FutureOr<bool> build(
    int code,
  );
}

/// See also [HelpCardStatus].
@ProviderFor(HelpCardStatus)
const helpCardStatusProvider = HelpCardStatusFamily();

/// See also [HelpCardStatus].
class HelpCardStatusFamily extends Family<AsyncValue<bool>> {
  /// See also [HelpCardStatus].
  const HelpCardStatusFamily();

  /// See also [HelpCardStatus].
  HelpCardStatusProvider call(
    int code,
  ) {
    return HelpCardStatusProvider(
      code,
    );
  }

  @override
  HelpCardStatusProvider getProviderOverride(
    covariant HelpCardStatusProvider provider,
  ) {
    return call(
      provider.code,
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
  String? get name => r'helpCardStatusProvider';
}

/// See also [HelpCardStatus].
class HelpCardStatusProvider
    extends AutoDisposeAsyncNotifierProviderImpl<HelpCardStatus, bool> {
  /// See also [HelpCardStatus].
  HelpCardStatusProvider(
    int code,
  ) : this._internal(
          () => HelpCardStatus()..code = code,
          from: helpCardStatusProvider,
          name: r'helpCardStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$helpCardStatusHash,
          dependencies: HelpCardStatusFamily._dependencies,
          allTransitiveDependencies:
              HelpCardStatusFamily._allTransitiveDependencies,
          code: code,
        );

  HelpCardStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.code,
  }) : super.internal();

  final int code;

  @override
  FutureOr<bool> runNotifierBuild(
    covariant HelpCardStatus notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(HelpCardStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: HelpCardStatusProvider._internal(
        () => create()..code = code,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        code: code,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<HelpCardStatus, bool>
      createElement() {
    return _HelpCardStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HelpCardStatusProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HelpCardStatusRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `code` of this provider.
  int get code;
}

class _HelpCardStatusProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HelpCardStatus, bool>
    with HelpCardStatusRef {
  _HelpCardStatusProviderElement(super.provider);

  @override
  int get code => (origin as HelpCardStatusProvider).code;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
