import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/period.dart';
import 'package:nannyplus/utils/database_util.dart';

class PeriodRepository {
  // -- CRUD --

  Future<Period> createPeriod(
    int childId,
    String day,
    TimeOfDay from,
    TimeOfDay to,
    int sortOrder,
  ) async {
    final database = await DatabaseUtil.instance;
    final period = Period(
      childId: childId,
      day: day,
      from: from,
      to: to,
      sortOrder: sortOrder,
    );

    try {
      final id = await database.insert(
        'periods',
        period.toJson(),
      );

      return readPeriod(id);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Period> readPeriod(int periodId) async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query(
      'periods',
      where: 'id = ?',
      whereArgs: [periodId],
    );

    return Period.fromJson(rows.first);
  }

  Future<void> updatePeriod(Period period) async {
    final database = await DatabaseUtil.instance;
    await database.update(
      'periods',
      period.toJson(),
      where: 'id = ?',
      whereArgs: [period.id],
    );
  }

  Future<void> deletePeriod(int periodId) async {
    final database = await DatabaseUtil.instance;
    await database.delete(
      'periods',
      where: 'id = ?',
      whereArgs: [periodId],
    );
  }

  // -- Other operations --

  Future<List<Period>> load(int childId) async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query(
      'periods',
      where: 'childId = ?',
      orderBy: 'sortOrder ASC',
      whereArgs: [childId],
    );
    final periodList = rows.map(Period.fromJson).toList()
        //..sort((a, b) => a.compareTo(b));
        ;

    return periodList;
  }

  FutureOr<void> sortPeriods(int childId) async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query(
      'periods',
      where: 'childId = ?',
      whereArgs: [childId],
    );
    final periods = rows.map(Period.fromJson).toList()
      ..sort((a, b) => a.compareTo(b));
    for (var i = 0; i < periods.length; i++) {
      await database.update(
        'periods',
        periods[i].copyWith(sortOrder: i).toJson(),
        where: 'id = ?',
        whereArgs: [periods[i].id],
      );
    }
  }
}
