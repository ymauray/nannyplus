import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExDropdownButton<T> extends StatelessWidget {
  ExDropdownButton({
    Key? key,
    this.value,
    required this.items,
    required this.label,
    this.onSaved,
  }) : super(key: key);

  final _focusNode = FocusNode();
  final T? value;
  final List<T> items;
  final Widget label;
  final FormFieldSetter<T>? onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isDense: false,
      focusNode: _focusNode,
      decoration: InputDecoration(
        label: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
      ),
      items: items
          .map(
            (i) => DropdownMenuItem(
              value: i,
              child: Text(
                i.toString(),
              ),
            ),
          )
          .toList(),
      value: value,
      onChanged: (value) {},
      onSaved: onSaved,
      onTap: () {
        _focusNode.requestFocus();
      },
    );
  }
}
