import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nannyplus/cubit/settings_cubit.dart';
import 'package:nannyplus/utils/logo_picker_controller.dart';
import 'package:nannyplus/widgets/logo_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../views/app_view.dart';

class SettingsForm extends StatelessWidget {
  final SettingsLoaded _state;
  const SettingsForm(this._state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final line1Controller = TextEditingController(text: _state.line1);
    final line2Controller = TextEditingController(text: _state.line2);
    final logoPickerController = LogoPickerController();

    return AppView(
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
            context.read<SettingsCubit>().saveSettings(
                  line1Controller.text,
                  line2Controller.text,
                );
            Navigator.of(context).pop();
          },
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                LogoPicker(
                  controller: logoPickerController,
                ),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: context.t('Line 1'),
                        alignLabelWithHint: true,
                      ),
                      controller: line1Controller,
                    ),
                  ),
                ]),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: context.t('Line 2'),
                          alignLabelWithHint: true,
                        ),
                        controller: line2Controller,
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
