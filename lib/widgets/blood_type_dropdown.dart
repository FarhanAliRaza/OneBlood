import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';

class BloodTypeDropDown extends StatelessWidget {
  final Function(String?) onChanged;
  final String value;

  const BloodTypeDropDown(
      {Key? key, required this.onChanged, required this.value})
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
      value: value,
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
