// ignore_for_file: argument_type_not_assignable
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

class TimeInputData {
  const TimeInputData({required this.hours, required this.minutes});
  final int hours;
  final int minutes;
}

class TimeInputDialog extends StatelessWidget {
  const TimeInputDialog({
    this.hours,
    this.minutes,
    super.key,
  });

  final int? hours;
  final int? minutes;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: FormBuilder(
          key: formKey,
          initialValue: {
            'hours': hours,
            'minutes': minutes,
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown(
                      name: 'hours',
                      decoration: InputDecoration(
                        labelText: context.t('Hours'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              alignment: Alignment.center,
                              child: Text(e.toString()),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FormBuilderDropdown(
                      name: 'minutes',
                      decoration: InputDecoration(
                        labelText: context.t('Minutes'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: [0, 15, 30, 45]
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              alignment: Alignment.center,
                              child: Text(e.toString().padLeft(2, '0')),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  formKey.currentState!.save();
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop(
                      TimeInputData(
                        hours: formKey.currentState!.value['hours'] ?? 0,
                        minutes: formKey.currentState!.value['minutes'] ?? 0,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.t('Please fill in all fields')),
                      ),
                    );
                  }
                },
                child: Text(
                  context.t('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
