import 'package:nannyplus/utils/database_util.dart';

import 'model/invoice.dart';

class InvoicesRepository {
  const InvoicesRepository();

  Future<List<Invoice>> getInvoiceList(int childId) async {
    var db = await DatabaseUtil.instance;
    var rows = await db.query(
      'invoices',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'date desc',
    );

    return rows.map((row) => Invoice.fromMap(row)).toList();
  }

  Future<Invoice> create(Invoice invoice) async {
    var db = await DatabaseUtil.instance;
    var id = await db.insert('invoices', invoice.toMap());

    return read(id);
  }

  Future<Invoice> read(int id) async {
    var db = await DatabaseUtil.instance;
    var invoice = await db.query('invoices', where: 'id = ?', whereArgs: [id]);

    return Invoice.fromMap(invoice.first);
  }
}
