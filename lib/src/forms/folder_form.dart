import 'package:nannyplus/src/widgets/ex_forms/ex_date_picker.dart';
import 'package:nannyplus/src/widgets/ex_forms/ex_form_row.dart';
import 'package:nannyplus/src/widgets/ex_forms/ex_switch_button.dart';
import 'package:nannyplus/src/widgets/ex_forms/ex_text_field.dart';
import 'package:flutter/material.dart';

import '../models/folder.dart';

class FolderForm extends StatefulWidget {
  const FolderForm({Key? key, this.input}) : super(key: key);

  final Folder? input;

  @override
  State<FolderForm> createState() => _FolderFormState();
}

class _FolderFormState extends State<FolderForm> {
  final _formKey = GlobalKey<FormState>();
  final _returnValue = Folder.empty();

  String? notNullNorEmpty(String? value) =>
      (value == null || value.isEmpty) ? '' : null;

  bool _preSchool = false;
  bool _kindergarden = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.input != null
            ? '${widget.input!.firstName} ${widget.input!.lastName ?? ''}'
                .trim()
            : 'New folder'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _returnValue.archived = false;
                _formKey.currentState!.save();
                Navigator.of(context).pop(_returnValue);
              }
            },
            child: const Text("Save"),
            style: TextButton.styleFrom(
              primary: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                ExFormRow(
                  children: [
                    const Icon(Icons.child_care),
                    Expanded(
                      child: ExTextField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        label: const Text('First name'),
                        validator: notNullNorEmpty,
                        onSaved: (value) {
                          _returnValue.firstName = value;
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(width: 24),
                    Expanded(
                      child: ExTextField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        label: const Text('Last name'),
                        onSaved: (value) {
                          _returnValue.lastName = value;
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(width: 24),
                    Expanded(
                      child: ExDatePicker(
                        label: const Text('Birthdate'),
                        onSaved: (value) {
                          _returnValue.birthDate = value;
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(width: 24),
                    Expanded(
                      child: ExSwitchButton(
                        label: const Text('Pre-school'),
                        value: _preSchool,
                        onChanged: (value) {
                          setState(() {
                            _preSchool = value;
                            _kindergarden = !value;
                          });
                        },
                        validator: (_) =>
                            !_preSchool && !_kindergarden ? '' : null,
                        onSaved: (value) {
                          _returnValue.preSchool = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: ExSwitchButton(
                        label: const Text('Kindergarden'),
                        value: _kindergarden,
                        onChanged: (value) {
                          setState(() {
                            _kindergarden = value;
                            _preSchool = !value;
                          });
                        },
                        validator: (_) =>
                            !_preSchool && !_kindergarden ? '' : null,
                        onSaved: (value) {
                          _returnValue.kinderGarden = value;
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(width: 24),
                    Expanded(
                      child: ExTextField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        label: const Text('Allergies'),
                        maxLines: 2,
                        onSaved: (value) {
                          _returnValue.allergies = value;
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const Icon(Icons.people),
                    Expanded(
                      child: ExTextField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        label: const Text('Parents name'),
                        maxLines: 2,
                        onSaved: (value) {
                          _returnValue.parentsName = value;
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(width: 24),
                    Expanded(
                      child: ExTextField(
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.words,
                        label: const Text('Address'),
                        maxLines: 2,
                        onSaved: (value) {
                          _returnValue.address = value;
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const Icon(Icons.phone),
                    Expanded(
                      child: ExTextField(
                        keyboardType: TextInputType.phone,
                        textCapitalization: TextCapitalization.sentences,
                        label: const Text('Phone number'),
                        onSaved: (value) {
                          _returnValue.phoneNumber = value;
                        },
                      ),
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const Icon(Icons.info),
                    Expanded(
                      child: ExTextField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        label: const Text('Other information'),
                        maxLines: 3,
                        onSaved: (value) {
                          _returnValue.misc = value;
                        },
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
