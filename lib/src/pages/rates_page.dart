import 'package:nannyplus/src/models/rates.dart';
import 'package:nannyplus/src/widgets/ex_forms/ex_form_row.dart';
import 'package:nannyplus/src/widgets/ex_forms/ex_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';

class RatesPage extends StatelessWidget {
  const RatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t('Rates')),
        //centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<Rates>(
          builder: (context, rates, _) => Form(
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
                              text: rates.weekHours?.toString()),
                          validator: (value) => (value == null || value.isEmpty)
                              ? context.t('This value cannot be empty')
                              : null,
                          onSaved: (value) {
                            value = value!.replaceAll(',', '.');
                            rates.weekHours = double.parse(value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ExTextField(
                          label: Text(context.t("Weekend")),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          controller: TextEditingController(
                              text: rates.weekendHours?.toString()),
                          validator: (value) => (value == null || value.isEmpty)
                              ? context.t('This value cannot be empty')
                              : null,
                          onSaved: (value) {
                            value = value!.replaceAll(',', '.');
                            rates.weekendHours = double.parse(value);
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
                              text: rates.mealPreschool?.toString()),
                          validator: (value) => (value == null || value.isEmpty)
                              ? context.t('This value cannot be empty')
                              : null,
                          onSaved: (value) {
                            value = value!.replaceAll(',', '.');
                            rates.mealPreschool = double.parse(value);
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
                              text: rates.mealKindergarden?.toString()),
                          validator: (value) => (value == null || value.isEmpty)
                              ? context.t('This value cannot be empty')
                              : null,
                          onSaved: (value) {
                            value = value!.replaceAll(',', '.');
                            rates.mealKindergarden = double.parse(value);
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
                              text: rates.night?.toString()),
                          validator: (value) => (value == null || value.isEmpty)
                              ? context.t('This value cannot be empty')
                              : null,
                          onSaved: (value) {
                            value = value!.replaceAll(',', '.');
                            rates.night = double.parse(value);
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
                              rates.commit();
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
      ),
    );
  }
}
