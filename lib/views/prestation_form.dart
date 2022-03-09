import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:nannyplus/cubit/price_list_cubit.dart';
import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
import 'package:nannyplus/views/app_view.dart';

class PrestationForm extends StatefulWidget {
  final Prestation? prestation;

  const PrestationForm({this.prestation, Key? key}) : super(key: key);

  @override
  State<PrestationForm> createState() => _PrestationFormState();
}

class _PrestationFormState extends State<PrestationForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  DateTime? date;
  int? priceId;
  bool? isFixedPrice;
  int? hours;
  int? minutes;

  @override
  void initState() {
    date = DateFormat('yyyy-MM-dd')
        .parse(widget.prestation?.date ?? DateTime.now().toString());
    priceId = widget.prestation?.priceId;
    hours = widget.prestation?.hours ?? 0;
    minutes = widget.prestation?.minutes ?? 0;
    isFixedPrice = (widget.prestation?.isFixedPrice ?? 1) == 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PriceListCubit>().getPriceList();
    return AppView(
      title: Text(widget.prestation != null
          ? context.t('Edit prestation')
          : context.t('Add prestation')),
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
                            labelText: context.t('Prestation'),
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
                              print(_formKey.currentState!.value);
                              var map = Map<String, dynamic>.from(
                                  _formKey.currentState!.value);
                              map['date'] = DateFormat('yyyy-MM-dd')
                                  .format(map['date'] as DateTime);
                              var prestation = Prestation.fromMap(map);
                              Navigator.of(context).pop(prestation);
                            } else {
                              print("validation failed");
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
