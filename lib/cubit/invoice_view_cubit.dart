import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';

import '../data/children_repository.dart';
import '../data/model/invoice.dart';
import '../data/services_repository.dart';

part 'invoice_view_state.dart';

class InvoiceViewCubit extends Cubit<InvoiceViewState> {
  InvoiceViewCubit(
    this._servicesRepository,
    this._childrenRepository,
  ) : super(const InvoiceViewInitial());

  final ServicesRepository _servicesRepository;
  final ChildrenRepository _childrenRepository;

  Future<void> init(Invoice invoice) async {
    emit(const InvoiceViewInitial());
    final services =
        await _servicesRepository.getServicesForInvoice(invoice.id!);
    final children = await Future.wait(services
        .map((service) => service.childId)
        .toSet()
        .map((childId) => _childrenRepository.read(childId)));
    emit(
      InvoiceViewLoaded(services, children),
    );
  }
}
