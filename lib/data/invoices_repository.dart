import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/utils/database_util.dart';

class InvoicesRepository {
  const InvoicesRepository();

  Future<List<Invoice>> getInvoiceList(
    int childId, {
    required bool loadPaidInvoices,
  }) async {
    final db = await DatabaseUtil.instance;
    var rows = await db.query(
      'invoices',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'date desc',
    );

    if (!loadPaidInvoices) {
      rows = rows.where((row) => row['paid'] == 0).toList();
    }

    return rows.map(Invoice.fromMap).toList();
  }

  Future<Invoice> create(Invoice invoice) async {
    final db = await DatabaseUtil.instance;
    final id = await db.insert('invoices', invoice.toMap());

    return read(id);
  }

  Future<Invoice> read(int id) async {
    final db = await DatabaseUtil.instance;
    final invoice = await db.query(
      'invoices',
      where: 'id = ?',
      whereArgs: [id],
      orderBy: 'childId',
    );

    return Invoice.fromMap(invoice.first);
  }

  Future<Invoice> update(Invoice invoice) async {
    final db = await DatabaseUtil.instance;
    await db.update(
      'invoices',
      invoice.toMap(),
      where: 'id = ?',
      whereArgs: [invoice.id],
    );

    return await read(invoice.id!);
  }

  Future<void> delete(int invoiceId) async {
    final db = await DatabaseUtil.instance;
    await db.delete(
      'invoices',
      where: 'id = ?',
      whereArgs: [invoiceId],
    );
  }

  Future<int> getNextNumber() async {
    final db = await DatabaseUtil.instance;
    final rows = await db.query('invoices', orderBy: 'number desc');

    return rows.isNotEmpty ? (rows.first['number'] as int) + 1 : 1;
  }

  Future<void> markAsPaid(int invoiceId) async {
    final db = await DatabaseUtil.instance;
    await db.update(
      'invoices',
      {'paid': 1},
      where: 'id = ?',
      whereArgs: [invoiceId],
    );
  }
}
