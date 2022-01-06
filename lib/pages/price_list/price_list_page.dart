import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';

import '../../model/price_list.dart';
import '../../src/widgets/ex_forms/ex_form_row.dart';
import '../../src/widgets/ex_forms/ex_text_field.dart';

class PriceListPage extends StatelessWidget {
  const PriceListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var priceList = context.read<PriceList>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t('Rates')),
        //centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                ExFormRow(
                  children: [
                    const Icon(
                      Icons.watch,
                    ),
                    Text(
                      context.t("Hours"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: ExTextField(
                        label: Text(context.t("Week")),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: TextEditingController(
                            text: priceList.weekHours.toString()),
                        validator: (value) => (value == null || value.isEmpty)
                            ? context.t('This value cannot be empty')
                            : null,
                        onSaved: (value) {
                          value = value!.replaceAll(',', '.');
                          priceList.weekHours = double.parse(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ExTextField(
                        label: Text(context.t("Weekend")),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: TextEditingController(
                            text: priceList.weekendHours.toString()),
                        validator: (value) => (value == null || value.isEmpty)
                            ? context.t('This value cannot be empty')
                            : null,
                        onSaved: (value) {
                          value = value!.replaceAll(',', '.');
                          priceList.weekendHours = double.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const Icon(FontAwesomeIcons.utensils),
                    Text(
                      context.t("Meals"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: ExTextField(
                        label: Text(
                          context.t("Preschool"),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: TextEditingController(
                            text: priceList.mealPreschool.toString()),
                        validator: (value) => (value == null || value.isEmpty)
                            ? context.t('This value cannot be empty')
                            : null,
                        onSaved: (value) {
                          value = value!.replaceAll(',', '.');
                          priceList.mealPreschool = double.parse(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ExTextField(
                        label: Text(
                          context.t("Kindergarden"),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: TextEditingController(
                            text: priceList.mealKindergarden.toString()),
                        validator: (value) => (value == null || value.isEmpty)
                            ? context.t('This value cannot be empty')
                            : null,
                        onSaved: (value) {
                          value = value!.replaceAll(',', '.');
                          priceList.mealKindergarden = double.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const Icon(FontAwesomeIcons.question),
                    Text(
                      context.t("Misc"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: ExTextField(
                        label: Text(
                          context.t("Night"),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: TextEditingController(
                            text: priceList.night.toString()),
                        validator: (value) => (value == null || value.isEmpty)
                            ? context.t('This value cannot be empty')
                            : null,
                        onSaved: (value) {
                          value = value!.replaceAll(',', '.');
                          priceList.night = double.parse(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            priceList.save();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          context.t("Save"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
