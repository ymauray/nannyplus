import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yaru/yaru.dart' as yaru;

import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_view.dart';
import 'src/models/app_theme.dart';
import 'src/pages/tabbed_home_page.dart';

class NannyPlusApp extends StatelessWidget {
  const NannyPlusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _lightTheme = yaru.lightTheme.copyWith(
      primaryColor: Colors.blue,
      appBarTheme: yaru.lightTheme.appBarTheme.copyWith(
        backgroundColor: Colors.blue,
        titleTextStyle: yaru.lightTheme.appBarTheme.titleTextStyle?.copyWith(
          color: Colors.white,
        ),
        iconTheme: yaru.lightTheme.appBarTheme.iconTheme?.copyWith(
          color: Colors.white,
        ),
        actionsIconTheme:
            yaru.lightTheme.appBarTheme.actionsIconTheme?.copyWith(
          color: Colors.white,
        ),
      ),
      floatingActionButtonTheme:
          yaru.lightTheme.floatingActionButtonTheme.copyWith(
        backgroundColor: Colors.blue,
      ),
    );
    final _darkTheme = yaru.darkTheme.copyWith();
    return MaterialApp(
      home: HomeView(),
      theme: _lightTheme,
      darkTheme: _darkTheme,
      supportedLocales: const [
        /*
         * List of locales (language + country) we have translations for.
         * 
         * If there is a file for the tuple (langue, country) in assets/lib/i18n, then this
         * will be used for translation.
         * 
         * If there is not, then we'll look for a file for the language only.
         * 
         * If there is no file for the language code, we'll fallback to the english file.
         * 
         * Example : let's say the locale is fr_CH. We will look for "assets/lib/i18n/fr_CH.po", 
         * "assets/lib/i18n/fr.po", and "assets/lib/i18n/en.po", stopping at the first file we
         * find.
         * 
         * Translation files are not merged, meaning if some translations are missing in fr_CH.po
         * but are present in fr.po, the missing translations will not be picked up from fr.po,
         * and thus will show up in english.
         */
        Locale('en'),
        Locale('fr'),
        Locale('fr', 'CH'),
      ],
      localizationsDelegates: [
        GettextLocalizationsDelegate(defaultLanguage: 'en'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeListResolutionCallback: (locales, supportedLocales) {
        if (locales != null) {
          for (var locale in locales) {
            var supportedLocale = supportedLocales.where((element) =>
                element.languageCode == locale.languageCode &&
                element.countryCode == locale.countryCode);
            if (supportedLocale.isNotEmpty) {
              return supportedLocale.first;
            }
            supportedLocale = supportedLocales.where(
                (element) => element.languageCode == locale.languageCode);
            if (supportedLocale.isNotEmpty) {
              return supportedLocale.first;
            }
          }
        }
        return null;
      },
    );
  }
}

class OldNannyPlusApp extends StatelessWidget {
  const OldNannyPlusApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          var sharedPreferences = snapshot.data!;
          var useDarkMode = sharedPreferences.getBool("useDarkMode");
          if (useDarkMode != null) {
            var appTheme = context.read<AppTheme>();
            appTheme.setDarkMode(useDarkMode);
          }
          return Consumer<AppTheme>(
            builder: (context, appTheme, _) => MaterialApp(
              theme: appTheme.lightTheme,
              darkTheme: appTheme.darkTheme,
              themeMode: appTheme.themeMode,
              home: TabbedHomePage(),
              supportedLocales: const [
                /*
                 * List of locales (language + country) we have translations for.
                 * 
                 * If there is a file for the tuple (langue, country) in assets/lib/i18n, then this
                 * will be used for translation.
                 * 
                 * If there is not, then we'll look for a file for the language only.
                 * 
                 * If there is no file for the language code, we'll fallback to the english file.
                 * 
                 * Example : let's say the locale is fr_CH. We will look for "assets/lib/i18n/fr_CH.po", 
                 * "assets/lib/i18n/fr.po", and "assets/lib/i18n/en.po", stopping at the first file we
                 * find.
                 * 
                 * Translation files are not merged, meaning if some translations are missing in fr_CH.po
                 * but are present in fr.po, the missing translations will not be picked up from fr.po,
                 * and thus will show up in english.
                 */
                Locale('en'),
                Locale('fr'),
                Locale('fr', 'CH'),
              ],
              localizationsDelegates: [
                GettextLocalizationsDelegate(defaultLanguage: 'en'),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              localeListResolutionCallback: (locales, supportedLocales) {
                if (locales != null) {
                  for (var locale in locales) {
                    var supportedLocale = supportedLocales.where((element) =>
                        element.languageCode == locale.languageCode &&
                        element.countryCode == locale.countryCode);
                    if (supportedLocale.isNotEmpty) {
                      return supportedLocale.first;
                    }
                    supportedLocale = supportedLocales.where((element) =>
                        element.languageCode == locale.languageCode);
                    if (supportedLocale.isNotEmpty) {
                      return supportedLocale.first;
                    }
                  }
                }
                return null;
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
