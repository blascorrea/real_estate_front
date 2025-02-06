import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? initialValue;
  final bool requiredField;
  final void Function(T?)? onChanged;
  const CustomDropdownButton({
    super.key,
    required this.label,
    this.initialValue,
    this.onChanged,
    this.requiredField = false,
    this.items = const [],
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: initialValue,
      validator: requiredField
          ? (text) {
              if (text == null || text.toString().isEmpty) {
                return "Campo obligatorio";
              }
              return null;
            }
          : null,
      items: items
          .map<DropdownMenuItem<T>>(
            (element) => DropdownMenuItem<T>(
              value: element,
              child: Text(element.toString()),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
