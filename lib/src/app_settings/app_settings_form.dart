import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/app_settings_cubit.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';

class AppSettingsForm extends StatelessWidget {
  const AppSettingsForm(AppSettingsLoaded state, {super.key}) : _state = state;

  final AppSettingsLoaded _state;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      initialValue: {
        'sortListByLastName': _state.sortListByLastName,
        'showFirstNameBeforeLastName': _state.showFirstNameBeforeLastName,
        'daysBeforeUnpaidInvoiceNotification':
            _state.daysBeforeUnpaidInvoiceNotification.toString(),
        'notificationMessage': _state.notificationMessage,
      },
      child: UIView(
        title: Text(context.t('Application settings')),
        actions: [
          IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.save),
            ),
            onPressed: () async {
              formKey.currentState!.save();
              if (formKey.currentState!.validate()) {
                await context
                    .read<AppSettingsCubit>()
                    .saveSettings(formKey.currentState!.value);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
        persistentHeader: const UISliverCurvedPersistenHeader(child: Text('')),
        body: UIListView.fromChildren(
          horizontalPadding: kdDefaultPadding,
          children: [
            Row(
              children: [
                Expanded(
                  child: Theme(
                    data: ThemeData(),
                    child: FormBuilderSwitch(
                      name: 'sortListByLastName',
                      title: Text(
                        context.t('Sort children list by last name'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kdDefaultPadding),
            Row(
              children: [
                Expanded(
                  child: Theme(
                    data: ThemeData(),
                    child: FormBuilderSwitch(
                      name: 'showFirstNameBeforeLastName',
                      title: Text(
                        context.t('Show first name before last name'),
                      ),
                      decoration: const InputDecoration(
                        fillColor: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kdDefaultPadding),
            Row(
              children: [
                Expanded(
                  child: Theme(
                    data: ThemeData(),
                    child: FormBuilderTextField(
                      name: 'daysBeforeUnpaidInvoiceNotification',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: context.t(
                          'Days before unpaid invoice notification',
                        ),
                      ),
                      validator: (value) =>
                          (int.tryParse(value ?? '-1') ?? -1) > 0
                              ? null
                              : context.t('Must be greater than 0'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      valueTransformer: (value) => int.tryParse(value ?? '-1'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kdDefaultPadding),
            Row(
              children: [
                Expanded(
                  child: Theme(
                    data: ThemeData(),
                    child: FormBuilderTextField(
                      maxLines: 5,
                      name: 'notificationMessage',
                      decoration: InputDecoration(
                        labelText: context.t(
                          'Notification message',
                        ),
                      ),
                      validator: (value) => value!.isNotEmpty
                          ? null
                          : context.t('Notification message cannot be empty'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      valueTransformer: (value) => int.tryParse(value ?? '-1'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
