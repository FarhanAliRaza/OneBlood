import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/models/user_model.dart';
import 'package:one_blood/screens/home_screen.dart';
import 'package:one_blood/screens/login.dart';
import 'package:one_blood/screens/profile_detail_screen.dart';
import 'package:one_blood/services/authentication.dart';
import 'package:one_blood/services/firestore_database.dart';
import 'package:one_blood/widgets/heading.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "SignUpScreen";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Auth auth = Auth();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SignInScreen.id),
                  icon: Icon(Icons.arrow_back),
                  padding: EdgeInsets.zero,
                  splashRadius: 24,
                ),
                SizedBox(height: 60),
                signInTextField(emailController, "Email Address",
                    TextInputType.emailAddress, "Email is empty"),
                SizedBox(height: 10),
                signInTextField(passwordController, "Password",
                    TextInputType.visiblePassword, "Password is empty", true),
                SizedBox(height: 10),
                loginButton(),
                Divider(indent: 12, endIndent: 12),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget signInTextField(TextEditingController controller, String hintText,
      TextInputType keyboardType, String error,
      [bool obscureText = false]) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value == "") return error;
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KonsecColor),
          )),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          await auth.signUpWithEmailAndPassword(
              emailController.text, passwordController.text);
          final User? user = auth.currentUser;

          if (user != null) {
            UserModel? userData = await FireStore().getUserData(user.uid);
            if (userData == null)
              Navigator.pushReplacementNamed(context, UserDataScreen.id);
            if (userData != null)
              Navigator.pushReplacementNamed(context, HomeScreen.id);
          }
        }
      },
      child: Text("Sign Up", style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
          primary: KonsecColor,
          fixedSize: Size(MediaQuery.of(context).size.width, 0)),
    );
  }

  Widget signUpButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, SignUpScreen.id),
        child: Text("Sign Up", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
            fixedSize: Size(MediaQuery.of(context).size.width, 0)),
      ),
    );
  }
}
