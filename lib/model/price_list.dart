import 'package:shared_preferences/shared_preferences.dart';

class PriceList {
  PriceList(this.weekHours, this.weekendHours, this.mealPreschool,
      this.mealKindergarden, this.night);

  double weekHours;
  double weekendHours;
  double mealPreschool;
  double mealKindergarden;
  double night;

  bool get allSet =>
      weekHours > 0 &&
      weekendHours > 0 &&
      mealPreschool > 0 &&
      mealKindergarden > 0 &&
      night > 0;

  static Future<PriceList> load() async {
    final prefs = await SharedPreferences.getInstance();
    var priceList = PriceList(
      prefs.getDouble("weekHours") ?? 0.0,
      prefs.getDouble("weekendHours") ?? 0.0,
      prefs.getDouble("mealPreschool") ?? 0.0,
      prefs.getDouble("mealKindergarden") ?? 0.0,
      prefs.getDouble("night") ?? 0.0,
    );
    return priceList;
  }

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble("weekHours", weekHours!);
    prefs.setDouble("weekendHours", weekendHours!);
    prefs.setDouble("mealPreschool", mealPreschool!);
    prefs.setDouble("mealKindergarden", mealKindergarden!);
    prefs.setDouble("night", night!);
  }
}
