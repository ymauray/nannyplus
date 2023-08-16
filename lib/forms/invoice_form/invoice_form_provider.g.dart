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

_$_InvoiceFormState _$$_InvoiceFormStateFromJson(Map<String, dynamic> json) =>
    _$_InvoiceFormState(
      child: Child.fromJson(json['child'] as String),
      children: (json['children'] as List<dynamic>)
          .map((e) => InvoiceFormChild.fromJson(e as Map<String, dynamic>))
          .toList(),
      months:
          (json['months'] as List<dynamic>).map((e) => e as String).toList(),
      selectedMonth: json['selectedMonth'] as String?,
    );

Map<String, dynamic> _$$_InvoiceFormStateToJson(_$_InvoiceFormState instance) =>
    <String, dynamic>{
      'child': instance.child,
      'children': instance.children,
      'months': instance.months,
      'selectedMonth': instance.selectedMonth,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoiceFormHash() => r'f53c911e2a6482267d9a4a1d6fd22e07a79e359a';

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

abstract class _$InvoiceForm
    extends BuildlessAutoDisposeAsyncNotifier<InvoiceFormState> {
  late final int childId;

  FutureOr<InvoiceFormState> build(
    int childId,
  );
}

/// See also [InvoiceForm].
@ProviderFor(InvoiceForm)
const invoiceFormProvider = InvoiceFormFamily();

/// See also [InvoiceForm].
class InvoiceFormFamily extends Family<AsyncValue<InvoiceFormState>> {
  /// See also [InvoiceForm].
  const InvoiceFormFamily();

  /// See also [InvoiceForm].
  InvoiceFormProvider call(
    int childId,
  ) {
    return InvoiceFormProvider(
      childId,
    );
  }

  @override
  InvoiceFormProvider getProviderOverride(
    covariant InvoiceFormProvider provider,
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
  String? get name => r'invoiceFormProvider';
}

/// See also [InvoiceForm].
class InvoiceFormProvider extends AutoDisposeAsyncNotifierProviderImpl<
    InvoiceForm, InvoiceFormState> {
  /// See also [InvoiceForm].
  InvoiceFormProvider(
    this.childId,
  ) : super.internal(
          () => InvoiceForm()..childId = childId,
          from: invoiceFormProvider,
          name: r'invoiceFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoiceFormHash,
          dependencies: InvoiceFormFamily._dependencies,
          allTransitiveDependencies:
              InvoiceFormFamily._allTransitiveDependencies,
        );

  final int childId;

  @override
  bool operator ==(Object other) {
    return other is InvoiceFormProvider && other.childId == childId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, childId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<InvoiceFormState> runNotifierBuild(
    covariant InvoiceForm notifier,
  ) {
    return notifier.build(
      childId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
