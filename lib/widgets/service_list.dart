import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';

import '../data/model/child.dart';
import '../data/model/service.dart';
import '../utils/i18n_utils.dart';
import '../utils/list_extensions.dart';
import '../widgets/card_scroll_view.dart';
import 'service_list_item.dart';

class ServiceList extends StatelessWidget {
  final List<Service> services;
  final Child child;
  const ServiceList({
    required this.services,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pendingTotal =
        services.fold(0.0, (acc, service) => acc + service.total);

    var s = services.groupBy<DateTime>(
      (service) => DateFormat('yyyy-MM-dd').parse(service.date),
      groupComparator: (a, b) => b.compareTo(a),
    );

    return CardScrollView(
      bottomPadding: 80,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.t('Pending total'),
                style: const TextStyle(
                  inherit: true,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              pendingTotal.toStringAsFixed(2),
              style: const TextStyle(
                inherit: true,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        ...s.map(
          (group) {
            double dailyTotal = 0.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd(I18nUtils.locale).format(group.key),
                  style: const TextStyle(
                    inherit: true,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                ...group.value.map(
                  (service) {
                    dailyTotal += service.total;

                    return ServiceListItem(
                      service: service,
                      child: child,
                    );
                  },
                ),
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
                      child: Text(
                        dailyTotal.toStringAsFixed(2),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          inherit: true,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
