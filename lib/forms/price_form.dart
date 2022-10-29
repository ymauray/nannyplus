import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/price_list_cubit.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/views/app_view.dart';
import 'package:nannyplus/widgets/card_scroll_view.dart';

class PriceForm extends StatelessWidget {
  const PriceForm({
    this.price,
    Key? key,
  }) : super(key: key);

  final Price? price;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return AppView(
      title: Text(context.t('Create new price')),
      actions: [
        IconButton(
          onPressed: () => save(formKey, context, price?.id, price?.sortOrder),
          icon: const Icon(Icons.save),
        ),
      ],
      body: FormBuilder(
        key: formKey,
        initialValue: {
          'label': price?.label,
          'amount': price?.amount.toStringAsFixed(2),
          'fixed': price?.isFixedPrice,
        },
        child: CardScrollView(
          children: [
            FormBuilderTextField(
              name: 'label',
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: context.t('Label'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            FormBuilderTextField(
              name: 'amount',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: context.t('Price'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            FormBuilderDropdown(
              name: 'fixed',
              decoration: InputDecoration(
                labelText: context.t('Price type'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              items: [
                DropdownMenuItem(
                  value: true,
                  child: Text(context.t('Fixed price')),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text(context.t('Hourly price')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> save(
    GlobalKey<FormBuilderState> formKey,
    BuildContext context,
    int? id,
    int? sortOrder,
  ) async {
    formKey.currentState!.save();
    final price = Price(
      label: formKey.currentState!.value['label'],
      amount: double.parse(formKey.currentState!.value['amount']),
      fixedPrice: formKey.currentState!.value['fixed'] as bool ? 1 : 0,
      sortOrder: -1,
      deleted: 0,
    );
    if (id != null) {
      await context.read<PriceListCubit>().update(
            price.copyWith(id: id, sortOrder: sortOrder),
          );
    } else {
      await context.read<PriceListCubit>().create(price);
    }
    Navigator.of(context).pop();
  }
}
