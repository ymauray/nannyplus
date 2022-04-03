import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';

import 'cubit/child_info_cubit.dart';
import 'cubit/child_list_cubit.dart';
import 'cubit/invoice_form_cubit.dart';
import 'cubit/invoice_list_cubit.dart';
import 'cubit/invoice_view_cubit.dart';
import 'cubit/price_list_cubit.dart';
import 'cubit/service_form_cubit.dart';
import 'cubit/service_list_cubit.dart';
import 'cubit/settings_cubit.dart';
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
          create: (context) => ChildListCubit(
            childrenRepository,
            servicesRepository,
          ),
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
          create: (context) => InvoiceListCubit(
            invoicesRepository,
            servicesRepository,
          ),
        ),
        BlocProvider<ChildInfoCubit>(
          create: (context) => ChildInfoCubit(childrenRepository),
        ),
        BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
        BlocProvider<ServiceFormCubit>(
          create: (context) => ServiceFormCubit(
            servicesRepository,
            pricesRepository,
          ),
        ),
        BlocProvider<InvoiceFormCubit>(
          create: (context) => InvoiceFormCubit(
            childrenRepository,
            servicesRepository,
            invoicesRepository,
          ),
        ),
        BlocProvider<InvoiceViewCubit>(
          create: (context) => InvoiceViewCubit(
            servicesRepository,
            childrenRepository,
          ),
        ),
      ],
      child: MaterialApp(
        home: const ChildListView(),
        theme: ThemeData(
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                filled: true,
                fillColor: const Color.fromARGB(255, 236, 246, 250),
              ),
        ),
        supportedLocales: const [Locale('en'), Locale('fr')],
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
                (element) => element.languageCode == locale.languageCode,
              );
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
