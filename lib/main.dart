import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/models/folder.dart';
import 'src/models/app_theme.dart';
//import 'src/models/settings.dart';
import 'src/app.dart';
import 'src/models/rates.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //Provider<Settings>(create: (_) => Settings()),
        ChangeNotifierProvider<Folders>(create: (_) => Folders()),
        ChangeNotifierProvider<AppTheme>(create: (_) => AppTheme()),
        FutureProvider<Rates>(
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
