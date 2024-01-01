import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nannyplus/src/constants.dart';

class AppTheme {
  static ThemeData create() {
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      useMaterial3: false,
      colorScheme: const ColorScheme(
        primary: kcPrimaryColor,
        onPrimary: kcOnPrimaryColor,
        secondary: kcSecondaryColor,
        onSecondary: kcOnSecondaryColor,
        background: kcBackgroundColor,
        onSurface: kcAlmostBlack,
        onBackground: Colors.brown,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.blue,
        surface: Colors.lime,
      ),
      appBarTheme: appBarTheme(),
      tabBarTheme: tabBarTheme(),
      primaryTextTheme: primaryTextTheme(),
      textTheme: textTheme(),
      listTileTheme: listTitleThemeData(),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
      ),
      scaffoldBackgroundColor: kcBackgroundColor,
      indicatorColor: kcPrimaryColor,
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: kcAlmostWhite,
        dialHandColor: kcPrimaryColor,
        dialTextColor: kcTextColor,
        hourMinuteTextColor: kcTextColor,
        dayPeriodTextColor: kcTextColor,
      ),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      toolbarTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 18,
          color: kcOnPrimaryColor,
        ),
      ),
    );
  }

  static TextTheme primaryTextTheme() {
    return TextTheme(
      titleLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static TextTheme textTheme() {
    return TextTheme(
      bodyMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      titleMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static TabBarTheme tabBarTheme() {
    return TabBarTheme(
      labelColor: kcTextColor,
      labelStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  static ListTileThemeData listTitleThemeData() {
    return const ListTileThemeData(
      tileColor: kcAlmostWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kdDefaultRadius),
        ),
      ),
    );
  }
}
