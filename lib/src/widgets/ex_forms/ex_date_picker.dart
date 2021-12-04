import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ex_text_field.dart';

class ExDatePicker extends StatefulWidget {
  const ExDatePicker({
    Key? key,
    required this.label,
    this.initialDate,
    this.onChanged,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final Widget label;
  final DateTime? initialDate;
  final ValueChanged<DateTime?>? onChanged;
  final FormFieldValidator<DateTime?>? validator;
  final FormFieldSetter<DateTime?>? onSaved;

  @override
  State<ExDatePicker> createState() => _ExDatePickerState();
}

class _ExDatePickerState extends State<ExDatePicker> {
  DateTime? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return ExTextField(
      label: widget.label,
      keyboardType: TextInputType.none,
      showCursor: false,
      enableInteractiveSelection: false,
      controller: TextEditingController(
        text: _value == null ? '' : DateFormat.yMMMd().format(_value!),
      ),
      validator: (_) => widget.validator != null ? widget.validator!(_value) : null,
      onSaved: (_) {
        if (widget.onSaved != null) widget.onSaved!(_value);
      },
      onTap: () async {
        var date = await showDatePicker(
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: DateTime.now().add(
            const Duration(days: -20 * 366),
          ),
          lastDate: DateTime.now(),
        );
        setState(() {
          _value = date;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(date);
        }
      },
    );
  }
}
