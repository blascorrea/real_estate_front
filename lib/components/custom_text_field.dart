import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String initialValue;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final bool requiredField;
  const CustomTextField({
    super.key,
    required this.labelText,
    this.initialValue = '',
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.requiredField = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.next,
      validator: widget.requiredField
          ? (text) {
              if (text == null || text.isEmpty) {
                return "Campo obligatorio";
              }
              return null;
            }
          : null,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
