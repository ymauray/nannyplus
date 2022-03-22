import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';

import 'package:nannyplus/cubit/service_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/forms/service_form.dart';

import 'service_list_item_detail.dart';

class ServiceListItem extends StatelessWidget {
  final Service service;
  final Child child;
  final double? dailyTotal;

  const ServiceListItem({
    required this.service,
    required this.child,
    Key? key,
    this.dailyTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) => _showConfirmationDialog(context),
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
                    childId: child.id!,
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
      ],
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Delete')),
          content:
              Text(context.t('Are you sure you want to delete this entry ?')),
          actions: [
            TextButton(
              child: Text(context.t('Yes')),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text(context.t('No')),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
