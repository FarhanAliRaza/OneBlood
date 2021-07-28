import 'package:flutter/material.dart';
import 'package:one_blood/screens/home_screen.dart';
import 'package:one_blood/screens/login.dart';
import 'package:one_blood/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_blood/screens/info.dart';
import 'package:one_blood/screens/srch_result.dart';

import 'package:one_blood/contants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed

    return MaterialApp(
      title: "OneBlood",
      theme: ThemeData.light().copyWith(
        accentColor: KonsecColor,
      ),
      // home: Home(),
      initialRoute: '/login',
      routes: {
        '/': (context) => Home(),
        '/signup': (context) => Signup(),
        '/login': (context) => Signin(),
        '/info': (context) => Myprofile(),
        '/search': (context) => SearchScreen("AB+"),
      },
    );
  }
}
