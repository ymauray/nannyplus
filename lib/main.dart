import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nannyplus/cubit/folders_page_cubit.dart';
import 'package:nannyplus/src/models/folders_repository.dart';
import 'package:provider/provider.dart';

import 'src/models/folder.dart';
import 'src/models/app_theme.dart';
//import 'src/models/settings.dart';
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

void main() {
  runApp(const NannyPlusApp());
  //MultiProvider(
  //  providers: [
  //    BlocProvider(
  //      create: (context) {
  //        var foldersCubit = FoldersPageCubit(
  //          FoldersRepository(),
  //        );
  //        foldersCubit.getFolders(false);
  //        return foldersCubit;
  //      },
  //      lazy: false,
  //    ),
  //  ],
  //  builder: (context, _) => const NannyPlusApp(),
  //),
}
