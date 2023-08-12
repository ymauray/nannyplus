import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/deduction.dart';
import 'package:nannyplus/views/app_view.dart';
import 'package:nannyplus/widgets/card_scroll_view.dart';

class DeductionForm extends ConsumerWidget {
  const DeductionForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return AppView(
      title: Text(context.t('Create new deduction')),
      actions: [
        IconButton(
          onPressed: () async {
            final deduction = await save(formKey, context, ref);
            if (deduction != null) {
              Navigator.of(context).pop(deduction);
            }
          },
          icon: const Icon(Icons.save),
        ),
      ],
      body: FormBuilder(
        key: formKey,
        child: CardScrollView(
          children: [
            FormBuilderTextField(
              name: 'label',
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: context.t('Label'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (value == null || value.isEmpty)
                  ? context.t('This field is required')
                  : null,
            ),
            FormBuilderTextField(
              name: 'value',
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: context.t('Value'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (value == null || value.isEmpty)
                  ? context.t('This field is required')
                  : (double.tryParse(value) == null
                      ? context.t('This field must be a number')
                      : null),
              valueTransformer: (value) => double.tryParse(value!),
            ),
            FormBuilderDropdown(
              name: 'type',
              decoration: InputDecoration(
                labelText: context.t('Type'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              items: [
                DropdownMenuItem(
                  value: 'amount',
                  child: Text(context.t('Amount')),
                ),
                DropdownMenuItem(
                  value: 'percent',
                  child: Text(context.t('Percent')),
                ),
              ],
              validator: (value) => (value == null || value.isEmpty)
                  ? context.t('This field is required')
                  : null,
            ),
            FormBuilderDropdown(
              name: 'periodicity',
              decoration: InputDecoration(
                labelText: context.t('Periodicity'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              items: [
                DropdownMenuItem(
                  value: 'monthly',
                  child: Text(context.t('Monthly')),
                ),
                DropdownMenuItem(
                  value: 'yearly',
                  child: Text(context.t('Yearly')),
                ),
              ],
              validator: (value) => (value == null || value.isEmpty)
                  ? context.t('This field is required')
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<Deduction?> save(
    GlobalKey<FormBuilderState> formKey,
    BuildContext context,
    WidgetRef ref,
  ) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      final values = formKey.currentState!.value;
      final deduction = Deduction.fromJson(values);
      return deduction;
    }

    return null;
  }
}
