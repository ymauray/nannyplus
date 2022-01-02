import 'package:flutter/material.dart';

class ExTextField extends StatelessWidget {
  const ExTextField({
    Key? key,
    required this.label,
    this.keyboardType,
    this.textCapitalization,
    this.showCursor,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.controller,
    this.validator,
    this.onSaved,
    this.maxLines,
  }) : super(key: key);

  final Widget label;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool? showCursor;
  final bool enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorStyle: const TextStyle(height: 0),
      ),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      showCursor: showCursor,
      enableInteractiveSelection: enableInteractiveSelection,
      onTap: onTap,
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
    );
  }
}
