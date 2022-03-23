import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static const String keyLine1 = 'line1';
  static const String keyLine1FontFamily = 'line1FontFamily';
  static const String keyLine1FontAsset = 'line1FontAsset';
  static const String keyLine2 = 'line2';
  static const String keyLine2FontFamily = 'line2FontFamily';
  static const String keyLine2FontAsset = 'line2FontAsset';

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

  String get line1FontFamily => _prefs?.getString(keyLine1FontFamily) ?? "";
  set line1FontFamily(String value) =>
      _prefs?.setString(keyLine1FontFamily, value);

  String get line1FontAsset => _prefs?.getString(keyLine1FontAsset) ?? "";
  set line1FontAsset(String value) =>
      _prefs?.setString(keyLine1FontAsset, value);

  String get line2FontFamily => _prefs?.getString(keyLine2FontFamily) ?? "";
  set line2FontFamily(String value) =>
      _prefs?.setString(keyLine2FontFamily, value);

  String get line2FontAsset => _prefs?.getString(keyLine2FontAsset) ?? "";
  set line2FontAsset(String value) =>
      _prefs?.setString(keyLine2FontAsset, value);
}
