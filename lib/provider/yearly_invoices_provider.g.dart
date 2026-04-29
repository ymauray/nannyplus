// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yearly_invoices_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(yearlyInvoices)
final yearlyInvoicesProvider = YearlyInvoicesFamily._();

final class YearlyInvoicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InvoiceWithServices>>,
          List<InvoiceWithServices>,
          FutureOr<List<InvoiceWithServices>>
        >
    with
        $FutureModifier<List<InvoiceWithServices>>,
        $FutureProvider<List<InvoiceWithServices>> {
  YearlyInvoicesProvider._({
    required YearlyInvoicesFamily super.from,
    required (int, int) super.argument,
  }) : super(
         retry: null,
         name: r'yearlyInvoicesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$yearlyInvoicesHash();

  @override
  String toString() {
    return r'yearlyInvoicesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<InvoiceWithServices>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<InvoiceWithServices>> create(Ref ref) {
    final argument = this.argument as (int, int);
    return yearlyInvoices(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is YearlyInvoicesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$yearlyInvoicesHash() => r'0e4caa99834f7d126bd6edbdbc01779f36188ff3';

final class YearlyInvoicesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<InvoiceWithServices>>,
          (int, int)
        > {
  YearlyInvoicesFamily._()
    : super(
        retry: null,
        name: r'yearlyInvoicesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  YearlyInvoicesProvider call(int year, int childId) =>
      YearlyInvoicesProvider._(argument: (year, childId), from: this);

  @override
  String toString() => r'yearlyInvoicesProvider';
}
