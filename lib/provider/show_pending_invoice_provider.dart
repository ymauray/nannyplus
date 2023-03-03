import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_pending_invoice_provider.g.dart';

@riverpod
class ShowPendingInvoice extends _$ShowPendingInvoice {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
