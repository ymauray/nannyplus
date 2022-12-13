import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl_standalone.dart';
import 'package:nannyplus/app.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  // await NotificationUtil().init();
  // await NotificationUtil().requestIOSPermissions();
  tz.initializeTimeZones();
  final currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  //NotificationUtil().scheduleNotification();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/Poppins-OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await findSystemLocale();

  runApp(
    const NannyPlusApp(),
  );
}
