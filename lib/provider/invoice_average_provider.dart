import 'package:nannyplus/utils/database_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invoice_average_provider.g.dart';

@riverpod
FutureOr<Map<int, double>> invoiceAverages(
  InvoiceAveragesRef ref,
  int childId,
) async {
  final db = await DatabaseUtil.instance;
  final result = await db.rawQuery(
    '''
SELECT 
      SUBSTRING(date, 1, 4) year, 
      AVG(total) avg 
FROM 
      invoices i 
WHERE 
      i.childId = ? 
GROUP BY 
      SUBSTRING(date, 1, 4); 
    ''',
    [childId],
  );

  return {
    for (final row in result)
      int.parse(row['year'] as String): row['avg']! as double,
  };
}
