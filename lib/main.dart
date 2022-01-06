import 'package:flutter/material.dart';
import 'package:nannyplus/model/price_list.dart';
import 'package:provider/provider.dart';

import 'src/models/folder.dart';
import 'src/models/app_theme.dart';
import 'app.dart';
import 'src/models/rates.dart';

void oldmain() {
  runApp(
    MultiProvider(
      providers: [
        //Provider<Settings>(create: (_) => Settings()),
        ChangeNotifierProvider<Folders>(create: (_) => Folders()),
        ChangeNotifierProvider<AppTheme>(create: (_) => AppTheme()),
        FutureProvider<Rates>(
          lazy: false,
          create: (_) {
            var rates = Rates();
            return rates.load();
          },
          initialData: Rates(),
        ),
      ],
      builder: (context, child) => const NannyPlusApp(),
    ),
  );
}

void main() async {
  runApp(
    MultiProvider(
      providers: [
        FutureProvider<PriceList>(
          initialData: PriceList(0.0, 0.0, 0.0, 0.0, 0.0),
          create: (context) => PriceList.load(),
          lazy: false,
        ),
      ],
      child: const NannyPlusApp(),
    ),
  );
}
