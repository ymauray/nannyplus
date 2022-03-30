import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import 'bold_text.dart';

class InvoiceListHeader extends StatelessWidget {
  const InvoiceListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: BoldText(
              "#",
            ),
          ),
          Expanded(
            flex: 2,
            child: BoldText(
              context.t("Date"),
            ),
          ),
          Expanded(
            flex: 1,
            child: BoldText(
              context.t("Total"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
