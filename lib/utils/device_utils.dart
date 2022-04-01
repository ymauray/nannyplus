import 'package:flutter/widgets.dart';

extension DeviceUtils on BuildContext {
  bool get useMobileLayout => MediaQuery.of(this).size.width < 600;
}
