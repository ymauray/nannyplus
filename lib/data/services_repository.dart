import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/utils/list_extensions.dart';

import '../utils/database_util.dart';

class ServicesRepository {
  const ServicesRepository();

  Future<Service> create(Service service) async {
    var db = await DatabaseUtil.instance;
    var id = await db.insert('services', service.toMap()..["id"] = null);

    return read(id);
  }

  Future<Service> read(int id) async {
    var db = await DatabaseUtil.instance;
    var service = await db.query('services', where: 'id = ?', whereArgs: [id]);

    return Service.fromMap(service.first);
  }

  Future<Service> update(Service service) async {
    var db = await DatabaseUtil.instance;
    await db.update(
      'services',
      service.toMap(),
      where: 'id = ?',
      whereArgs: [service.id],
    );

    return read(service.id!);
  }

  Future<void> delete(int id) async {
    var db = await DatabaseUtil.instance;
    db.delete('services', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Service>> getServices(Child child) async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query(
      'services',
      where: 'childId = ? AND invoiced = ?',
      whereArgs: [child.id, 0],
      orderBy: 'date DESC',
    );

    return rows.map((e) => Service.fromMap(e)).toList();
  }

  Future<List<Service>> getServicesForInvoice(int invoiceId) async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query(
      'services',
      where: 'invoiceId = ?',
      whereArgs: [invoiceId],
      orderBy: 'date DESC',
    );

    return rows.map((e) => Service.fromMap(e)).toList();
  }

  Future<List<Service>> getServicesForDate(DateTime date) async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query(
      'services',
      where: 'date = ?',
      whereArgs: [DateFormat('yyyy-MM-dd').format(date)],
    );

    return rows.map((row) => Service.fromMap(row)).toList();
  }

  Future<void> deleteForChildAndDate(int childId, String date) async {
    var db = await DatabaseUtil.instance;
    db.delete(
      'services',
      where: 'childId = ? AND date = ?',
      whereArgs: [childId, date],
    );
  }

  Future<List<Service>> getServicesForChildAndDate(
    int childId,
    DateTime date,
  ) async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query(
      'services',
      where: 'childId = ? AND date = ?',
      whereArgs: [childId, DateFormat('yyyy-MM-dd').format(date)],
    );

    return rows.map((row) => Service.fromMap(row)).toList();
  }

  Future<List<Service>> getRecentServices(int childId) async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query(
      'services',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'date DESC',
    );

    return rows.map((e) => Service.fromMap(e)).toList();
  }

  Future<double> getPendingTotal() async {
    var db = await DatabaseUtil.instance;

    var rows =
        await db.query('services', where: 'invoiced = ?', whereArgs: [0]);

    return rows.fold<double>(
      0.0,
      (sum, row) => sum + (row['total']! as double),
    );
  }

  Future<Map<int, double>> getPendingTotalPerChild() async {
    var db = await DatabaseUtil.instance;

    var rows =
        await db.query('services', where: 'invoiced = ?', whereArgs: [0]);

    var groupedRows = rows
        .map((row) => Service.fromMap(row))
        .toList()
        .groupBy<int>((service) => service.childId)
        .toList();
    var map = <int, double>{
      for (var group in groupedRows)
        group.key: group.value.fold(
          0.0,
          (previousValue, service) => previousValue + service.total,
        ),
    };

    return map;
  }

  Future<List<int>> getUndeletableChildren() async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query('services', groupBy: 'childId');

    var undeletables = rows.map((row) => row['childId'] as int).toList();

    return undeletables;
  }

  Future<void> unlinkInvoice(int invoiceId) async {
    var db = await DatabaseUtil.instance;

    await db.update(
      'services',
      {
        'invoiceId': null,
        'invoiced': 0,
      },
      where: 'invoiceId = ?',
      whereArgs: [invoiceId],
    );
  }
}
