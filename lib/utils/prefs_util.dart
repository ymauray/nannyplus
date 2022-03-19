import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static const String keyLine1 = 'line1';
  static const String keyLine2 = 'line2';

  static PrefsUtil? _instance;

  SharedPreferences? _prefs;

  static PrefsUtil getInstance() {
    _instance ??= PrefsUtil._internal();
    return _instance!;
  }

  PrefsUtil._internal() {
    SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  String get line1 => _prefs?.getString(keyLine1) ?? "";
  set line1(String value) => _prefs?.setString(keyLine1, value);

  String get line2 => _prefs?.getString(keyLine2) ?? "";
  set line2(String value) => _prefs?.setString(keyLine2, value);
}
