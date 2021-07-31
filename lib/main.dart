import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/route_generator.dart';
import 'package:one_blood/screens/login.dart';
import 'package:one_blood/services/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Auth().signOut();
  runApp(FirebaseInitializer());
}

class FirebaseInitializer extends StatefulWidget {
  _FirebaseInitializerState createState() => _FirebaseInitializerState();
}

class _FirebaseInitializerState extends State<FirebaseInitializer> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // if(snapshot.hasError) return Any Screen You Can Build To Return Error
        if (snapshot.connectionState == ConnectionState.done) return MyApp();
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OneBlood",
      theme: ThemeData.light().copyWith(accentColor: KonsecColor),
      home: SignInScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
