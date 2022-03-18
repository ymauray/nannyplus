import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';

import '../utils/database_util.dart';

class ServicesRepository {
  const ServicesRepository();

  Future<Service> create(Service service) async {
    var db = await DatabaseUtil.instance;
    var id = await db.insert('services', service.toMap());
    return read(id);
  }

  Future<Service> read(int id) async {
    var db = await DatabaseUtil.instance;
    var service = await db.query('services', where: 'id = ?', whereArgs: [id]);
    return Service.fromMap(service.first);
  }

  Future<Service> update(Service service) async {
    var db = await DatabaseUtil.instance;
    await db.update('services', service.toMap(),
        where: 'id = ?', whereArgs: [service.id]);
    return read(service.id!);
  }

  Future<void> delete(int id) async {
    var db = await DatabaseUtil.instance;
    db.delete('services', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Service>> getServices(Child child) async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query('services',
        where: 'childId = ? AND invoiced = ?',
        whereArgs: [child.id, 0],
        orderBy: 'date DESC');
    return rows.map((e) => Service.fromMap(e)).toList();
  }

  Future<List<Service>> getServicesForInvoice(int invoiceId) async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query('services',
        where: 'invoiceId = ?', whereArgs: [invoiceId], orderBy: 'date DESC');

    return rows.map((e) => Service.fromMap(e)).toList();
  }
}
