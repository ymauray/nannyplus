import 'package:intl/intl.dart';

import '../data/model/child.dart';
import '../data/model/service.dart';
import '../data/model/service_info.dart';
import '../utils/database_util.dart';
import '../utils/list_extensions.dart';

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
      where: 'childId = ? AND date = ? AND invoiced = ?',
      whereArgs: [childId, DateFormat('yyyy-MM-dd').format(date), 0],
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

  @Deprecated("Use getServiceInfoPerChild instead")
  Future<double> getPendingTotal() async {
    var db = await DatabaseUtil.instance;

    var rows =
        await db.query('services', where: 'invoiced = ?', whereArgs: [0]);

    return rows.fold<double>(
      0.0,
      (sum, row) => sum + (row['total']! as double),
    );
  }

  @Deprecated("Use getServiceInfoPerChild instead")
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

  Future<Map<int, ServiceInfo>> getServiceInfoPerChild() async {
    var db = await DatabaseUtil.instance;

    var rows =
        await db.query('services', where: 'invoiced = ?', whereArgs: [0]);

    var groupedRows = rows
        .map((row) => Service.fromMap(row))
        .toList()
        .groupBy<int>((service) => service.childId)
        .toList();

    var map = <int, ServiceInfo>{
      for (var group in groupedRows)
        group.key: ServiceInfo(
          pendingTotal: group.value.fold(
            0.0,
            (previousValue, service) => previousValue + service.total,
          ),
        ),
    };

    rows = await db.rawQuery(
      'SELECT childId, MAX(date) FROM services, children '
      'WHERE children.id = services.childId AND children.archived = ? '
      'GROUP BY childId',
      [0],
    );
    var map2 = <int, String>{
      for (var row in rows) row['childId'] as int: row['MAX(date)'] as String,
    };

    for (var childId in map.keys) {
      if (map2.containsKey(childId)) {
        map[childId]!.lastEnty =
            DateFormat('yyyy-MM-dd').parse(map2[childId] as String);
      }
    }
    for (var row in rows) {
      if (!map.containsKey(row['childId'] as int)) {
        map[row['childId'] as int] = ServiceInfo(
          pendingTotal: 0.0,
          lastEnty: DateFormat('yyyy-MM-dd').parse(row['MAX(date)'] as String),
        );
      }
    }

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
