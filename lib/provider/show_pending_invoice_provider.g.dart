// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_pending_invoice_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShowPendingInvoice)
final showPendingInvoiceProvider = ShowPendingInvoiceProvider._();

final class ShowPendingInvoiceProvider
    extends $NotifierProvider<ShowPendingInvoice, bool> {
  ShowPendingInvoiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'showPendingInvoiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$showPendingInvoiceHash();

  @$internal
  @override
  ShowPendingInvoice create() => ShowPendingInvoice();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$showPendingInvoiceHash() =>
    r'b6f8cbd5aa9fb906c9c17aeaf6fd25fe30dce786';

abstract class _$ShowPendingInvoice extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
