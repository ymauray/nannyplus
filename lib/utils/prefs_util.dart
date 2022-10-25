import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static const String keyLine1 = 'line1';
  static const String keyLine1FontFamily = 'line1FontFamily';
  static const String keyLine1FontAsset = 'line1FontAsset';
  static const String keyLine2 = 'line2';
  static const String keyLine2FontFamily = 'line2FontFamily';
  static const String keyLine2FontAsset = 'line2FontAsset';
  static const String keyConditions = 'conditions';
  static const String keyBankDetails = 'bankDetails';
  static const String keyName = 'name';
  static const String keyAddress = 'address';
  static const String keyShowOnboarding = 'showOnboarding';

  static PrefsUtil? _instance;

  SharedPreferences? _prefs;

  static Future<PrefsUtil> getInstance() async {
    if (_instance != null) return _instance!;
    _instance = PrefsUtil().._prefs = await SharedPreferences.getInstance();

    return _instance!;
  }

  Future<void> clear() async {
    await _prefs?.clear();
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

  String get conditions => _prefs?.getString(keyConditions) ?? "";
  set conditions(String value) => _prefs?.setString(keyConditions, value);

  String get bankDetails => _prefs?.getString(keyBankDetails) ?? "";
  set bankDetails(String value) => _prefs?.setString(keyBankDetails, value);

  String get name => _prefs?.getString(keyName) ?? "";
  set name(String value) => _prefs?.setString(keyName, value);

  String get address => _prefs?.getString(keyAddress) ?? "";
  set address(String value) => _prefs?.setString(keyAddress, value);

  bool get showOnboarding => _prefs?.getBool(keyShowOnboarding) ?? true;
  set showOnboarding(bool value) => _prefs?.setBool('showOnboarding', value);
}
