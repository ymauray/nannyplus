import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';

import 'cubit/child_info_cubit.dart';
import 'cubit/child_list_cubit.dart';
import 'cubit/invoice_list_cubit.dart';
import 'cubit/price_list_cubit.dart';
import 'cubit/service_list_cubit.dart';
import 'data/children_repository.dart';
import 'data/invoices_repository.dart';
import 'data/prices_repository.dart';
import 'data/services_repository.dart';
import 'views/child_list_view.dart';

class NannyPlusApp extends StatelessWidget {
  const NannyPlusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var childrenRepository = const ChildrenRepository();
    var pricesRepository = const PricesRepository();
    var servicesRepository = const ServicesRepository();
    var invoicesRepository = const InvoicesRepository();

    return MultiProvider(
      providers: [
        BlocProvider<ChildListCubit>(
          create: (context) => ChildListCubit(childrenRepository),
        ),
        BlocProvider<PriceListCubit>(
          create: (context) => PriceListCubit(pricesRepository),
        ),
        BlocProvider<ServiceListCubit>(
          create: (context) => ServiceListCubit(
            servicesRepository,
            pricesRepository,
            childrenRepository,
          ),
        ),
        BlocProvider<InvoiceListCubit>(
          create: (context) => InvoiceListCubit(invoicesRepository),
        ),
        BlocProvider<ChildInfoCubit>(
          create: (context) => ChildInfoCubit(childrenRepository),
        ),
      ],
      child: MaterialApp(
        home: const ChildListView(),
        theme: ThemeData(
          fontFamily: 'SF Pro',
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 1.125,
                fontFamily: 'SF Pro Text',
              ),
        ),
        darkTheme: ThemeData.dark(),
        supportedLocales: const [Locale('fr')],
        localizationsDelegates: [
          GettextLocalizationsDelegate(defaultLanguage: 'fr'),
          ...GlobalMaterialLocalizations.delegates,
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
      ),
    );
  }
}
