import 'database_util.dart';
import 'model/price.dart';

class PricesRepository {
  const PricesRepository();

  Future<List<Price>> getPriceList() async {
    var database = await DatabaseUtil.instance;
    var rows = await database.query("prices", orderBy: "label asc");
    var priceList = rows.map((row) => Price.fromMap(row)).toList();

    return priceList;
  }

  Future<void> create(Price price) async {
    var database = await DatabaseUtil.instance;
    await database.insert("prices", price.toMap());
  }
}
