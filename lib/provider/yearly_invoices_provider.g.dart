// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yearly_invoices_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$yearlyInvoicesHash() => r'65e4da1e7e37faec356893360e2116b9d12eb07d';

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

/// See also [yearlyInvoices].
@ProviderFor(yearlyInvoices)
const yearlyInvoicesProvider = YearlyInvoicesFamily();

/// See also [yearlyInvoices].
class YearlyInvoicesFamily extends Family<AsyncValue<List<Invoice>>> {
  /// See also [yearlyInvoices].
  const YearlyInvoicesFamily();

  /// See also [yearlyInvoices].
  YearlyInvoicesProvider call(
    int year,
    int childId,
  ) {
    return YearlyInvoicesProvider(
      year,
      childId,
    );
  }

  @override
  YearlyInvoicesProvider getProviderOverride(
    covariant YearlyInvoicesProvider provider,
  ) {
    return call(
      provider.year,
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
  String? get name => r'yearlyInvoicesProvider';
}

/// See also [yearlyInvoices].
class YearlyInvoicesProvider extends AutoDisposeFutureProvider<List<Invoice>> {
  /// See also [yearlyInvoices].
  YearlyInvoicesProvider(
    int year,
    int childId,
  ) : this._internal(
          (ref) => yearlyInvoices(
            ref as YearlyInvoicesRef,
            year,
            childId,
          ),
          from: yearlyInvoicesProvider,
          name: r'yearlyInvoicesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$yearlyInvoicesHash,
          dependencies: YearlyInvoicesFamily._dependencies,
          allTransitiveDependencies:
              YearlyInvoicesFamily._allTransitiveDependencies,
          year: year,
          childId: childId,
        );

  YearlyInvoicesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.childId,
  }) : super.internal();

  final int year;
  final int childId;

  @override
  Override overrideWith(
    FutureOr<List<Invoice>> Function(YearlyInvoicesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: YearlyInvoicesProvider._internal(
        (ref) => create(ref as YearlyInvoicesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        childId: childId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Invoice>> createElement() {
    return _YearlyInvoicesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YearlyInvoicesProvider &&
        other.year == year &&
        other.childId == childId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, childId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YearlyInvoicesRef on AutoDisposeFutureProviderRef<List<Invoice>> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `childId` of this provider.
  int get childId;
}

class _YearlyInvoicesProviderElement
    extends AutoDisposeFutureProviderElement<List<Invoice>>
    with YearlyInvoicesRef {
  _YearlyInvoicesProviderElement(super.provider);

  @override
  int get year => (origin as YearlyInvoicesProvider).year;
  @override
  int get childId => (origin as YearlyInvoicesProvider).childId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
