import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nannyplus/src/constants.dart';

class AppTheme {
  static ThemeData create() {
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: const ColorScheme(
        primary: kcPrimaryColor,
        onPrimary: kcOnPrimaryColor,
        secondary: kcSecondaryColor,
        onSecondary: kcOnSecondaryColor,
        background: kcBackgroundColor,
        onBackground: Colors.brown,
        brightness: Brightness.light,
        error: Colors.yellow,
        onError: Colors.blue,
        onSurface: Colors.orange,
        surface: Colors.lime,
      ),
      appBarTheme: appBarTheme(),
      tabBarTheme: tabBarTheme(),
      primaryTextTheme: primaryTextTheme(),
      textTheme: textTheme(),
      listTileTheme: listTitleThemeData(),
      scaffoldBackgroundColor: kcBackgroundColor,
      indicatorColor: kcPrimaryColor,
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 25,
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
      headline6: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static TextTheme textTheme() {
    return TextTheme(
      bodyText2: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      subtitle1: GoogleFonts.poppins(
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
          fontSize: 16,
        ),
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
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