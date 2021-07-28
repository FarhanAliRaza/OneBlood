import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
const Konhstyle = TextStyle(
  fontFamily: "Niconne",
    fontSize: 40,
  color: KonsecColor
  // fontWeight: FontWeight.bold
);
class Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text(
        "One Blood",
        style: Konhstyle,
    );
  }
}
