import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';

class BloodTypeDropDown extends StatelessWidget {
  final Function(String?) onChanged;

  const BloodTypeDropDown({Key? key, required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KonsecColor, width: 3)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KonsecColor, width: 1)),
        border: OutlineInputBorder(),
      ),
      hint: Text('BloodType'),
      isExpanded: true,
      onChanged: onChanged,
      items: listOfBlood
          .map((String value) => DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: KonsecColor,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
