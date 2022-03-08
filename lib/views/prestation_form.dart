import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/price_list_cubit.dart';

import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/views/app_view.dart';

class PrestationForm extends StatelessWidget {
  final Prestation? prestation;
  const PrestationForm({this.prestation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView(
      title: Text(prestation != null
          ? context.t('Edit prestation')
          : context.t('Add prestation')),
      body: BlocConsumer<PriceListCubit, PriceListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: GlobalKey(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: prestation?.date,
                      decoration: InputDecoration(labelText: context.t('Date')),
                      onSaved: (newValue) {},
                    ),
                    DropdownButtonFormField<Price>(
                      items: null,
                      onChanged: (newValue) {},
                      onSaved: (newValue) {},
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
