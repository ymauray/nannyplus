import 'package:intl/intl.dart';

import 'i18n_utils.dart';

extension DateFormatExtension on String {
  String formatDate() {
    return DateFormat.yMMMMd(I18nUtils.locale).format(
      DateFormat('yyyy-MM-dd').parse(this),
    );
  }
}
