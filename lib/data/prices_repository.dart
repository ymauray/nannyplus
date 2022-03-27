import '../utils/database_util.dart';
import 'model/price.dart';

class PricesRepository {
  const PricesRepository();

  Future<List<Price>> getPriceList() async {
    var database = await DatabaseUtil.instance;
    var rows = await database.query("prices", orderBy: "label asc");
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

  Future<Price> create(Price price) async {
    var database = await DatabaseUtil.instance;
    var id = await database.insert("prices", price.toMap());

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
