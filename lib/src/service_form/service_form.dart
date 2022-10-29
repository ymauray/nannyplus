import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/cubit/service_form_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/src/common/loading_indicator_list_view.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/sliver_tab_bar_peristant_header.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';
import 'package:nannyplus/widgets/time_input_dialog.dart';

class NewServiceForm extends StatelessWidget {
  const NewServiceForm({
    Key? key,
    required this.child,
    required this.tab,
    this.date,
  }) : super(key: key);

  final Child child;
  final int tab;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    context.read<ServiceFormCubit>().loadRecentServices(child.id!, date, tab);

    return DefaultTabController(
      initialIndex: tab,
      length: 2,
      child: UIView(
        title: Text(
          date != null ? context.t('Edit service') : context.t('Add service'),
        ),
        persistentHeader: UISliverCurvedPersistenHeader(
          child: BlocBuilder<ServiceFormCubit, ServiceFormState>(
            builder: (context, state) {
              return Text(
                DateFormat.yMMMMd(I18nUtils.locale).format(
                  state is ServiceFormLoaded ? state.date! : DateTime.now(),
                ),
              );
            },
          ),
        ),
        persistentTabBar: UISliverTabBarPeristantHeader(
          tabBar: TabBar(
            onTap: (index) {
              context.read<ServiceFormCubit>().selectTab(index);
            },
            tabs: [
              Tab(
                child: Text(context.t('Services')),
              ),
              Tab(
                child: BlocBuilder<ServiceFormCubit, ServiceFormState>(
                  builder: (context, state) {
                    return state is ServiceFormLoaded
                        ? Text(
                            "${context.t("Added")} (${state.selectedServices.length})",
                          )
                        : Text("${context.t("Added")} 0");
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          BlocBuilder<ServiceFormCubit, ServiceFormState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: state is ServiceFormLoaded
                        ? state.date!
                        : DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (selectedDate != null) {
                    await context.read<ServiceFormCubit>().loadRecentServices(
                          child.id!,
                          selectedDate,
                          (state as ServiceFormLoaded).selectedTab,
                        );
                  }
                },
                icon: const Icon(Icons.edit_calendar),
              );
            },
          ),
        ],
        body: BlocBuilder<ServiceFormCubit, ServiceFormState>(
          builder: (context, state) {
            return state is ServiceFormLoaded
                ? _List(state: state, child: child)
                : const LoadingIndicatorListView();
          },
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    Key? key,
    required this.state,
    required this.child,
  }) : super(key: key);

  final ServiceFormLoaded state;
  final Child child;

  @override
  Widget build(BuildContext context) {
    return UIListView.fromChildren(
      children: [
        if (state.selectedTab == 0)
          ...state.prices.map(
            (price) => _PriceTile(
              price: price,
              childId: child.id!,
              onPressed: () async {
                //_formKey.currentState!.save();
                if (price.isFixedPrice) {
                  await handleFixedPrice(
                    context,
                    price,
                    state.date!,
                  );
                } else {
                  await handleVariablePrice(
                    context,
                    price,
                    state.date!,
                  );
                }
              },
            ),
          ),
        if (state.selectedTab == 1)
          ...state.selectedServices
              .map(
                (service) => _ServiceTile(
                  service: service,
                  trailing: Row(
                    children: [
                      if (service.isFixedPrice == 0)
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () async {
                            await editService(context, service);
                          },
                        ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          //_formKey.currentState!.save();
                          final delete = await _showConfirmationDialog(
                            context,
                          );
                          if (delete ?? false) {
                            context
                                .read<ServiceFormCubit>()
                                .deleteService(service);
                            ScaffoldMessenger.of(context).success(
                              context.t('Removed successfully'),
                            );
                            await context
                                .read<ServiceFormCubit>()
                                .loadRecentServices(
                                  child.id!,
                                  state.date,
                                  1,
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
      ],
    );
  }

  Future<void> handleFixedPrice(
    BuildContext context,
    Price price,
    //GlobalKey<FormBuilderState> formKey,
    DateTime date,
  ) async {
    ScaffoldMessenger.of(context).success(
      context.t('Added successfully'),
    );
    final service = Service(
      childId: child.id!,
      date: DateFormat('yyyy-MM-dd').format(date),
      priceId: price.id!,
      priceLabel: price.label,
      priceAmount: price.amount,
      isFixedPrice: 1,
      hours: 0,
      minutes: 0,
      total: price.amount,
    );
    await context.read<ServiceFormCubit>().addService(service, child.id!, date);
  }

  Future<void> handleVariablePrice(
    BuildContext context,
    Price price,
    //GlobalKey<FormBuilderState> formKey,
    DateTime date,
  ) async {
    final time = await showDialog<TimeInputData>(
      context: context,
      builder: (context) {
        return const TimeInputDialog();
      },
    );
    if (time != null) {
      if (time.hours == 0 && time.minutes == 0) {
        ScaffoldMessenger.of(context).failure(
          context.t('Input canceled'),
        );
      } else {
        ScaffoldMessenger.of(context).success(
          context.t('Added successfully'),
        );
        final service = Service(
          childId: child.id!,
          date: DateFormat('yyyy-MM-dd').format(date),
          priceId: price.id!,
          priceLabel: price.label,
          priceAmount: price.amount,
          isFixedPrice: 0,
          hours: time.hours,
          minutes: time.minutes,
          total: price.amount * (time.hours + time.minutes / 60),
        );
        await context
            .read<ServiceFormCubit>()
            .addService(service, child.id!, date);
      }
    }
  }

  Future<void> editService(BuildContext context, Service service) async {
    final time = await showDialog<TimeInputData>(
      context: context,
      builder: (context) {
        return TimeInputDialog(
          hours: service.hours,
          minutes: service.minutes,
        );
      },
    );
    if (time != null) {
      if (time.hours == 0 && time.minutes == 0) {
        ScaffoldMessenger.of(context).failure(
          context.t('Input canceled'),
        );
      } else {
        ScaffoldMessenger.of(context).success(
          context.t('Edited successfully'),
        );
        final newService = service.copyWith(
          hours: time.hours,
          minutes: time.minutes,
          total: service.priceAmount! * (time.hours + time.minutes / 60),
        );
        await context.read<ServiceFormCubit>().updateService(newService);
      }
    }
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

class _PriceTile extends StatelessWidget {
  const _PriceTile({
    required this.price,
    required this.childId,
    this.onPressed,
    Key? key,
  }) : super(key: key);
  final Price price;
  final int childId;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kdMediumPadding,
                      top: kdMediumPadding,
                      right: kdMediumPadding,
                    ),
                    child: Text(
                      price.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kdMediumPadding),
                    child: Text(
                      price.isFixedPrice
                          ? context.t(
                              'Fixed price of {0}',
                              args: [
                                price.amount.toStringAsFixed(2),
                              ],
                            )
                          : context.t(
                              'Hourly price of {0}',
                              args: [
                                price.amount.toStringAsFixed(2),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: onPressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.service,
    required this.trailing,
    Key? key,
  }) : super(key: key);

  final Service service;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kdMediumPadding,
                      top: kdMediumPadding,
                      right: kdMediumPadding,
                    ),
                    child: Text(
                      service.priceLabel!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kdMediumPadding),
                    child: Text(
                      service.isFixedPrice == 1
                          ? context.t(
                              'Fixed price of {0}',
                              args: [
                                service.priceAmount!.toStringAsFixed(2),
                              ],
                            )
                          : "${context.t(
                              "Hourly price of {0}",
                              args: [
                                service.priceAmount!.toStringAsFixed(2),
                              ],
                            )} x ${service.hours!}h${service.minutes!.toString().padLeft(2, '0')}",
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ],
    );
  }
}
