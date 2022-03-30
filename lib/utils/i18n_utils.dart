import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class I18nUtils {
  static String? get locale {
    return WidgetsBinding.instance?.window.locale.toString();
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
    var locale = WidgetsBinding.instance?.window.locale;
    var format = NumberFormat.simpleCurrency(locale: locale.toString());

    return format.format(value);
  }
}
