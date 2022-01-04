import 'package:nannyplus/src/models/entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rates {
  double? weekHours;
  double? weekendHours;
  double? mealPreschool;
  double? mealKindergarden;
  double? night;

  bool get allSet =>
      weekHours != null &&
      weekHours! > 0 &&
      weekendHours != null &&
      weekendHours! > 0 &&
      mealPreschool != null &&
      mealPreschool! > 0 &&
      mealKindergarden != null &&
      mealKindergarden! > 0 &&
      night != null &&
      night! > 0;

  void commit() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble("weekHours", weekHours!);
    prefs.setDouble("weekendHours", weekendHours!);
    prefs.setDouble("mealPreschool", mealPreschool!);
    prefs.setDouble("mealKindergarden", mealKindergarden!);
    prefs.setDouble("night", night!);
  }

  Future<Rates> load() async {
    final prefs = await SharedPreferences.getInstance();
    weekHours = prefs.getDouble("weekHours");
    weekendHours = prefs.getDouble("weekendHours");
    mealPreschool = prefs.getDouble("mealPreschool");
    mealKindergarden = prefs.getDouble("mealKindergarden");
    night = prefs.getDouble("night");

    return this;
  }

  double computeTotal(Entry entry, bool preSchool) {
    var total = (entry.hours! + entry.minutes! / 60) *
            (entry.date!.isWeekend() ? weekendHours! : weekHours!) +
        (entry.lunch!
            ? preSchool
                ? mealPreschool!
                : mealKindergarden!
            : 0) +
        (entry.diner!
            ? preSchool
                ? mealPreschool!
                : mealKindergarden!
            : 0) +
        (entry.night! ? night! : 0);

    return total;
  }

  Entry createEntryFromJson(Map<String, dynamic> json, bool preSchool) {
    var date = DateTime.parse(json['date']);
    var hours = json['hours'];
    var minutes = json['minutes'];
    var lunch = json['lunch'];
    var diner = json['night'];
    var night = false;

    return createEntry(date, hours, minutes, lunch, diner, night, preSchool);
  }

  Entry createEntry(DateTime date, int hours, int minutes, bool lunch,
      bool diner, bool night, bool preSchool) {
    var total = (hours + minutes / 60) *
            (date.isWeekend() ? weekendHours! : weekHours!) +
        (lunch
            ? preSchool
                ? mealPreschool!
                : mealKindergarden!
            : 0) +
        (diner
            ? preSchool
                ? mealPreschool!
                : mealKindergarden!
            : 0) +
        (night ? this.night! : 0);

    return Entry.create(date, hours, minutes, lunch, diner, night, total);
  }
}
