import 'package:flutter/material.dart';

class DropDownMenuComponent extends StatelessWidget {
  final void Function(String? value) onChanged;
  final List<String> items;
  final String hint;
  const DropDownMenuComponent({
    Key? key,
    required this.onChanged,
    required this.items,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 90,
      child: DropdownButtonFormField<String>(
        value: null,
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: true,
        elevation: 16,
        style: Theme.of(context).textTheme.subtitle1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:BorderRadius.circular(12),
          )
        ),
        hint: FittedBox(
          child: Text(hint),
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}