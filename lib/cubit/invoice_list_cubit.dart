import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/invoices_repository.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/data/services_repository.dart';

part 'invoice_list_state.dart';

class InvoiceListCubit extends Cubit<InvoiceListState> {
  InvoiceListCubit(
    this._invoicesRepository,
    this._servicesRepository,
  ) : super(const InvoiceListInitial());

  final InvoicesRepository _invoicesRepository;
  final ServicesRepository _servicesRepository;

  Future<void> loadInvoiceList(
    int childId, {
    bool loadPaidInvoices = false,
  }) async {
    try {
      final invoices = await _invoicesRepository.getInvoiceList(
        childId,
        loadPaidInvoices: loadPaidInvoices,
      );

      emit(InvoiceListLoaded(invoices));
    } catch (e) {
      emit(InvoiceListError(e.toString()));
    }
  }

  Future<void> deleteInvoice(Invoice invoice) async {
    try {
      final childId = invoice.childId;
      final invoiceId = invoice.id!;
      await _servicesRepository.unlinkInvoice(invoiceId);
      await _invoicesRepository.delete(invoiceId);
      await loadInvoiceList(childId);
    } catch (e) {
      emit(InvoiceListError(e.toString()));
    }
  }

  Future<void> markInvoiceAsPaid(Invoice invoice) async {
    try {
      final childId = invoice.childId;
      final invoiceId = invoice.id!;
      await _invoicesRepository.markAsPaid(invoiceId);
      await loadInvoiceList(childId);
    } catch (e) {
      emit(InvoiceListError(e.toString()));
    }
  }
}
