import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'utils/database_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DatabaseUtil.instance;
  runApp(const NannyPlusApp());
}
