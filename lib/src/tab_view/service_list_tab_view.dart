import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/cubit/service_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/src/common/loading_indicator_list_view.dart';
import 'package:nannyplus/src/service_form/service_form.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
import 'package:nannyplus/utils/list_extensions.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';

class ServiceListTabView extends StatelessWidget {
  const ServiceListTabView({
    super.key,
    required this.childId,
  });

  final int childId;

  @override
  Widget build(BuildContext context) {
    context.read<ServiceListCubit>().loadServices(childId);

    return BlocConsumer<ServiceListCubit, ServiceListState>(
      listener: (context, state) {
        if (state is ServiceListError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t('Error loading services')),
            ),
          );
        }
      },
      builder: (context, state) => state is ServiceListLoaded
          ? _List(child: state.child, services: state.services)
          : const LoadingIndicatorListView(),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    required this.child,
    required this.services,
  });

  final Child child;
  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    final s = services.groupBy<DateTime>(
      (service) => DateFormat('yyyy-MM-dd').parse(service.date),
      groupComparator: (a, b) => b.compareTo(a),
    );

    return UIListView(
      itemBuilder: (context, index) {
        return _GroupCard(
          child: child,
          group: s[index],
        );
      },
      itemCount: s.length,
      onFloatingActionPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<Service>(
            builder: (context) => ServiceForm(child: child, tab: 0),
            fullscreenDialog: true,
          ),
        );
        await context.read<ServiceListCubit>().loadServices(child.id!);
      },
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    required this.child,
    required this.group,
  });

  final Child child;
  final Group<DateTime, Service> group;

  @override
  Widget build(BuildContext context) {
    {
      var dailyTotal = 0.0;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<Service>(
              builder: (context) => ServiceForm(
                child: child,
                date: DateFormat('yyyy-MM-dd').parse(group.value[0].date),
                tab: 1,
              ),
              fullscreenDialog: true,
            ),
          );
          await context.read<ServiceListCubit>().loadServices(child.id!);
        },
        child: UICard(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat.yMMMMd(I18nUtils.locale).format(group.key),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final delete = await _showConfirmationDialog(context);
                      if (delete ?? false) {
                        await context
                            .read<ServiceListCubit>()
                            .deleteDay(child.id!, group.value[0].date);
                        ScaffoldMessenger.of(context).success(
                          context.t('Removed successfully'),
                        );
                      }
                    },
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
            ...group.value.map(
              (service) {
                dailyTotal += service.total;

                return _Detail(service: service);
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Divider(
                      height: 2,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      dailyTotal.toStringAsFixed(2),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.titleMedium,
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

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Delete')),
          content: Text(
            context.t('Are you sure you want to delete this entire day ?'),
          ),
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

class _Detail extends StatelessWidget {
  const _Detail({
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: Row(
          children: [
            Expanded(
              flex: service.isFixedPrice! == 0 ? 2 : 5,
              child: Text(service.priceLabel!),
            ),
            const SizedBox(
              width: 8,
            ),
            if (service.isFixedPrice! == 0)
              Expanded(
                flex: 2,
                child: Text(
                  service.isFixedPrice! == 0 ? service.priceDetail : '',
                  textAlign: TextAlign.end,
                ),
              ),
            if (service.isFixedPrice! == 0)
              const SizedBox(
                width: 8,
              ),
            Expanded(
              child: Text(
                service.total.toStringAsFixed(2),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
