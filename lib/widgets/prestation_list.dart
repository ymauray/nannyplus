import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:nannyplus/data/model/child.dart';

import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/utils/date_format_extension.dart';
import 'package:nannyplus/widgets/prestation_list_item.dart';

import 'bold_text.dart';
import 'prestation_list_header.dart';

class PrestationList extends StatelessWidget {
  final List<Prestation> prestations;
  final Child child;
  const PrestationList({
    required this.prestations,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dailyTotal = 0.0;
    double pendingTotal =
        prestations.fold(0.0, (acc, prestation) => acc + prestation.price);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrestationListHeader(),
            GroupedListView<Prestation, String>(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              groupComparator: (value1, value2) => value2.compareTo(value1),
              elements: prestations,
              groupBy: (element) => element.date,
              indexedItemBuilder: (context, element, index) {
                var showFooter = (index + 1 == prestations.length) ||
                    (prestations[index].date != prestations[index + 1].date);
                dailyTotal += element.price;
                var item = Column(
                  children: [
                    PrestationListItem(
                      prestation: element,
                      showDate: false,
                      showDivider: false,
                      child: child,
                    ),
                    if (showFooter) ...[
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Divider(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 1,
                            child: BoldText(
                              dailyTotal.toStringAsFixed(2),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ],
                );
                if (showFooter) dailyTotal = 0.0;
                return item;
              },
              groupHeaderBuilder: (element) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BoldText(element.date.formatDate()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      context.t('Pending total'),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    pendingTotal.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
