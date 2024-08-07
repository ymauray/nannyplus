import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/app_settings_cubit.dart';
import 'package:nannyplus/cubit/child_info_cubit.dart';
import 'package:nannyplus/cubit/file_list_cubit.dart';
//import 'package:nannyplus/cubit/invoice_form_cubit.dart';
import 'package:nannyplus/cubit/invoice_list_cubit.dart';
import 'package:nannyplus/cubit/invoice_settings_cubit.dart';
import 'package:nannyplus/cubit/invoice_view_cubit.dart';
import 'package:nannyplus/cubit/price_list_cubit.dart';
import 'package:nannyplus/cubit/service_form_cubit.dart';
import 'package:nannyplus/cubit/service_list_cubit.dart';
import 'package:nannyplus/cubit/statement_list_cubit.dart';
import 'package:nannyplus/cubit/statement_view_cubit.dart';
import 'package:nannyplus/data/repository/children_repository.dart';
import 'package:nannyplus/data/repository/deduction_repository.dart';
import 'package:nannyplus/data/repository/files_repository.dart';
import 'package:nannyplus/data/repository/invoices_repository.dart';
import 'package:nannyplus/data/repository/prices_repository.dart';
import 'package:nannyplus/data/repository/services_repository.dart';
import 'package:nannyplus/src/app_theme.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/views/main_tab_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class NannyPlusApp extends riverpod.ConsumerWidget {
  const NannyPlusApp({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
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
        Provider<FilesRepository>(create: (context) => const FilesRepository()),
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
        BlocProvider<InvoiceSettingsCubit>(
          create: (context) => InvoiceSettingsCubit(),
        ),
        BlocProvider<AppSettingsCubit>(
          create: (context) => AppSettingsCubit(),
        ),
        BlocProvider<InvoiceListCubit>(
          create: (context) => InvoiceListCubit(
            context.read<InvoicesRepository>(),
            context.read<ServicesRepository>(),
            context.read<ChildrenRepository>(),
          ),
        ),
        BlocProvider<ServiceFormCubit>(
          create: (context) => ServiceFormCubit(
            context.read<ServicesRepository>(),
            context.read<PricesRepository>(),
          ),
        ),
        //BlocProvider<InvoiceFormCubit>(
        //  create: (context) => InvoiceFormCubit(
        //    context.read<ChildrenRepository>(),
        //    context.read<ServicesRepository>(),
        //    context.read<InvoicesRepository>(),
        //  ),
        //),
        BlocProvider<InvoiceViewCubit>(
          create: (context) => InvoiceViewCubit(
            context.read<ServicesRepository>(),
            context.read<ChildrenRepository>(),
            context.read<PricesRepository>(),
          ),
        ),
        BlocProvider<StatementListCubit>(
          create: (context) => StatementListCubit(
            context.read<ServicesRepository>(),
          ),
        ),
        BlocProvider<StatementViewCubit>(
          create: (context) => StatementViewCubit(
            context.read<ServicesRepository>(),
            ref.read(deductionRepositoryProvider),
          ),
        ),
        BlocProvider<FileListCubit>(
          create: (context) => FileListCubit(
            context.read<FilesRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ksAppName,
        theme: AppTheme.create(),
        home: const MainTabView(),
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
          Locale('fr', 'CH'),
        ],
        localizationsDelegates: [
          GettextLocalizationsDelegate(defaultLanguage: 'fr'),
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeListResolutionCallback: (locales, supportedLocales) {
          if (locales != null) {
            for (final locale in locales) {
              var supportedLocale = supportedLocales.where(
                (element) =>
                    element.languageCode == locale.languageCode &&
                    element.countryCode == locale.countryCode,
              );
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
