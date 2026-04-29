import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/data/model/invoice_with_services.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'yearly_invoices_provider.g.dart';

@riverpod
FutureOr<List<InvoiceWithServices>> yearlyInvoices(
  Ref ref,
  int year,
  int childId,
) async {
  final database = await DatabaseUtil.instance;
  final rows = await database.rawQuery(
    '''
SELECT 
  i.* 
FROM 
  invoices i 
WHERE 
  i.childId = ? 
  AND SUBSTRING(i.date, 1, 4) = ? 
ORDER BY 
  i.date DESC
  ''',
    [
      childId,
      year.toString(),
    ],
  );

  final invoicesWithServices = <InvoiceWithServices>[];

  final invoices = rows.map(Invoice.fromMap).toList();
  for (final invoice in invoices) {
    final rows = await database.query(
      'services',
      where: 'invoiceId = ?',
      whereArgs: [invoice.id],
      orderBy: 'date DESC',
    );
    final services = rows.map(Service.fromMap).toList();
    final enfants = <int, String>{};
    for (final enfant in services.map((service) => service.childId).toSet()) {
      if (!enfants.containsKey(enfant)) {
        final childRow = await database.query(
          'children',
          where: 'id = ?',
          whereArgs: [enfant],
        );
        final child = childRow.map(Child.fromMap).first;
        enfants[enfant] = child.displayName;
      }
    }

    invoicesWithServices.add(
      InvoiceWithServices(
        invoice: invoice,
        services: services,
        enfants: enfants,
      ),
    );
  }

  return invoicesWithServices;
}
