// ignore_for_file: argument_type_not_assignable
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

class InvoiceListLoaded extends InvoiceListState {
  const InvoiceListLoaded(
    this.invoices,
    this.daysBeforeUnpaidInvoiceNotification,
    this.phoneNumber,
  );

  final List<Invoice> invoices;
  final int daysBeforeUnpaidInvoiceNotification;
  final String phoneNumber;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceListLoaded &&
        listEquals(other.invoices, invoices) &&
        other.daysBeforeUnpaidInvoiceNotification ==
            daysBeforeUnpaidInvoiceNotification &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode =>
      invoices.hashCode ^
      daysBeforeUnpaidInvoiceNotification.hashCode ^
      phoneNumber.hashCode;

  InvoiceListLoaded copyWith({
    List<Invoice>? invoices,
    int? daysBeforeUnpaidInvoiceNotification,
    String? phoneNumber,
  }) {
    return InvoiceListLoaded(
      invoices ?? this.invoices,
      daysBeforeUnpaidInvoiceNotification ??
          this.daysBeforeUnpaidInvoiceNotification,
      phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoices': invoices.map((x) => x.toMap()).toList(),
      'daysBeforeUnpaidInvoiceNotification':
          daysBeforeUnpaidInvoiceNotification,
      'phoneNumber': phoneNumber,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'InvoiceListLoaded(invoices: $invoices, '
      'daysBeforeUnpaidInvoiceNotification: $daysBeforeUnpaidInvoiceNotification, '
      'phoneNumber: $phoneNumber'
      ')';
}

// ---------------------------------------------------------------------------

class InvoiceListError extends InvoiceListState {
  const InvoiceListError(this.message);
  final String message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceListError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// ---------------------------------------------------------------------------
