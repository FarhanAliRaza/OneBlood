import 'package:flutter/material.dart';
import 'package:one_blood/widgets/heading.dart';
import 'package:one_blood/widgets/custom_form_signup.dart';

class UserDataScreen extends StatefulWidget {
  static const String id = "UserDataScreen";
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Header(),
            ),
            Image(
              image: AssetImage("images/donor2.png"),
              height: 270,
              width: double.infinity,
            ),
            SigupForm()
          ],
        ),
      ),
    );
  }
}
