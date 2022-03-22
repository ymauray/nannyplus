import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';

import '../cubit/service_form_cubit.dart';
import '../utils/snack_bar_util.dart';
import '../widgets/card_scroll_view.dart';
import '../widgets/time_input_dialog.dart';

import '../data/model/service.dart';
import '../utils/i18n_utils.dart';
import '../views/app_view.dart';

class ServiceForm extends StatelessWidget {
  final int childId;
  final Service? service;
  const ServiceForm({
    required this.childId,
    this.service,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ServiceFormCubit>().loadRecentServices(childId);
    final _formKey = GlobalKey<FormBuilderState>();
    final date = DateFormat('yyyy-MM-dd')
        .parse(service?.date ?? DateTime.now().toString());

    return AppView(
      title: Text(service != null
          ? context.t('Edit service')
          : context.t('Add service')),
      body: BlocConsumer<ServiceFormCubit, ServiceFormState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ServiceFormLoaded) {
            return FormBuilder(
              key: _formKey,
              initialValue: {
                'date': date,
              },
              child: CardScrollView(
                children: [
                  FormBuilderDateTimePicker(
                    name: 'date',
                    decoration: InputDecoration(
                      labelText: context.t('Date'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    inputType: InputType.date,
                    format: DateFormat.yMMMMd(I18nUtils.locale),
                  ),
                  DefaultTabController(
                    initialIndex: state.selectedTab,
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: Colors.grey,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey[500],
                          tabs: [
                            Tab(
                              text: context.t('Recent'),
                            ),
                            Tab(
                              text: context.t('All'),
                            ),
                            Tab(
                              child: Text(
                                context.t("Added") +
                                    " (${state.selectedServices.length})",
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
                                (service) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    service.priceLabel!,
                                    style: const TextStyle(
                                      inherit: true,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    service.priceDetail,
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.add),
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
                                      context
                                          .read<ServiceFormCubit>()
                                          .addService(newService);
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        if (state.selectedTab == 1)
                          ...state.prices.map(
                            (price) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                price.label,
                                style: const TextStyle(
                                  inherit: true,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                price.detail,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () async {
                                  _formKey.currentState!.save();
                                  if (price.isFixedPrice) {
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
                                    context
                                        .read<ServiceFormCubit>()
                                        .addService(service);
                                  } else {
                                    var time = await showDialog<TimeInputData>(
                                      context: context,
                                      builder: (context) {
                                        return const TimeInputDialog();
                                      },
                                    );
                                    if (time != null) {
                                      if (time.hours == 0 &&
                                          time.minutes == 0) {
                                        ScaffoldMessenger.of(context).failure(
                                          context.t("Input canceled"),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).success(
                                          context.t("Added successfully"),
                                        );
                                        var service = Service(
                                          childId: childId,
                                          date: DateFormat('yyyy-MM-dd').format(
                                            _formKey
                                                .currentState!.value['date'],
                                          ),
                                          priceId: price.id!,
                                          priceLabel: price.label,
                                          priceAmount: price.amount,
                                          isFixedPrice: 0,
                                          hours: time.hours,
                                          minutes: time.minutes,
                                          total: price.amount *
                                              (time.hours + time.minutes / 60),
                                          invoiced: 0,
                                        );
                                        context
                                            .read<ServiceFormCubit>()
                                            .addService(service);
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:nannyplus/cubit/price_list_cubit.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
import 'package:nannyplus/views/app_view.dart';

class ServiceForm extends StatefulWidget {
  final Service? service;

  const ServiceForm({this.service, Key? key}) : super(key: key);

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  DateTime? date;
  int? priceId;
  bool? isFixedPrice;
  int? hours;
  int? minutes;

  @override
  void initState() {
    date = DateFormat('yyyy-MM-dd')
        .parse(widget.service?.date ?? DateTime.now().toString());
    priceId = widget.service?.priceId;
    hours = widget.service?.hours ?? 0;
    minutes = widget.service?.minutes ?? 0;
    isFixedPrice = (widget.service?.isFixedPrice ?? 1) == 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PriceListCubit>().getPriceList();
    return AppView(
      title: Text(widget.service != null
          ? context.t('Edit service')
          : context.t('Add service')),
      body: BlocConsumer<PriceListCubit, PriceListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PriceListLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: {
                    'date': date,
                    'priceId': priceId,
                    'hours': hours,
                    'minutes': minutes,
                  },
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: FormBuilderDateTimePicker(
                          name: 'date',
                          decoration: InputDecoration(
                            labelText: context.t('Date'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          inputType: InputType.date,
                          format: DateFormat.yMMMMd(I18nUtils.locale),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: FormBuilderDropdown(
                          name: 'priceId',
                          decoration: InputDecoration(
                            labelText: context.t('Service'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          items: state.priceList.map((p) {
                            return DropdownMenuItem(
                              value: p.id,
                              child: Text(p.label),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              isFixedPrice = state.priceList
                                  .firstWhere((element) => element.id == value)
                                  .isFixedPrice;
                            });
                          },
                        ),
                      ),
                      if (!(isFixedPrice ?? true))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: FormBuilderDropdown(
                                  name: 'hours',
                                  decoration: InputDecoration(
                                    labelText: context.t('Hours'),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  items: [0, 1, 2, 3, 4, 5, 6, 7, 8]
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toString()),
                                          ))
                                      .toList(),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                flex: 1,
                                child: FormBuilderDropdown(
                                  name: 'minutes',
                                  decoration: InputDecoration(
                                    labelText: context.t('Minutes'),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  items: [0, 15, 30, 45]
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.toString().padLeft(2, '0'),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              var map = Map<String, dynamic>.from(
                                  _formKey.currentState!.value);
                              map['date'] = DateFormat('yyyy-MM-dd')
                                  .format(map['date'] as DateTime);
                              var service = Service.fromMap(map);
                              Navigator.of(context).pop(service);
                            } else {
                              // Validation failed, do something.
                            }
                          },
                          child: Text(context.t("Save")),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
*/
