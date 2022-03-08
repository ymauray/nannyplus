import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import 'package:nannyplus/data/model/prestation.dart';
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
      body: Form(
        key: GlobalKey(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: prestation?.date,
                decoration: InputDecoration(labelText: context.t('Date')),
                onSaved: (value) {},
              )
            ],
            //TextFormField(
            //  initialValue: prestation?.name,
            //  decoration: InputDecoration(
            //    labelText: context.t('Name'),
            //  ),
            //  onSaved: (value) => prestation!.name = value,
            //),
            //TextFormField(
            //  initialValue: prestation?.description,
            //  decoration: InputDecoration(
            //    labelText: context.t('Description'),
            //  ),
            //  onSaved: (value) => prestation!.description = value,
            //),
            //TextFormField(
            //  initialValue: prestation?.price.toString(),
            //  decoration: InputDecoration(
            //    labelText: context.t('Price'),
            //  ),
            //  onSaved: (value) => prestation!.price = int.parse(value),
            //),
            //TextFormField(
            //  initialValue: prestation?.duration.toString(),
            //  decoration: InputDecoration(
            //    labelText: context.t('Duration'),
            //  ),
            //  onSaved: (value) => prestation!.duration = int.parse(value),
            //),
            //TextFormField(
            //  initialValue: prestation?.max.toString(),
            //  decoration: InputDecoration(
            //    labelText: context.t('Max'),
            //  ),
            //  onSaved: (value) => prestation!.max = int.parse(value),
            //),
            //TextFormField(
            //  initialValue: prestation?.min.toString(),
            //  decoration: InputDecoration(
            //    labelText: context.t('Min'),
            //  ),
            //  onSaved: (value) => prestation!.min = int.parse(value),
            //),
            //TextFormField(
            //  initialValue: prestation?.image,
            //  decoration: InputDecoration(
            //    labelText: context.t('Image'),
            //  ),
            //  onSaved: (value) => prestation!.image = value,
            //),
            //TextFormField(
            //  initialValue: prestation?.category,
            //  decoration: InputDecoration(
            //    labelText: context.t('Category'),
            //  ),
            //  onSaved: (
          ),
        ),
      ),
    );
  }
}
