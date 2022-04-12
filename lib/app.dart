import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
import 'src/app_theme.dart';
import 'src/child_list/child_list_view.dart';
import 'src/constants.dart';

class NannyPlusApp extends StatelessWidget {
  const NannyPlusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<PackageInfo>(
          create: (_) => PackageInfo.fromPlatform(),
          lazy: false,
          initialData: PackageInfo(
            appName: ksAppName,
            packageName: 'Not available',
            buildNumber: '0',
            version: '0.0.0',
          ),
        ),
        Provider<ChildrenRepository>(create: (_) => const ChildrenRepository()),
        Provider<ServicesRepository>(create: (_) => const ServicesRepository()),
        Provider<PricesRepository>(create: (_) => const PricesRepository()),
        Provider<InvoicesRepository>(create: (_) => const InvoicesRepository()),
        BlocProvider<ChildListCubit>(
          create: (context) => ChildListCubit(
            context.read<ChildrenRepository>(),
            context.read<ServicesRepository>(),
          ),
        ),
        BlocProvider<ChildInfoCubit>(
          create: (context) =>
              ChildInfoCubit(context.read<ChildrenRepository>()),
        ),
        BlocProvider<ServiceListCubit>(
          create: (context) => ServiceListCubit(
            context.read<ServicesRepository>(),
            context.read<PricesRepository>(),
            context.read<ChildrenRepository>(),
          ),
        ),
        BlocProvider<PriceListCubit>(
          create: (context) => PriceListCubit(
            context.read<PricesRepository>(),
          ),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider<InvoiceListCubit>(
          create: (context) => InvoiceListCubit(
            context.read<InvoicesRepository>(),
            context.read<ServicesRepository>(),
          ),
        ),
        BlocProvider<ServiceFormCubit>(
          create: (context) => ServiceFormCubit(
            context.read<ServicesRepository>(),
            context.read<PricesRepository>(),
          ),
        ),
        BlocProvider<InvoiceFormCubit>(
          create: (context) => InvoiceFormCubit(
            context.read<ChildrenRepository>(),
            context.read<ServicesRepository>(),
            context.read<InvoicesRepository>(),
          ),
        ),
        BlocProvider<InvoiceViewCubit>(
          create: (context) => InvoiceViewCubit(
            context.read<ServicesRepository>(),
            context.read<ChildrenRepository>(),
            context.read<PricesRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ksAppName,
        theme: AppTheme.create(),
        home: const NewChildListView(),
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
