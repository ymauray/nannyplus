// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_form_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InvoiceFormChild _$$_InvoiceFormChildFromJson(Map<String, dynamic> json) =>
    _$_InvoiceFormChild(
      child: Child.fromJson(json['child'] as String),
      selected: json['selected'] as bool,
    );

Map<String, dynamic> _$$_InvoiceFormChildToJson(_$_InvoiceFormChild instance) =>
    <String, dynamic>{
      'child': instance.child,
      'selected': instance.selected,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoiceFormChildrenHash() =>
    r'b5d513226e1e73d56415123155c98bbfedc18860';

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

abstract class _$InvoiceFormChildren
    extends BuildlessAutoDisposeAsyncNotifier<List<InvoiceFormChild>> {
  late final int excludedId;

  FutureOr<List<InvoiceFormChild>> build(
    int excludedId,
  );
}

/// See also [InvoiceFormChildren].
@ProviderFor(InvoiceFormChildren)
const invoiceFormChildrenProvider = InvoiceFormChildrenFamily();

/// See also [InvoiceFormChildren].
class InvoiceFormChildrenFamily
    extends Family<AsyncValue<List<InvoiceFormChild>>> {
  /// See also [InvoiceFormChildren].
  const InvoiceFormChildrenFamily();

  /// See also [InvoiceFormChildren].
  InvoiceFormChildrenProvider call(
    int excludedId,
  ) {
    return InvoiceFormChildrenProvider(
      excludedId,
    );
  }

  @override
  InvoiceFormChildrenProvider getProviderOverride(
    covariant InvoiceFormChildrenProvider provider,
  ) {
    return call(
      provider.excludedId,
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
  String? get name => r'invoiceFormChildrenProvider';
}

/// See also [InvoiceFormChildren].
class InvoiceFormChildrenProvider extends AutoDisposeAsyncNotifierProviderImpl<
    InvoiceFormChildren, List<InvoiceFormChild>> {
  /// See also [InvoiceFormChildren].
  InvoiceFormChildrenProvider(
    this.excludedId,
  ) : super.internal(
          () => InvoiceFormChildren()..excludedId = excludedId,
          from: invoiceFormChildrenProvider,
          name: r'invoiceFormChildrenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoiceFormChildrenHash,
          dependencies: InvoiceFormChildrenFamily._dependencies,
          allTransitiveDependencies:
              InvoiceFormChildrenFamily._allTransitiveDependencies,
        );

  final int excludedId;

  @override
  bool operator ==(Object other) {
    return other is InvoiceFormChildrenProvider &&
        other.excludedId == excludedId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, excludedId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<InvoiceFormChild>> runNotifierBuild(
    covariant InvoiceFormChildren notifier,
  ) {
    return notifier.build(
      excludedId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
