import '../utils/database_util.dart';
import 'model/price.dart';

class PricesRepository {
  const PricesRepository();

  Future<List<Price>> getPriceList() async {
    var database = await DatabaseUtil.instance;
    var rows = await database.query("prices", orderBy: "sortOrder asc");
    var priceList = rows.map((row) => Price.fromMap(row)).toList();

    return priceList;
  }

  Future<Set<int>> getPricesInUse() async {
    var database = await DatabaseUtil.instance;
    var rows = await database.query(
      "services",
      where: "invoiced = ?",
      whereArgs: [0],
    );
    var prices = rows.map((row) => row['priceId'] as int).toSet();

    return prices;
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    var database = await DatabaseUtil.instance;
    var rows = await database.query("prices", orderBy: "sortOrder asc");
    var priceList = rows.map((row) => Price.fromMap(row)).toList();

    var price = priceList.removeAt(oldIndex);
    if (newIndex > oldIndex) {
      newIndex--;
    }
    priceList.insert(newIndex, price);

    for (var i = 0; i < priceList.length; i++) {
      var price = priceList[i];
      await database.update(
        "prices",
        price.copyWith(sortOrder: i).toMap(),
        where: "id = ?",
        whereArgs: [price.id],
      );
    }
  }

  Future<Price> create(Price price) async {
    var database = await DatabaseUtil.instance;
    var rows = await database
        .rawQuery('SELECT MAX(sortOrder) AS maxSortOrder FROM prices');
    var maxSortOrder = 0;
    if (rows.isNotEmpty) {
      maxSortOrder = (rows.first)['maxSortOrder'] as int;
    }
    var id = await database.insert(
      "prices",
      price.copyWith(sortOrder: 1 + maxSortOrder).toMap(),
    );

    return read(id);
  }

  Future<Price> read(int id) async {
    var database = await DatabaseUtil.instance;
    var row = await database.query("prices", where: "id = ?", whereArgs: [id]);

    return Price.fromMap(row.first);
  }

  Future<Price> update(Price price) async {
    var database = await DatabaseUtil.instance;

    await database.update(
      "prices",
      price.toMap(),
      where: "id = ?",
      whereArgs: [price.id],
    );

    return await read(price.id!);
  }

  Future<void> delete(int priceId) async {
    var database = await DatabaseUtil.instance;

    await database.delete(
      "prices",
      where: "id = ?",
      whereArgs: [priceId],
    );
  }
}
