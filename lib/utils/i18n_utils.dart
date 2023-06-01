import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class I18nUtils {
  static String get localeString {
    // ignore: deprecated_member_use
    return WidgetsBinding.instance.window.locale.toString();
  }

  static Locale get locale {
    // ignore: deprecated_member_use
    return WidgetsBinding.instance.window.locale;
  }

  //static String? get currencySymbol {
  //  var locale = WidgetsBinding.instance?.window.locale;
  //  var format = NumberFormat.simpleCurrency(locale: locale.toString());

  //  return format.currencySymbol;
  //}

  //static String? get currencyName {
  //  var locale = WidgetsBinding.instance?.window.locale;
  //  var format = NumberFormat.simpleCurrency(locale: locale.toString());

  //  return format.currencyName;
  //}

  static String? formatCurrency(double value) {
    // ignore: deprecated_member_use
    final locale = WidgetsBinding.instance.window.locale;
    final format = NumberFormat.simpleCurrency(locale: locale.toString());

    return format.format(value);
  }
}
