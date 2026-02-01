// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_average_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(invoiceAverages)
final invoiceAveragesProvider = InvoiceAveragesFamily._();

final class InvoiceAveragesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<int, double>>,
          Map<int, double>,
          FutureOr<Map<int, double>>
        >
    with $FutureModifier<Map<int, double>>, $FutureProvider<Map<int, double>> {
  InvoiceAveragesProvider._({
    required InvoiceAveragesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'invoiceAveragesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$invoiceAveragesHash();

  @override
  String toString() {
    return r'invoiceAveragesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<int, double>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<int, double>> create(Ref ref) {
    final argument = this.argument as int;
    return invoiceAverages(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoiceAveragesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$invoiceAveragesHash() => r'19b2b07e686a61d27e68fb479b66dd1893731d48';

final class InvoiceAveragesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<int, double>>, int> {
  InvoiceAveragesFamily._()
    : super(
        retry: null,
        name: r'invoiceAveragesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InvoiceAveragesProvider call(int childId) =>
      InvoiceAveragesProvider._(argument: childId, from: this);

  @override
  String toString() => r'invoiceAveragesProvider';
}
