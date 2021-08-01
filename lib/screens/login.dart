import 'package:flutter/material.dart';
import 'package:one_blood/models/user_model.dart';
import 'package:one_blood/screens/tab_screen.dart';
import 'package:one_blood/screens/profile_detail_screen.dart';
import 'package:one_blood/screens/sign_up_screen.dart';
import 'package:one_blood/services/authentication.dart';
import 'package:one_blood/services/user_services.dart';
import 'package:one_blood/widgets/heading.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:one_blood/contants.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "SignInScreen";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Auth auth = Auth();
  UserService fireStore = UserService();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(padding: const EdgeInsets.all(20.0), child: Header()),
              Image(
                  image: AssetImage("images/donor.png"),
                  height: 270,
                  width: double.infinity),
              SizedBox(height: 30),
              MaterialButton(
                padding: EdgeInsets.all(2),
                onPressed: () async {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Logging in')));
                  await auth.signInWithGoogle();
                },
                height: 60,
                color: Colors.blue.shade400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 60,
                      height: 60,
                      child: Image.asset('images/gg.png'),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
              // SizedBox(height: 40),
              // signInTextField(
              //     emailController, "Email Address", TextInputType.emailAddress),
              // SizedBox(height: 10),
              // signInTextField(passwordController, "Password",
              //     TextInputType.visiblePassword, true),
              // SizedBox(height: 10),
              // Row(
              //   children: [signUpButton(), SizedBox(width: 16), loginButton()],
              // ),
              // Divider(indent: 12, endIndent: 12),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     MaterialButton(
              //       onPressed: () {},
              //       height: 70,
              //       shape: CircleBorder(
              //           side: BorderSide(color: Colors.grey.shade200)),
              //       child: Image.asset('images/gg.png', height: 50),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   width: 300,
              //   child: GestureDetector(
              //     onTap: () async {
              //       ScaffoldMessenger.of(context)
              //           .showSnackBar(SnackBar(content: Text('Logging in')));
              //       auth.signInWithGoogle();
              //       final User? user = auth.currentUser;
              //       if (user != null) {
              //         UserModel? userData =
              //             await fireStore.getUserData(user.uid);
              //         if (userData == null)
              //           Navigator.pushReplacementNamed(
              //               context, UserDataScreen.id);
              //         if (userData != null)
              //           Navigator.pushReplacementNamed(context, HomeScreen.id);
              //       }
              //     },
              //     child: Container(
              //         padding: EdgeInsets.all(5),
              //         decoration: BoxDecoration(
              //             border: Border.all(color: KonsecColor, width: 3),
              //             borderRadius: BorderRadius.all(Radius.circular(7.0))),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Image.asset('images/gg.png', height: 40, width: 30),
              //             SizedBox(width: 7),
              //             Text("Login With Google", style: Konbtntext),
              //           ],
              //         )),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }

  Widget signInTextField(TextEditingController controller, String hintText,
      TextInputType keyboardType,
      [bool obscureText = false]) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KonsecColor),
          )),
    );
  }

  Widget loginButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        child: Text("Login", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
            primary: KonsecColor,
            fixedSize: Size(MediaQuery.of(context).size.width, 0)),
      ),
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
