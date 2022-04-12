import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../data/children_repository.dart';
import '../data/model/child.dart';
import '../data/model/invoice.dart';
import '../data/model/service.dart';
import '../data/prices_repository.dart';
import '../data/services_repository.dart';

part 'invoice_view_state.dart';

class InvoiceViewCubit extends Cubit<InvoiceViewState> {
  InvoiceViewCubit(
    this._servicesRepository,
    this._childrenRepository,
    this._pricesRepository,
  ) : super(const InvoiceViewInitial());

  final ServicesRepository _servicesRepository;
  final ChildrenRepository _childrenRepository;
  final PricesRepository _pricesRepository;

  Future<void> init(Invoice invoice) async {
    emit(const InvoiceViewInitial());
    final prices = await _pricesRepository.getPriceList();
    var services = await _servicesRepository.getServicesForInvoice(invoice.id!);
    services.sort((a, b) =>
        prices.firstWhere((price) => price.id == a.priceId).sortOrder -
        prices.firstWhere((price) => price.id == b.priceId).sortOrder);
    final children = await Future.wait(services
        .map((service) => service.childId)
        .toSet()
        .map((childId) => _childrenRepository.read(childId)));
    emit(
      InvoiceViewLoaded(services, children),
    );
  }
}
