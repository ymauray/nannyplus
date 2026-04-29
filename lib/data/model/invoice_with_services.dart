import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/data/model/service.dart';

@immutable
class InvoiceWithServices {
  const InvoiceWithServices({
    required this.invoice,
    required this.services,
    required this.enfants,
  });
  final Invoice invoice;
  final List<Service> services;
  final Map<int, String> enfants;
  InvoiceWithServices copyWith({
    Invoice? invoice,
    List<Service>? services,
    Map<int, String>? enfants,
  }) {
    return InvoiceWithServices(
      invoice: invoice ?? this.invoice,
      services: services ?? this.services,
      enfants: enfants ?? this.enfants,
    );
  }
}
