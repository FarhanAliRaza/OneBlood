import 'package:flutter/material.dart';
import 'package:one_blood/widgets/heading.dart';
import 'package:one_blood/widgets/custom_form_signup.dart';
class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupBody(),
    );
  }
}
class SignupBody extends StatelessWidget {

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
            Image(image: AssetImage("images/donor2.png"), height: 270, width: double.infinity,),
            SigupForm()


          ],
        ),
      ),
    );
  }
}
