import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/cubit/settings_cubit.dart';

import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
import 'package:nannyplus/views/app_view.dart';

class ChildForm extends StatelessWidget {
  const ChildForm({this.child, Key? key}) : super(key: key);

  final Child? child;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();

    return AppView(
      title: Text(
        child != null ? context.t('Edit Child') : context.t('Add Child'),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            onPressed: () {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                var map =
                    Map<String, dynamic>.from(_formKey.currentState!.value);
                if (map['birthdate'] != null) {
                  map['birthdate'] = DateFormat('yyyy-MM-dd')
                      .format(map['birthdate'] as DateTime);
                }
                var data = Child.fromMap(map);
                Navigator.of(context).pop(data);
              }
            },
            icon: const Icon(Icons.save, color: Colors.white),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            initialValue: {
              'firstName': child?.firstName,
              'lastName': child?.lastName,
              'birthdate': child?.birthdate != null
                  ? DateFormat('yyyy-MM-dd').parse(child!.birthdate!)
                  : null,
              'phoneNumber': child?.phoneNumber,
              'parentsName': child?.parentsName,
              'address': child?.address,
              'allergies': child?.allergies,
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
                          validator: ((value) =>
                              (value == null) || (value.isEmpty)
                                  ? context.t('Please entrer the first name')
                                  : null),
                          name: 'firstName',
                          decoration: InputDecoration(
                            labelText: context.t('First name'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            context.read<SettingsCubit>().setLine1(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: FormBuilderTextField(
                          name: 'lastName',
                          validator: (value) =>
                              (value == null) || (value.isEmpty)
                                  ? context.t('Please entrer the last name')
                                  : null,
                          decoration: InputDecoration(
                            labelText: context.t('Last name'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          autocorrect: false,
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
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FormBuilderTextField(
                    validator: (value) => (value == null) || (value.isEmpty)
                        ? context.t('Please enter the parents name')
                        : null,
                    name: 'parentsName',
                    decoration: InputDecoration(
                      labelText: context.t('Parents name'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FormBuilderTextField(
                    validator: ((value) => (value == null) || (value.isEmpty)
                        ? context.t('Please enter the parents address')
                        : null),
                    minLines: 2,
                    maxLines: 2,
                    name: 'address',
                    decoration: InputDecoration(
                      labelText: context.t('Address'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    textCapitalization: TextCapitalization.words,
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
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.phone,
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
