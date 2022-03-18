import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/invoices_repository.dart';
import 'package:nannyplus/data/model/invoice.dart';

part 'invoice_list_state.dart';

class InvoiceListCubit extends Cubit<InvoiceListState> {
  final InvoicesRepository _invoicesRepository;

  InvoiceListCubit(this._invoicesRepository)
      : super(const InvoiceListInitial());

  Future<void> loadInvoiceList(int childId) async {
    try {
      final invoices = await _invoicesRepository.getInvoiceList(childId);
      emit(InvoiceListLoaded(invoices));
    } catch (e) {
      emit(InvoiceListError(e.toString()));
    }
  }
}
