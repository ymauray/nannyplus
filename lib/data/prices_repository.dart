import 'package:flutter/cupertino.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/utils/database_util.dart';

class PricesRepository {
  const PricesRepository();

  Future<List<Price>> getPriceList() async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query(
      'prices',
      orderBy: 'sortOrder asc',
      where: 'deleted = ?',
      whereArgs: [0],
    );
    final priceList = rows.map(Price.fromMap).toList();

    return priceList;
  }

  //Future<Set<int>> getPricesInUse() async {
  //  var database = await DatabaseUtil.instance;
  //  //var rows = await database.query(
  //  //  "services",
  //  //  where: "invoiced = ?",
  //  //  whereArgs: [0],
  //  //);
  //  var rows = await database.query("services");
  //  var prices = rows.map((row) => row['priceId'] as int).toSet();

  //  return prices;
  //}

  Future<void> reorder(int oldIndex, int newIndex) async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query('prices', orderBy: 'sortOrder asc');
    final priceList = rows.map(Price.fromMap).toList();

    final price = priceList.removeAt(oldIndex);
    if (newIndex > oldIndex) {
      newIndex--;
    }
    priceList.insert(newIndex, price);

    for (var i = 0; i < priceList.length; i++) {
      final price = priceList[i];
      await database.update(
        'prices',
        price.copyWith(sortOrder: i).toMap(),
        where: 'id = ?',
        whereArgs: [price.id],
      );
    }
  }

  Future<Price> create(Price price) async {
    try {
      final database = await DatabaseUtil.instance;
      final rows = await database
          .rawQuery('SELECT MAX(sortOrder) AS maxSortOrder FROM prices');
      var maxSortOrder = 0;
      if (rows.isNotEmpty) {
        maxSortOrder = ((rows.first)['maxSortOrder'] ?? 0) as int;
      }
      final id = await database.insert(
        'prices',
        price.copyWith(sortOrder: 1 + maxSortOrder).toMap(),
      );

      return read(id);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Price> read(int id) async {
    final database = await DatabaseUtil.instance;
    final row =
        await database.query('prices', where: 'id = ?', whereArgs: [id]);

    return Price.fromMap(row.first);
  }

  Future<Price> update(Price price) async {
    final database = await DatabaseUtil.instance;

    await database.update(
      'prices',
      price.toMap(),
      where: 'id = ?',
      whereArgs: [price.id],
    );

    return await read(price.id!);
  }

  Future<void> delete(int priceId) async {
    final database = await DatabaseUtil.instance;

    await database.delete(
      'prices',
      where: 'id = ?',
      whereArgs: [priceId],
    );
  }
}
