import 'package:flutter/material.dart';

class CustomChipFilter extends StatelessWidget {
  final Widget label;
  final void Function()? onDeleted;

  const CustomChipFilter({
    super.key,
    required this.label,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          padding: const EdgeInsets.all(0),
          label: label,
          labelStyle: TextStyle(color: Theme.of(context).indicatorColor),
          deleteIcon: Icon(Icons.close, color: Theme.of(context).indicatorColor,),
          onDeleted: onDeleted,
          shape: const StadiumBorder(),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 4.0),
      ],
    );
  }
}
