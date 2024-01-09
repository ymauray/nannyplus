import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:nannyplus/app.dart';
import 'package:nannyplus/firebase_options.dart';
import 'package:nannyplus/utils/notification_util.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final locale = await findSystemLocale();
  await initializeDateFormatting(locale);

  GoogleFonts.config.allowRuntimeFetching = false;
  if (!Platform.isLinux && !Platform.isWindows && !Platform.isMacOS) {
    await NotificationUtil.instance.init();
    await NotificationUtil.instance.requestIOSPermissions();
    tz.initializeTimeZones();

    final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    await NotificationUtil.instance.cancelAll();
    await NotificationUtil.instance.scheduleBirthdayNotifications();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAnalytics.instance.logEvent(
      name: 'app_started',
    );

    //await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/Poppins-OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    const ProviderScope(child: NannyPlusApp()),
  );
}
