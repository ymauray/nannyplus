import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nannyplus/cubit/settings_cubit.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/invoice_settings/logo_picker.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/font_utils.dart';
import 'package:nannyplus/utils/logo_picker_controller.dart';
import 'package:path_provider/path_provider.dart';

class InvoiceSettingsForm extends StatelessWidget {
  InvoiceSettingsForm(this._state, {Key? key}) : super(key: key) {
    line1Controller.text = _state.line1;
    line2Controller.text = _state.line2;
  }
  final SettingsLoaded _state;
  final TextEditingController line1Controller = TextEditingController();
  final TextEditingController line2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final logoPickerController = LogoPickerController();

    return FormBuilder(
      key: formKey,
      initialValue: {
        'line1': _state.line1,
        'line1Font': _state.line1Font.family.isNotEmpty
            ? _state.line1Font
            : FontUtils.fontItems[4],
        'line2': _state.line2,
        'line2Font': _state.line2Font.family.isNotEmpty
            ? _state.line2Font
            : FontUtils.fontItems[4],
        'conditions': _state.conditions,
        'bankDetails': _state.bankDetails,
        'name': _state.name,
        'address': _state.address,
      },
      child: UIView(
        title: Text(context.t('Invoice settings')),
        actions: [
          IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.save),
            ),
            onPressed: () async {
              if (logoPickerController.bytes != null) {
                final appDocumentsDirectory =
                    await getApplicationDocumentsDirectory();
                final appDocumentsPath = appDocumentsDirectory.path;
                final filePath = '$appDocumentsPath/logo';
                final file = XFile.fromData(logoPickerController.bytes!);
                await file.saveTo(filePath);
              }
              formKey.currentState!.save();
              if (formKey.currentState!.validate()) {
                await context
                    .read<SettingsCubit>()
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                context.t('Identity'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: LogoPicker(
                controller: logoPickerController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'line1',
                      decoration: InputDecoration(
                        labelText: context.t('Line 1'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown<FontItem>(
                      name: 'line1Font',
                      decoration: InputDecoration(
                        labelText: context.t('Font for line 1'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: FontUtils.fontItems
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item.family,
                                style: TextStyle(
                                  fontFamily: item.family,
                                ),
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
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'line2',
                      decoration: InputDecoration(
                        labelText: context.t('Line 2'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown<FontItem>(
                      name: 'line2Font',
                      decoration: InputDecoration(
                        labelText: context.t('Font for line 2'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: FontUtils.fontItems
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item.family,
                                style: TextStyle(
                                  fontFamily: item.family,
                                ),
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
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'conditions',
                      decoration: InputDecoration(
                        labelText: context.t('Payment conditions'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'bankDetails',
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: context.t('Bank details'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(
                        labelText: context.t('Name'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'address',
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: context.t('Address'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
