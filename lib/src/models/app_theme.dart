import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart' as yaru;

class AppTheme extends ChangeNotifier {
  final _lightTheme = yaru.lightTheme.copyWith(
    colorScheme: yaru.lightTheme.colorScheme.copyWith(
      primary: Colors.blue,
      onPrimary: Colors.white,
    ),
    appBarTheme: yaru.lightTheme.appBarTheme.copyWith(
      backgroundColor: Colors.blue,
      titleTextStyle: yaru.lightTheme.appBarTheme.titleTextStyle?.copyWith(
        color: Colors.white,
      ),
      iconTheme: yaru.lightTheme.appBarTheme.iconTheme?.copyWith(
        color: Colors.white,
      ),
      actionsIconTheme: yaru.lightTheme.appBarTheme.actionsIconTheme?.copyWith(
        color: Colors.white,
      ),
    ),
    floatingActionButtonTheme: yaru.lightTheme.floatingActionButtonTheme.copyWith(
      backgroundColor: Colors.blue,
    ),
  );
  final _darkTheme = yaru.darkTheme;

  ThemeMode? _themeMode;

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;
  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;

  set useDarkMode(bool useDarkMode) {
    _themeMode = useDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
