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
    String currentDate = '';
    bool showDivider = false;
    double pendingTotal =
        prestations.fold(0.0, (acc, prestation) => acc + prestation.price);
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
                if (prestations[index].date != currentDate) {
                  showDivider = true;
                } else {
                  showDivider = false;
                }
                currentDate = prestations[index].date;
                return PrestationListItem(
                  prestation: prestations[index],
                  child: child,
                  showDivider: showDivider,
                );
              },
            ),
            const Divider(),
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
