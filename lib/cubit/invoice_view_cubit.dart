import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/data/prices_repository.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/utils/types.dart';

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
    final services =
        await _servicesRepository.getServicesForInvoice(invoice.id!);
    services.sort((a, b) {
      if (a.priceId == -1) {
        return 1;
      }
      if (b.priceId == -1) {
        return -1;
      }
      return prices.firstWhere((price) => price.id == a.priceId).sortOrder -
          prices.firstWhere((price) => price.id == b.priceId).sortOrder;
    });
    final children = await Future.wait(
      services
          .map((service) => service.childId)
          .toSet()
          .map(_childrenRepository.read),
    );
    emit(
      InvoiceViewLoaded(
        services.where((service) => service.priceId >= 0).toList(),
        children,
      ),
    );
  }
}
