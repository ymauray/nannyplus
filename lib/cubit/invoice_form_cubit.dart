import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../data/children_repository.dart';
import '../data/invoices_repository.dart';
import '../data/model/child.dart';
import '../data/model/invoice.dart';
import '../data/services_repository.dart';

part 'invoice_form_state.dart';

class InvoiceFormCubit extends Cubit<InvoiceFormState> {
  InvoiceFormCubit(
    this.childrenRepository,
    this.servicesRepository,
    this.invoicesRepository,
  ) : super(const InvoiceFormInitial());

  final ChildrenRepository childrenRepository;
  final ServicesRepository servicesRepository;
  final InvoicesRepository invoicesRepository;

  Future<void> init(int childId) async {
    emit(const InvoiceFormInitial());

    var mainChild = await childrenRepository.read(childId);
    var children = await childrenRepository.getChildList(false);

    emit(InvoiceFormLoaded(
      child: mainChild,
      children: children
          .where((child) => child != mainChild)
          .map((child) => InvoiceFormChild(child, false))
          .toList(),
    ));
  }

  Future<void> toggle(InvoiceFormChild formChild) async {
    var children = ((List<InvoiceFormChild> children) sync* {
      for (var child in children) {
        yield child == formChild
            ? child.copyWith(checked: !child.checked)
            : child;
      }
    })((state as InvoiceFormLoaded).children);

    emit(InvoiceFormLoaded(
      child: (state as InvoiceFormLoaded).child,
      children: children.toList(),
    ));
  }

  Future<bool> createInvoice() async {
    final child = (state as InvoiceFormLoaded).child;
    final children = [child] +
        (state as InvoiceFormLoaded)
            .children
            .where((formChild) => formChild.checked)
            .map((formChild) => formChild.child)
            .toList();

    var services = await Future.wait(
      children.map((child) => servicesRepository.getServices(child)),
    );

    if (services.expand((list) => list).isEmpty) {
      return false;
    } else {
      var invoiceNumber = await invoicesRepository.getNextNumber();

      var invoice = await invoicesRepository.create(Invoice(
        number: invoiceNumber,
        childId: child.id!,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        total: 0.0,
        parentsName: child.parentsName!,
        address: child.address!,
        paid: 0,
      ));

      var total = 0.0;

      for (var child in children) {
        var services = await servicesRepository.getServices(child);
        for (var service in services) {
          await servicesRepository.update(
            service.copyWith(
              invoiced: 1,
              invoiceId: invoice.id,
            ),
          );
          total += service.total;
        }
      }

      await invoicesRepository.update(invoice.copyWith(total: total));

      return true;
    }
  }
}
