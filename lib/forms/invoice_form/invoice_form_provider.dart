import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/provider/children.dart';
import 'package:nannyplus/provider/repository/invoices_repository_provider.dart';
import 'package:nannyplus/provider/repository/services_repository_provider.dart';
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

@riverpod
class InvoiceFormChildren extends _$InvoiceFormChildren {
  @override
  FutureOr<List<InvoiceFormChild>> build(int excludedId) async {
    final children = await ref.watch(childListProvider(excludedId).future);
    return children
        .map(
          (child) => InvoiceFormChild(
            child: child,
            selected: false,
          ),
        )
        .toList();
  }

  Future<void> toggle(InvoiceFormChild c) async {
    state = AsyncValue.data(
      <InvoiceFormChild>[
        for (final formChild in state.asData!.value)
          if (formChild.child.id == c.child.id)
            formChild.copyWith(selected: !formChild.selected)
          else
            formChild,
      ],
    );
  }

  FutureOr<bool> createInvoice() async {
    final child = await ref.read(childInfoProvider(excludedId).future);

    final children = [child] +
        state.asData!.value
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
