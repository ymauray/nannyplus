import 'package:flutter/material.dart';

class ExSwitchButton extends StatefulWidget {
  const ExSwitchButton({
    Key? key,
    required this.label,
    required this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  final Widget label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final FormFieldSetter<bool?>? onSaved;
  final FormFieldValidator<bool?>? validator;

  @override
  State<ExSwitchButton> createState() => _ExSwitchButtonState();
}

class _ExSwitchButtonState extends State<ExSwitchButton> {
  late bool _value;

  @override
  Widget build(BuildContext context) {
    _value = widget.value;
    return FormField<bool>(
      onSaved: (_) {
        if (widget.onSaved != null) {
          widget.onSaved!(_value);
        }
      },
      validator: widget.validator,
      builder: (state) {
        return OutlinedButton(
          onPressed: () {
            if (widget.onChanged != null) {
              widget.onChanged!(!widget.value);
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: widget.label,
          ),
          style: state.hasError
              ? OutlinedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(.12),
                  side: BorderSide(color: Colors.red.withOpacity(.36)),
                )
              : _value
                  ? OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.12),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(.36)),
                    )
                  : OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(.36)),
                    ),
        );
      },
    );
  }
}
