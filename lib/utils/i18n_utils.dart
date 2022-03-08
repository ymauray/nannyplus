import 'package:flutter/cupertino.dart';

class I18nUtils {
  static String? get locale {
    return WidgetsBinding.instance?.window.locale.toString();
  }
}
