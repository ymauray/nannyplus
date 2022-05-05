import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../cubit/settings_cubit.dart';
import '../../utils/font_utils.dart';
import '../../utils/logo_picker_controller.dart';
import '../constants.dart';
import '../ui/list_view.dart';
import '../ui/sliver_curved_persistent_header.dart';
import '../ui/view.dart';
import 'logo_picker.dart';

class SettingsForm extends StatelessWidget {
  final SettingsLoaded _state;
  final TextEditingController line1Controller = TextEditingController();
  final TextEditingController line2Controller = TextEditingController();

  SettingsForm(this._state, {Key? key}) : super(key: key) {
    line1Controller.text = _state.line1;
    line2Controller.text = _state.line2;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final logoPickerController = LogoPickerController();

    return FormBuilder(
      key: _formKey,
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
        'address': _state.address,
      },
      child: UIView(
        title: Text(context.t('Settings')),
        actions: [
          IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.save),
            ),
            onPressed: () async {
              if (logoPickerController.bytes != null) {
                Directory appDocumentsDirectory =
                    await getApplicationDocumentsDirectory();
                var appDocumentsPath = appDocumentsDirectory.path;
                var filePath = '$appDocumentsPath/logo';
                XFile file = XFile.fromData(logoPickerController.bytes!);
                await file.saveTo(filePath);
              }
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                context
                    .read<SettingsCubit>()
                    .saveSettings(_formKey.currentState!.value);
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
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                context.t("Identity"),
                style: const TextStyle(
                  inherit: true,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: LogoPicker(
                controller: logoPickerController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(children: [
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
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(children: [
                Expanded(
                  child: FormBuilderDropdown<FontItem>(
                    name: 'line1Font',
                    decoration: InputDecoration(
                      labelText: context.t('Font for line 1'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    isExpanded: true,
                    items: FontUtils.fontItems
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.family,
                              style: TextStyle(
                                inherit: true,
                                fontFamily: item.family,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
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
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown<FontItem>(
                      name: 'line2Font',
                      decoration: InputDecoration(
                        labelText: context.t('Font for line 2'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      isExpanded: true,
                      items: FontUtils.fontItems
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item.family,
                                style: TextStyle(
                                  inherit: true,
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
              padding: const EdgeInsets.only(bottom: 16.0),
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
              padding: const EdgeInsets.only(bottom: 16.0),
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
              padding: const EdgeInsets.only(bottom: 16.0),
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
        //    SingleChildScrollView(
        //  child: Padding(
        //    padding: const EdgeInsets.all(16.0),
        //    child: FormBuilder(
        //      key: _formKey,
        //      initialValue: {
        //        'line1': _state.line1,
        //        'line1Font': _state.line1Font.family.isNotEmpty
        //            ? _state.line1Font
        //            : FontUtils.fontItems[4],
        //        'line2': _state.line2,
        //        'line2Font': _state.line2Font.family.isNotEmpty
        //            ? _state.line2Font
        //            : FontUtils.fontItems[4],
        //        'conditions': _state.conditions,
        //        'bankDetails': _state.bankDetails,
        //        'address': _state.address,
        //      },
        //      child: Column(
        //        crossAxisAlignment: CrossAxisAlignment.start,
        //        children: [
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: Text(
        //              context.t("Identity"),
        //              style: const TextStyle(
        //                inherit: true,
        //                fontWeight: FontWeight.bold,
        //              ),
        //            ),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: LogoPicker(
        //              controller: logoPickerController,
        //            ),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: Row(children: [
        //              Expanded(
        //                child: FormBuilderTextField(
        //                  name: 'line1',
        //                  decoration: InputDecoration(
        //                    labelText: context.t('Line 1'),
        //                    floatingLabelBehavior: FloatingLabelBehavior.always,
        //                  ),
        //                  textCapitalization: TextCapitalization.words,
        //                ),
        //              ),
        //            ]),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: Row(children: [
        //              Expanded(
        //                child: FormBuilderDropdown<FontItem>(
        //                  name: 'line1Font',
        //                  decoration: InputDecoration(
        //                    labelText: context.t('Font for line 1'),
        //                    floatingLabelBehavior: FloatingLabelBehavior.always,
        //                  ),
        //                  isExpanded: true,
        //                  items: FontUtils.fontItems
        //                      .map(
        //                        (item) => DropdownMenuItem(
        //                          value: item,
        //                          child: Text(
        //                            item.family,
        //                            style: TextStyle(
        //                              inherit: true,
        //                              fontFamily: item.family,
        //                            ),
        //                          ),
        //                        ),
        //                      )
        //                      .toList(),
        //                ),
        //              ),
        //            ]),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: Row(
        //              children: [
        //                Expanded(
        //                  child: FormBuilderTextField(
        //                    name: 'line2',
        //                    decoration: InputDecoration(
        //                      labelText: context.t('Line 2'),
        //                      floatingLabelBehavior: FloatingLabelBehavior.always,
        //                    ),
        //                    textCapitalization: TextCapitalization.words,
        //                  ),
        //                ),
        //              ],
        //            ),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: Row(
        //              children: [
        //                Expanded(
        //                  child: FormBuilderDropdown<FontItem>(
        //                    name: 'line2Font',
        //                    decoration: InputDecoration(
        //                      labelText: context.t('Font for line 2'),
        //                      floatingLabelBehavior: FloatingLabelBehavior.always,
        //                    ),
        //                    isExpanded: true,
        //                    items: FontUtils.fontItems
        //                        .map(
        //                          (item) => DropdownMenuItem(
        //                            value: item,
        //                            child: Text(
        //                              item.family,
        //                              style: TextStyle(
        //                                inherit: true,
        //                                fontFamily: item.family,
        //                              ),
        //                            ),
        //                          ),
        //                        )
        //                        .toList(),
        //                  ),
        //                ),
        //              ],
        //            ),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: Row(
        //              children: [
        //                Expanded(
        //                  child: FormBuilderTextField(
        //                    name: 'conditions',
        //                    decoration: InputDecoration(
        //                      labelText: context.t('Payment conditions'),
        //                      floatingLabelBehavior: FloatingLabelBehavior.always,
        //                    ),
        //                    textCapitalization: TextCapitalization.sentences,
        //                  ),
        //                ),
        //              ],
        //            ),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: Row(
        //              children: [
        //                Expanded(
        //                  child: FormBuilderTextField(
        //                    name: 'bankDetails',
        //                    minLines: 3,
        //                    maxLines: 5,
        //                    decoration: InputDecoration(
        //                      labelText: context.t('Bank details'),
        //                      floatingLabelBehavior: FloatingLabelBehavior.always,
        //                    ),
        //                    textCapitalization: TextCapitalization.sentences,
        //                  ),
        //                ),
        //              ],
        //            ),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.only(bottom: 16.0),
        //            child: Row(
        //              children: [
        //                Expanded(
        //                  child: FormBuilderTextField(
        //                    name: 'address',
        //                    minLines: 3,
        //                    maxLines: 5,
        //                    decoration: InputDecoration(
        //                      labelText: context.t('Address'),
        //                      floatingLabelBehavior: FloatingLabelBehavior.always,
        //                    ),
        //                  ),
        //                ),
        //              ],
        //            ),
        //          ),
        //        ],
        //      ),
        //    ),
        //  ),
        //),
      ),
    );
  }
}
