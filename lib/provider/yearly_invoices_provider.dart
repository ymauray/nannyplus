import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'yearly_invoices_provider.g.dart';

@riverpod
FutureOr<List<Invoice>> yearlyInvoices(
  YearlyInvoicesRef ref,
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

  return rows.map(Invoice.fromMap).toList();
}
