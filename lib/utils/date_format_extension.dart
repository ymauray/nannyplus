import 'package:intl/intl.dart';

import 'i18n_utils.dart';

extension DateFormatExtension on String {
  String formatDate({String? format}) {
    var formatter = format != null
        ? DateFormat(format)
        : DateFormat.yMMMMd(I18nUtils.locale);

    return formatter.format(DateFormat('yyyy-MM-dd').parse(this));
  }
}
