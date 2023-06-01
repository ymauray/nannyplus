import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
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
  static const String keySortListByLastName = 'sortListByLastName';
  static const String keyShowFirstNameBeforeLastName =
      'showFirstNameBeforeLastName';
  static const String keyDaysBeforeUnpaidInvoiceNotification =
      'daysBeforeUnpaidInvoiceNotification';
  static const String keyNotificationMessage = 'notificationMessage';

  static PrefsUtil? _instance;

  late SharedPreferences _prefs;
  late GettextLocalizations _gettext;

  static Future<PrefsUtil> getInstance() async {
    if (_instance != null) return _instance!;
    _instance = PrefsUtil()
      .._prefs = await SharedPreferences.getInstance()
      .._gettext = await GettextLocalizationsDelegate().load(I18nUtils.locale);
    return _instance!;
  }

  static PrefsUtil getInstanceSync() {
    if (_instance != null) return _instance!;
    throw Exception('PrefsUtil not initialized');
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  String get line1 => _prefs.getString(keyLine1) ?? '';
  set line1(String value) => _prefs.setString(keyLine1, value);

  String get line2 => _prefs.getString(keyLine2) ?? '';
  set line2(String value) => _prefs.setString(keyLine2, value);

  String get line1FontFamily => _prefs.getString(keyLine1FontFamily) ?? '';
  set line1FontFamily(String value) =>
      _prefs.setString(keyLine1FontFamily, value);

  String get line1FontAsset => _prefs.getString(keyLine1FontAsset) ?? '';
  set line1FontAsset(String value) =>
      _prefs.setString(keyLine1FontAsset, value);

  String get line2FontFamily => _prefs.getString(keyLine2FontFamily) ?? '';
  set line2FontFamily(String value) =>
      _prefs.setString(keyLine2FontFamily, value);

  String get line2FontAsset => _prefs.getString(keyLine2FontAsset) ?? '';
  set line2FontAsset(String value) =>
      _prefs.setString(keyLine2FontAsset, value);

  String get conditions => _prefs.getString(keyConditions) ?? '';
  set conditions(String value) => _prefs.setString(keyConditions, value);

  String get bankDetails => _prefs.getString(keyBankDetails) ?? '';
  set bankDetails(String value) => _prefs.setString(keyBankDetails, value);

  String get name => _prefs.getString(keyName) ?? '';
  set name(String value) => _prefs.setString(keyName, value);

  String get address => _prefs.getString(keyAddress) ?? '';
  set address(String value) => _prefs.setString(keyAddress, value);

  bool get showOnboarding => _prefs.getBool(keyShowOnboarding) ?? true;
  set showOnboarding(bool value) => _prefs.setBool(keyShowOnboarding, value);

  bool get sortListByLastName => _prefs.getBool(keySortListByLastName) ?? true;
  set sortListByLastName(bool value) =>
      _prefs.setBool(keySortListByLastName, value);

  bool get showFirstNameBeforeLastName =>
      _prefs.getBool(keyShowFirstNameBeforeLastName) ?? true;
  set showFirstNameBeforeLastName(bool value) =>
      _prefs.setBool(keyShowFirstNameBeforeLastName, value);

  int get daysBeforeUnpaidInvoiceNotification =>
      _prefs.getInt(keyDaysBeforeUnpaidInvoiceNotification) ?? 10;
  set daysBeforeUnpaidInvoiceNotification(int value) =>
      _prefs.setInt(keyDaysBeforeUnpaidInvoiceNotification, value);

  String get notificationMessage =>
      _prefs.getString(keyNotificationMessage) ??
      _gettext.t('You have unpaid invoices', []);
  set notificationMessage(String value) =>
      _prefs.setString(keyNotificationMessage, value);
}
