import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/data/repository/children_repository.dart';
import 'package:nannyplus/data/repository/invoices_repository.dart';
import 'package:nannyplus/data/repository/services_repository.dart';
import 'package:nannyplus/provider/children.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invoice_form_provider.freezed.dart';
part 'invoice_form_provider.g.dart';

@freezed
class InvoiceFormChild with _$InvoiceFormChild {
  const factory InvoiceFormChild({
    required Child child,
    required bool selected,
  }) = _InvoiceFormChild;

  factory InvoiceFormChild.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFormChildFromJson(json);
}

@freezed
class InvoiceFormState with _$InvoiceFormState {
  const factory InvoiceFormState({
    required Child child,
    required List<InvoiceFormChild> children,
    required List<String> months,
    required String? selectedMonth,
  }) = _InvoiceFormState;

  factory InvoiceFormState.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFormStateFromJson(json);
}

@riverpod
class InvoiceForm extends _$InvoiceForm {
  @override
  FutureOr<InvoiceFormState> build(int childId) async {
    final child = await ref.read(childrenRepositoryProvider).read(childId);
    final children = await ref.read(childListProvider(childId));
    final nonInvoicedServices =
        await ref.read(servicesRepositoryProvider).getNonInvoicedServices();
    final months = nonInvoicedServices.fold(
      <String>{},
      (acc, service) {
        final month = service.date.substring(0, 7);
        acc.add(month);
        return acc;
      },
    ).sorted((a, b) => a.compareTo(b));

    return InvoiceFormState(
      child: child,
      children: children
          .map(
            (child) => InvoiceFormChild(
              child: child,
              selected: false,
            ),
          )
          .toList(),
      months: months,
      selectedMonth: months.firstOrNull,
    );
  }

  FutureOr<bool> createInvoice() async {
    final child = await ref.read(childrenRepositoryProvider).read(childId);

    final children = [child] +
        state.asData!.value.children
            .where((formChild) => formChild.selected)
            .map((formChild) => formChild.child)
            .toList();

    final servicesRepository = ref.read(servicesRepositoryProvider);

    final services = await Future.wait(
      children.map(servicesRepository.getServices),
    );

    final invoicesRepository = ref.read(invoicesRepositoryProvider);

    if (services.expand((list) => list).isEmpty) {
      return false;
    } else {
      final invoiceNumber = await invoicesRepository.getNextNumber();

      final invoice = await invoicesRepository.create(
        Invoice(
          number: invoiceNumber,
          childId: child.id!,
          childFirstName: child.firstName,
          childLastName: child.lastName ?? '',
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          total: 0,
          parentsName: child.parentsName!,
          address: child.address!,
          paid: 0,
          hourCredits: '',
        ),
      );

      var total = 0.0;

      for (final child in children) {
        final dummyService = await servicesRepository.addDummyService(child);
        final services = await servicesRepository.getServices(child);
        for (final service in [
          dummyService,
          ...services.where(
            (service) =>
                service.date.substring(0, 7) ==
                state.asData!.value.selectedMonth,
          ),
        ]) {
          await servicesRepository.update(
            service.copyWith(
              invoiced: 1,
              invoiceId: invoice.id,
            ),
          );
          total += service.total;
        }
      }

      var hourCredits = '';
      for (final child in children) {
        if (child.hourCredits > 0) {
          hourCredits += '${child.firstName}: ${child.hourCredits}, ';
        }
      }
      //remove the last colon and space
      if (hourCredits.isNotEmpty) {
        hourCredits = hourCredits.substring(0, hourCredits.length - 2);
      }

      await invoicesRepository.update(
        invoice.copyWith(
          total: total,
          hourCredits: hourCredits,
        ),
      );

      return true;
    }
  }

  void toggle(InvoiceFormChild c) {
    state = state.whenData(
      (state) => state.copyWith(
        children: [
          for (final formChild in state.children)
            if (formChild.child.id == c.child.id)
              formChild.copyWith(selected: !formChild.selected)
            else
              formChild,
        ],
      ),
    );
  }

  void selectMonth(String? value) {
    state = state.whenData(
      (state) => state.copyWith(selectedMonth: value),
    );
  }
}
