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
  );

  final List<Invoice> invoices;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceListLoaded && listEquals(other.invoices, invoices);
  }

  @override
  int get hashCode => invoices.hashCode;

  InvoiceListLoaded copyWith({
    List<Invoice>? invoices,
  }) {
    return InvoiceListLoaded(
      invoices ?? this.invoices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoices': invoices.map((x) => x.toMap()).toList(),
    };
  }

  factory InvoiceListLoaded.fromMap(Map<String, dynamic> map) {
    return InvoiceListLoaded(
      List<Invoice>.from(map['invoices']?.map((x) => Invoice.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceListLoaded.fromJson(String source) =>
      InvoiceListLoaded.fromMap(json.decode(source));

  @override
  String toString() => 'InvoiceListLoaded(invoices: $invoices)';
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
