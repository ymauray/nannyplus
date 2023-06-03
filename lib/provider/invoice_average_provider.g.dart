// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_average_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoiceAveragesHash() => r'703f6581d33461a6b5cd67f2444ed060a88c2a35';

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

typedef InvoiceAveragesRef = AutoDisposeFutureProviderRef<Map<int, double>>;

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
    this.childId,
  ) : super.internal(
          (ref) => invoiceAverages(
            ref,
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
        );

  final int childId;

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
