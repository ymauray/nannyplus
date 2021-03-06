import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../data/invoices_repository.dart';
import '../data/model/invoice.dart';
import '../data/services_repository.dart';

part 'invoice_list_state.dart';

class InvoiceListCubit extends Cubit<InvoiceListState> {
  InvoiceListCubit(
    this._invoicesRepository,
    this._servicesRepository,
  ) : super(const InvoiceListInitial());

  final InvoicesRepository _invoicesRepository;
  final ServicesRepository _servicesRepository;

  Future<void> loadInvoiceList(int childId) async {
    try {
      final invoices = await _invoicesRepository.getInvoiceList(childId);

      emit(InvoiceListLoaded(invoices));
    } catch (e) {
      emit(InvoiceListError(e.toString()));
    }
  }

  Future<void> deleteInvoice(Invoice invoice) async {
    try {
      var childId = invoice.childId;
      var invoiceId = invoice.id!;
      await _servicesRepository.unlinkInvoice(invoiceId);
      await _invoicesRepository.delete(invoiceId);
      await loadInvoiceList(childId);
    } catch (e) {
      emit(InvoiceListError(e.toString()));
    }
  }
}
