import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/data/model/service_info.dart';
import 'package:nannyplus/data/model/statement_line.dart';
import 'package:nannyplus/data/model/statement_summary.dart';
import 'package:nannyplus/src/statement_view/statement_view.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:nannyplus/utils/list_extensions.dart';

class ServicesRepository {
  const ServicesRepository();

  Future<Service> create(Service service) async {
    final db = await DatabaseUtil.instance;
    final id = await db.insert('services', service.toMap()..['id'] = null);

    return read(id);
  }

  Future<Service> read(int id) async {
    final db = await DatabaseUtil.instance;
    final service =
        await db.query('services', where: 'id = ?', whereArgs: [id]);

    return Service.fromMap(service.first);
  }

  Future<Service> update(Service service) async {
    final db = await DatabaseUtil.instance;
    await db.update(
      'services',
      service.toMap(),
      where: 'id = ?',
      whereArgs: [service.id],
    );

    return read(service.id!);
  }

  Future<void> delete(int id) async {
    final db = await DatabaseUtil.instance;
    await db.delete('services', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Service>> getServices(Child child) async {
    final db = await DatabaseUtil.instance;

    final rows = await db.query(
      'services',
      where: 'childId = ? AND invoiced = ?',
      whereArgs: [child.id, 0],
      orderBy: 'date DESC',
    );

    return rows.map(Service.fromMap).toList();
  }

  Future<List<Service>> getServicesForInvoice(int invoiceId) async {
    final db = await DatabaseUtil.instance;

    final rows = await db.query(
      'services',
      where: 'invoiceId = ?',
      whereArgs: [invoiceId],
      orderBy: 'date DESC',
    );

    return rows.map(Service.fromMap).toList();
  }

  Future<List<Service>> getServicesForDate(DateTime date) async {
    final db = await DatabaseUtil.instance;

    final rows = await db.query(
      'services',
      where: 'date = ?',
      whereArgs: [DateFormat('yyyy-MM-dd').format(date)],
    );

    return rows.map(Service.fromMap).toList();
  }

  Future<void> deleteForChildAndDate(int childId, String date) async {
    final db = await DatabaseUtil.instance;
    await db.delete(
      'services',
      where: 'childId = ? AND date = ?',
      whereArgs: [childId, date],
    );
  }

  Future<List<Service>> getServicesForChildAndDate(
    int childId,
    DateTime date,
  ) async {
    final db = await DatabaseUtil.instance;

    final rows = await db.query(
      'services',
      where: 'childId = ? AND date = ? AND invoiced = ?',
      whereArgs: [childId, DateFormat('yyyy-MM-dd').format(date), 0],
    );

    return rows.map(Service.fromMap).toList();
  }

  Future<List<Service>> getRecentServices(int childId) async {
    final db = await DatabaseUtil.instance;

    final rows = await db.query(
      'services',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'date DESC',
    );

    return rows.map(Service.fromMap).toList();
  }

  Future<Map<int, ServiceInfo>> getServiceInfoPerChild() async {
    final db = await DatabaseUtil.instance;

    var rows =
        await db.query('services', where: 'invoiced = ?', whereArgs: [0]);

    final groupedRows = rows
        .map(Service.fromMap)
        .toList()
        .groupBy<num>((service) => service.childId)
        .toList();

    final map = <int, ServiceInfo>{
      for (var group in groupedRows)
        group.key as int: ServiceInfo(
          pendingInvoice: 0,
          pendingTotal: group.value.fold(
            0,
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
    final map2 = <int, String>{
      for (var row in rows) row['childId'] as int: row['MAX(date)'] as String,
    };

    for (final childId in map.keys) {
      if (map2.containsKey(childId)) {
        map[childId] = map[childId]!.copyWith(
          lastEnty: DateFormat('yyyy-MM-dd').parse(map2[childId] as String),
        );
      }
    }

    for (final row in rows) {
      if (!map.containsKey(row['childId'] as int)) {
        map[row['childId'] as int] = ServiceInfo(
          pendingTotal: 0,
          pendingInvoice: 0,
          lastEnty: DateFormat('yyyy-MM-dd').parse(row['MAX(date)'] as String),
        );
      }
    }

    rows = await db.query(
      'invoices',
      where: 'paid = ?',
      whereArgs: [0],
    );

    final groupedInvoices =
        rows.groupBy<num>((row) => row['childId'] as int).toList();

    final invoicesMap = <int, double>{
      for (var group in groupedInvoices)
        group.key as int: group.value.fold(
          0,
          (previousValue, row) =>
              previousValue + double.parse(row['total']!.toString()),
        ),
    };

    for (final childId in map.keys) {
      if (invoicesMap.containsKey(childId)) {
        map[childId] = map[childId]!.copyWith(
          pendingInvoice: invoicesMap[childId],
        );
      }
    }

    return map;
  }

  Future<List<int>> getUndeletableChildren() async {
    final db = await DatabaseUtil.instance;

    final rows = await db.query('services', groupBy: 'childId');

    final undeletables = rows.map((row) => row['childId'] as int).toList();

    return undeletables;
  }

  Future<void> unlinkInvoice(int invoiceId) async {
    final db = await DatabaseUtil.instance;

    await db.update(
      'services',
      {
        'invoiceId': null,
        'invoiced': 0,
      },
      where: 'invoiceId = ?',
      whereArgs: [invoiceId],
    );

    await db.delete(
      'services',
      where: 'priceId = ? AND invoiceId = ?',
      whereArgs: [-1, invoiceId],
    );
  }

  Future<List<StatementLine>> getStatementLines(
    StatementViewType type,
    DateTime date,
  ) async {
    final db = await DatabaseUtil.instance;

    final endDate = (type == StatementViewType.monthly)
        ? DateTime(date.year, date.month + 1)
        : DateTime(date.year + 1);

    final rows = await db.rawQuery(
      'SELECT '
      ' s.priceLabel, '
      ' s.priceAmount, '
      ' s.isFixedPrice, '
      ' SUM(s.hours) + CAST(SUM(s.minutes) / 60 as int) hours, '
      ' SUM(s.minutes) - 60 * CAST(SUM(s.minutes) / 60 as int) minutes, '
      ' COUNT(1) count, '
      ' SUM(s.total) total '
      'FROM '
      ' services s '
      'WHERE '
      ' s.priceId != -1 '
      ' AND s.date >= ? '
      ' AND s.date < ? '
      'GROUP BY '
      ' s.priceLabel '
      'ORDER BY '
      ' s.isFixedPrice, '
      ' s.priceLabel',
      [
        DateFormat('yyyy-MM-dd').format(date),
        DateFormat('yyyy-MM-dd').format(endDate),
      ],
    );

    final list = rows.map(StatementLine.fromMap).toList();

    return list;
  }

  Future<List<StatementSummary>> getStatementsSummary() async {
    final db = await DatabaseUtil.instance;

    final rows = await db.rawQuery(
      'SELECT '
      ' STRFTIME("%Y-%m", date) month, '
      ' SUM(s.total) total '
      'FROM '
      ' services s '
      'GROUP BY '
      ' month '
      'ORDER BY '
      ' month DESC',
    );

    final list = rows.map(StatementSummary.fromMap).toList();

    return list;
  }

  Future<Service> addDummyService(Child child) async {
    final db = await DatabaseUtil.instance;
    final service = Service(
      childId: child.id!,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      priceId: -1,
      isFixedPrice: 1,
      total: 0,
    );
    final id = await db.insert('services', service.toMap()..['id'] = null);

    return service.copyWith(id: id);
  }
}
