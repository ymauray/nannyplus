import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/child.dart';

import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/widgets/prestation_list_item.dart';

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
    String? currentDate;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrestationListHeader(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: prestations.length,
              itemBuilder: (context, index) {
                dailyTotal += prestations[index].price;
                bool showDivider = (index + 1 == prestations.length) ||
                    (prestations[index].date != prestations[index + 1].date);
                bool showDate = prestations[index].date != currentDate;
                var item = PrestationListItem(
                  prestation: prestations[index],
                  child: child,
                  showDate: showDate,
                  showDivider: showDivider,
                  dailyTotal: dailyTotal,
                );
                if (showDivider) {
                  dailyTotal = 0.0;
                }
                currentDate = prestations[index].date;
                return item;
              },
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
