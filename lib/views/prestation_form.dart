import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:nannyplus/cubit/price_list_cubit.dart';
import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
import 'package:nannyplus/views/app_view.dart';

class PrestationForm extends StatelessWidget {
  final Prestation? prestation;
  final Key _formKey = GlobalKey<FormBuilderState>();

  PrestationForm({this.prestation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PriceListCubit>().getPriceList();
    return AppView(
      title: Text(prestation != null
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
                    'date': DateFormat('yyyy-MM-dd')
                        .parse(prestation?.date ?? DateTime.now().toString()),
                    'prestation': prestation?.priceId,
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
                          name: 'prestation',
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            //return Form(
            //  key: GlobalKey(),
            //  child: SingleChildScrollView(
            //    child: Padding(
            //      padding: const EdgeInsets.all(16.0),
            //      child: Column(
            //        children: [
            //          TextFormField(
            //            initialValue: prestation?.date,
            //            decoration:
            //                InputDecoration(labelText: context.t('Date')),
            //            onSaved: (newValue) {},
            //          ),
            //          DropdownButtonFormField<Price>(
            //            hint: Text(context.t('Price')),
            //            items: state.priceList.map((price) {
            //              return DropdownMenuItem<Price>(
            //                value: price,
            //                child: Text(price.label),
            //              );
            //            }).toList(),
            //            onChanged: (newValue) {},
            //            onSaved: (newValue) {},
            //          )
            //        ],
            //      ),
            //    ),
            //  ),
            //);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
