import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/invoices_repository.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/utils/types.dart';

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

    final mainChild = await childrenRepository.read(childId);
    final children = await childrenRepository.getChildList(false);

    emit(
      InvoiceFormLoaded(
        child: mainChild,
        children: children
            .where((child) => child != mainChild)
            .map((child) => InvoiceFormChild(child, false))
            .toList(),
      ),
    );
  }

  Future<void> toggle(InvoiceFormChild formChild) async {
    final children = ((List<InvoiceFormChild> children) sync* {
      for (final child in children) {
        yield child == formChild
            ? child.copyWith(checked: !child.checked)
            : child;
      }
    })((state as InvoiceFormLoaded).children);

    emit(
      InvoiceFormLoaded(
        child: (state as InvoiceFormLoaded).child,
        children: children.toList(),
      ),
    );
  }

  Future<bool> createInvoice() async {
    final child = (state as InvoiceFormLoaded).child;
    final children = [child] +
        (state as InvoiceFormLoaded)
            .children
            .where((formChild) => formChild.checked)
            .map((formChild) => formChild.child)
            .toList();

    final services = await Future.wait(
      children.map(servicesRepository.getServices),
    );

    if (services.expand((list) => list).isEmpty) {
      return false;
    } else {
      final invoiceNumber = await invoicesRepository.getNextNumber();

      final invoice = await invoicesRepository.create(
        Invoice(
          number: invoiceNumber,
          childId: child.id!,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          total: 0,
          parentsName: child.parentsName!,
          address: child.address!,
          paid: 0,
        ),
      );

      var total = 0.0;

      for (final child in children) {
        final dummyService = await servicesRepository.addDummyService(child);
        final services = await servicesRepository.getServices(child);
        for (final service in [dummyService, ...services]) {
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
