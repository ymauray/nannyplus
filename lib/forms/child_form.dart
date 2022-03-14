import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';

import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
import 'package:nannyplus/views/app_view.dart';

class ChildForm extends StatefulWidget {
  final Child? child;

  const ChildForm({this.child, Key? key}) : super(key: key);

  @override
  State<ChildForm> createState() => _ChildFormState();
}

class _ChildFormState extends State<ChildForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return AppView(
      title: Text(widget.child != null
          ? context.t('Edit Child')
          : context.t('Add Child')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            initialValue: {
              'firstName': widget.child?.firstName,
              'lastName': widget.child?.lastName,
              'birthdate': widget.child?.birthdate != null
                  ? DateFormat('yyyy-MM-dd').parse(widget.child!.birthdate!)
                  : null,
              'phoneNumber': widget.child?.phoneNumber,
              'parentsName': widget.child?.parentsName,
              'address': widget.child?.address,
              'allergies': widget.child?.allergies,
            },
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: FormBuilderTextField(
                          name: 'firstName',
                          decoration: InputDecoration(
                            labelText: context.t('First name'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FormBuilderTextField(
                          name: 'lastName',
                          decoration: InputDecoration(
                            labelText: context.t('Last name'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
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
                        flex: 1,
                        child: FormBuilderDateTimePicker(
                          name: 'birthdate',
                          decoration: InputDecoration(
                            labelText: context.t('Birthdate'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          inputType: InputType.date,
                          format: DateFormat.yMMMMd(I18nUtils.locale),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FormBuilderTextField(
                    name: 'allergies',
                    decoration: InputDecoration(
                      labelText: context.t('Allergies'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FormBuilderTextField(
                    name: 'parentsName',
                    decoration: InputDecoration(
                      labelText: context.t('Parents name'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FormBuilderTextField(
                    name: 'phoneNumber',
                    decoration: InputDecoration(
                      labelText: context.t('Phone number'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FormBuilderTextField(
                    minLines: 2,
                    maxLines: 2,
                    name: 'address',
                    decoration: InputDecoration(
                      labelText: context.t('Address'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        var map = Map<String, dynamic>.from(
                            _formKey.currentState!.value);
                        map['birthdate'] = DateFormat('yyyy-MM-dd')
                            .format(map['birthdate'] as DateTime);
                        var data = Child.fromMap(map);
                        Navigator.of(context).pop(data);
                      } else {
                        // Validation failed, do something.
                      }
                    },
                    child: Text(context.t("Save")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
