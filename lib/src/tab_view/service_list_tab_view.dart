import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';

import '../../cubit/service_list_cubit.dart';
import '../../data/model/child.dart';
import '../../data/model/service.dart';
import '../../forms/service_form.dart';
import '../../src/ui/list_view.dart';
import '../../utils/i18n_utils.dart';
import '../../utils/list_extensions.dart';
import '../../utils/snack_bar_util.dart';

class NewServiceListTabView extends StatelessWidget {
  const NewServiceListTabView(
    this.childId, {
    Key? key,
  }) : super(key: key);

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
          : ListView(
              children: const [Center(child: CircularProgressIndicator())],
            ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    Key? key,
    required this.child,
    required this.services,
  }) : super(key: key);

  final Child child;
  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    var s = services.groupBy<DateTime>(
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
      onFloatingActionPressed: () {},
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
                tab: 1,
              ),
              fullscreenDialog: true,
            ),
          );
          context.read<ServiceListCubit>().loadServices(child.id!);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Material(
            elevation: 4,
            shape: Theme.of(context).listTileTheme.shape,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: (Theme.of(context).listTileTheme.shape!
                        as RoundedRectangleBorder)
                    .borderRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat.yMMMMd(I18nUtils.locale)
                                .format(group.key),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            var delete = await _showConfirmationDialog(context);
                            if (delete ?? false) {
                              context
                                  .read<ServiceListCubit>()
                                  .deleteDay(child.id!, group.value[0].date);
                              ScaffoldMessenger.of(context).success(
                                context.t("Removed successfully"),
                              );
                            }
                          },
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(
                            Icons.close,
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
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Divider(
                            height: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(
                              dailyTotal.toStringAsFixed(2),
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8.0),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: Text(service.priceLabel!)),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 2,
              child: Text(
                service.isFixedPrice! == 0 ? service.priceDetail : "",
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 1,
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
