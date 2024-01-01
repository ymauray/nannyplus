// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_average_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoiceAveragesHash() => r'9112c7dd8ab98aafce5aa6dd505c185f61e357a9';

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

/// See also [invoiceAverages].
@ProviderFor(invoiceAverages)
const invoiceAveragesProvider = InvoiceAveragesFamily();

/// See also [invoiceAverages].
class InvoiceAveragesFamily extends Family<AsyncValue<Map<int, double>>> {
  /// See also [invoiceAverages].
  const InvoiceAveragesFamily();

  /// See also [invoiceAverages].
  InvoiceAveragesProvider call(
    int childId,
  ) {
    return InvoiceAveragesProvider(
      childId,
    );
  }

  @override
  InvoiceAveragesProvider getProviderOverride(
    covariant InvoiceAveragesProvider provider,
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
  String? get name => r'invoiceAveragesProvider';
}

/// See also [invoiceAverages].
class InvoiceAveragesProvider
    extends AutoDisposeFutureProvider<Map<int, double>> {
  /// See also [invoiceAverages].
  InvoiceAveragesProvider(
    int childId,
  ) : this._internal(
          (ref) => invoiceAverages(
            ref as InvoiceAveragesRef,
            childId,
          ),
          from: invoiceAveragesProvider,
          name: r'invoiceAveragesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoiceAveragesHash,
          dependencies: InvoiceAveragesFamily._dependencies,
          allTransitiveDependencies:
              InvoiceAveragesFamily._allTransitiveDependencies,
          childId: childId,
        );

  InvoiceAveragesProvider._internal(
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
    FutureOr<Map<int, double>> Function(InvoiceAveragesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvoiceAveragesProvider._internal(
        (ref) => create(ref as InvoiceAveragesRef),
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
  AutoDisposeFutureProviderElement<Map<int, double>> createElement() {
    return _InvoiceAveragesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoiceAveragesProvider && other.childId == childId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, childId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InvoiceAveragesRef on AutoDisposeFutureProviderRef<Map<int, double>> {
  /// The parameter `childId` of this provider.
  int get childId;
}

class _InvoiceAveragesProviderElement
    extends AutoDisposeFutureProviderElement<Map<int, double>>
    with InvoiceAveragesRef {
  _InvoiceAveragesProviderElement(super.provider);

  @override
  int get childId => (origin as InvoiceAveragesProvider).childId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
