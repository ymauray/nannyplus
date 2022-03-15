part of 'invoice_list_cubit.dart';

// ---------------------------------------------------------------------------

@immutable
abstract class InvoiceListState {
  const InvoiceListState();
}

// ---------------------------------------------------------------------------

class InvoiceListInitial extends InvoiceListState {
  const InvoiceListInitial();
}

// ---------------------------------------------------------------------------

class InvoiceListLoading extends InvoiceListState {
  const InvoiceListLoading();
}

// ---------------------------------------------------------------------------

class InvoiceListLoaded extends InvoiceListState {
  final List<Invoice> invoices;

  const InvoiceListLoaded(this.invoices);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceListLoaded && listEquals(other.invoices, invoices);
  }

  @override
  int get hashCode => invoices.hashCode;
}

// ---------------------------------------------------------------------------

class InvoiceListError extends InvoiceListState {
  final String message;

  const InvoiceListError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceListError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// ---------------------------------------------------------------------------
