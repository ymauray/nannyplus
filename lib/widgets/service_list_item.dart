import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';

import 'package:nannyplus/cubit/service_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/utils/date_format_extension.dart';
import 'package:nannyplus/forms/service_form.dart';

import 'bold_text.dart';
import 'service_list_item_detail.dart';

class ServiceListItem extends StatelessWidget {
  final Service service;
  final Child child;
  final bool showDate;
  final bool showDivider;
  final double? dailyTotal;

  const ServiceListItem({
    required this.service,
    required this.child,
    required this.showDate,
    required this.showDivider,
    Key? key,
    this.dailyTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDate)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: BoldText(service.date.formatDate()),
          ),
        Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          //confirmDismiss: _showDismissConfirmationDialog(context),
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Text(
                    context.t('Delete'),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          onDismissed: (direction) {
            context.read<ServiceListCubit>().delete(service, child.id!);
          },
          child: GestureDetector(
            onTap: () async {
              var service = await Navigator.of(context).push(
                MaterialPageRoute<Service>(
                  builder: (context) => ServiceForm(
                    service: this.service,
                  ),
                  fullscreenDialog: true,
                ),
              );
              if (service != null) {
                context.read<ServiceListCubit>().update(
                    this.service.copyWith(
                          date: service.date,
                          priceId: service.priceId,
                          hours: service.hours,
                          minutes: service.minutes,
                        ),
                    child.id!);
              }
            },
            child: ServiceListItemDetail(service: service),
          ),
        ),
        if (showDivider) ...[
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
                  dailyTotal!.toStringAsFixed(2),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
        if (showDivider) const Divider(),
      ],
    );
  }
}
