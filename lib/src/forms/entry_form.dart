import 'package:flutter/material.dart';

import '../models/entry.dart';
import '../widgets/ex_forms/ex_date_picker.dart';
import '../widgets/ex_forms/ex_dropdown_button.dart';
import '../widgets/ex_forms/ex_form_row.dart';
import '../widgets/ex_forms/ex_switch_button.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({Key? key, this.input}) : super(key: key);

  final Entry? input;

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _returnValue = Entry.empty();

  bool _lunch = false;
  bool _diner = false;
  bool _night = false;
  int _hours = 0;
  int _minutes = 0;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _lunch = widget.input?.lunch ?? false;
    _diner = widget.input?.diner ?? false;
    _night = widget.input?.night ?? false;
    _hours = widget.input?.hours ?? 0;
    _minutes = widget.input?.minutes ?? 0;
    _date = widget.input?.date ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: widget.input == null
            ? const Text('Add entry')
            : const Text('Edit entry'),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Column(
            children: [
              ExFormRow(
                children: [
                  Expanded(
                    flex: 2,
                    child: ExDatePicker(
                      label: const Text('Date'),
                      initialDate: _date,
                      validator: (date) {
                        if (date == null) {
                          return '';
                        }
                      },
                      onSaved: (date) {
                        _returnValue.date = date;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ExDropdownButton<int>(
                      label: const Text('Hours'),
                      items: const [0, 1, 2, 3, 4, 5, 6, 7, 8],
                      value: _hours,
                      onSaved: (hours) {
                        _returnValue.hours = hours;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ExDropdownButton<int>(
                      label: const Text('Minutes'),
                      items: const [0, 15, 30, 45],
                      value: _minutes,
                      onSaved: (minutes) {
                        _returnValue.minutes = minutes;
                      },
                    ),
                  ),
                ],
              ),
              ExFormRow(
                children: [
                  Expanded(
                    flex: 1,
                    child: ExSwitchButton(
                      label: const Text('Lunch'),
                      value: _lunch,
                      onChanged: (lunch) {
                        setState(() {
                          _lunch = lunch;
                        });
                      },
                      onSaved: (lunch) {
                        _returnValue.lunch = lunch;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ExSwitchButton(
                      label: const Text('Diner'),
                      value: _diner,
                      onChanged: (diner) {
                        setState(() {
                          _diner = diner;
                        });
                      },
                      onSaved: (diner) {
                        _returnValue.diner = diner;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ExSwitchButton(
                      label: const Text('Night'),
                      value: _night,
                      onChanged: (night) {
                        setState(() {
                          _night = night;
                        });
                      },
                      onSaved: (night) {
                        _returnValue.night = night;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
