import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';

import '../cubit/service_list_cubit.dart';
import '../data/model/child.dart';
import '../data/model/service.dart';
import '../forms/service_form.dart';
import '../utils/i18n_utils.dart';
import '../utils/list_extensions.dart';

import 'card_scroll_view.dart';
import 'service_list_item_detail.dart';

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
          (group) => _GroupCard(child: child, group: group),
        ),
      ],
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    required this.child,
    required this.group,
    Key? key,
  }) : super(key: key);

  final Child child;
  final Group<DateTime, Service> group;

  @override
  Widget build(BuildContext context) {
    {
      double dailyTotal = 0.0;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<Service>(
              builder: (context) => ServiceForm(
                childId: child.id!,
                date: DateFormat('yyyy-MM-dd').parse(group.value[0].date),
                tab: 2,
              ),
              fullscreenDialog: true,
            ),
          );
          context.read<ServiceListCubit>().loadServices(child.id!);
        },
        child: Column(
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

                return ServiceListItemDetail(service: service);
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
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
            ),
          ],
        ),
      );
    }
  }
}
