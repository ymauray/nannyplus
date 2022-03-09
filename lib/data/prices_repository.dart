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
}
