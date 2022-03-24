import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';

import '../cubit/service_form_cubit.dart';
import '../data/model/price.dart';
import '../data/model/service.dart';
import '../utils/i18n_utils.dart';
import '../views/app_view.dart';
import '../widgets/card_scroll_view.dart';
import '../widgets/time_input_dialog.dart';

class ServiceForm extends StatelessWidget {
  final int childId;
  final int tab;
  final DateTime? date;
  const ServiceForm({
    required this.childId,
    required this.tab,
    this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ServiceFormCubit>().loadRecentServices(childId, date, tab);
    final _formKey = GlobalKey<FormBuilderState>();

    return AppView(
      title: Text(
        date != null ? context.t('Edit service') : context.t('Add service'),
      ),
      body: BlocBuilder<ServiceFormCubit, ServiceFormState>(
        builder: (context, state) {
          return state is ServiceFormLoaded
              ? FormBuilder(
                  key: _formKey,
                  initialValue: {'date': state.date ?? DateTime.now()},
                  child: CardScrollView(children: [
                    FormBuilderDateTimePicker(
                      name: 'date',
                      decoration: InputDecoration(
                        labelText: context.t('Date'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      inputType: InputType.date,
                      format: DateFormat.yMMMMd(I18nUtils.locale),
                      onChanged: (selectedDate) {
                        context
                            .read<ServiceFormCubit>()
                            .loadRecentServices(childId, selectedDate, 0);
                      },
                    ),
                    _ServiceFormTabController(
                      state,
                      _formKey,
                      childId,
                    ),
                  ]),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _ServiceFormTabController extends StatelessWidget {
  final ServiceFormLoaded state;
  final GlobalKey<FormBuilderState> _formKey;
  final int childId;
  const _ServiceFormTabController(
    this.state,
    this._formKey,
    this.childId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: state.selectedTab,
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.grey,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey[500],
            tabs: [
              Tab(text: context.t('Recent')),
              Tab(text: context.t('All')),
              Tab(
                child: Text(
                  context.t("Added") + " (${state.selectedServices.length})",
                ),
              ),
            ],
            onTap: (index) {
              context.read<ServiceFormCubit>().selectTab(index);
            },
          ),
          if (state.selectedTab == 0)
            ...state.services
                .map(
                  (service) => _ServiceTile(
                    service: service,
                    onPressed: () {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).success(
                        context.t("Added successfully"),
                      );
                      var newService = service.copyWith(
                        id: null,
                        invoiceId: null,
                        invoiced: 0,
                        date: DateFormat('yyyy-MM-dd').format(
                          _formKey.currentState!.value['date'],
                        ),
                      );
                      context.read<ServiceFormCubit>().addService(newService);
                    },
                  ),
                )
                .toList(),
          if (state.selectedTab == 1)
            ...state.prices.map(
              (price) => _PriceTile(
                price: price,
                childId: childId,
                onPressed: () async {
                  _formKey.currentState!.save();
                  if (price.isFixedPrice) {
                    await handleFixedPrice(context, price);
                  } else {
                    await handleVariablePrice(context, price);
                  }
                },
              ),
            ),
          if (state.selectedTab == 2)
            ...state.selectedServices
                .map(
                  (service) => _ServiceTile(
                    service: service,
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      _formKey.currentState!.save();
                      var delete = await _showConfirmationDialog(context);
                      if (delete ?? false) {
                        context.read<ServiceFormCubit>().deleteService(service);
                        ScaffoldMessenger.of(context).success(
                          context.t("Removed successfully"),
                        );
                        context
                            .read<ServiceFormCubit>()
                            .loadRecentServices(childId, state.date, 2);
                        //var newService = service.copyWith(
                        //  id: null,
                        //  invoiceId: null,
                        //  invoiced: 0,
                        //  date: DateFormat('yyyy-MM-dd').format(
                        //    _formKey.currentState!.value['date'],
                        //  ),
                        //);
                      }
                    },
                  ),
                )
                .toList(),
        ],
      ),
    );
  }

  Future<void> handleVariablePrice(BuildContext context, Price price) async {
    var time = await showDialog<TimeInputData>(
      context: context,
      builder: (context) {
        return const TimeInputDialog();
      },
    );
    if (time != null) {
      if (time.hours == 0 && time.minutes == 0) {
        ScaffoldMessenger.of(context).failure(
          context.t("Input canceled"),
        );
      } else {
        ScaffoldMessenger.of(context).success(
          context.t("Added successfully"),
        );
        var service = Service(
          childId: childId,
          date: DateFormat('yyyy-MM-dd')
              .format(_formKey.currentState!.value['date']),
          priceId: price.id!,
          priceLabel: price.label,
          priceAmount: price.amount,
          isFixedPrice: 0,
          hours: time.hours,
          minutes: time.minutes,
          total: price.amount * (time.hours + time.minutes / 60),
          invoiced: 0,
        );
        await context.read<ServiceFormCubit>().addService(service);
      }
    }
  }

  Future<void> handleFixedPrice(BuildContext context, Price price) async {
    ScaffoldMessenger.of(context).success(
      context.t("Added successfully"),
    );
    var service = Service(
      childId: childId,
      date: DateFormat('yyyy-MM-dd').format(
        _formKey.currentState!.value['date'],
      ),
      priceId: price.id!,
      priceLabel: price.label,
      priceAmount: price.amount,
      isFixedPrice: 1,
      hours: 0,
      minutes: 0,
      total: price.amount,
      invoiced: 0,
    );
    await context.read<ServiceFormCubit>().addService(service);
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
  final Price price;
  final int childId;
  final VoidCallback? onPressed;
  const _PriceTile({
    required this.price,
    required this.childId,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        price.label,
        style: const TextStyle(
          inherit: true,
          fontSize: 16,
        ),
      ),
      subtitle: Text(price.detail),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: onPressed,
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final Service service;
  final VoidCallback? onPressed;
  final Icon? icon;
  const _ServiceTile({
    required this.service,
    this.onPressed,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        service.priceLabel!,
        style: const TextStyle(
          inherit: true,
          fontSize: 16,
        ),
      ),
      subtitle: Text(service.isFixedPrice == 1
          ? service.priceAmount!.toStringAsFixed(2)
          : service.priceDetail),
      trailing: IconButton(
        icon: icon ?? const Icon(Icons.add),
        onPressed: onPressed,
      ),
    );
  }
}
