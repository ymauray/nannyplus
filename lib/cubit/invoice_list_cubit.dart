import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../data/invoices_repository.dart';
import '../data/model/invoice.dart';

part 'invoice_list_state.dart';

class InvoiceListCubit extends Cubit<InvoiceListState> {
  InvoiceListCubit(
    this._invoicesRepository,
  ) : super(const InvoiceListInitial());

  final InvoicesRepository _invoicesRepository;

  Future<void> loadInvoiceList(int childId) async {
    try {
      final invoices = await _invoicesRepository.getInvoiceList(childId);

      emit(InvoiceListLoaded(invoices));
    } catch (e) {
      emit(InvoiceListError(e.toString()));
    }
  }
}
