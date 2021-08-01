import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:one_blood/services/authentication.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  static const String id = "SettingScreen";
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text("Sign Out"),
            onTap: () => auth.signOut(),
          )
        ],
      ),
    );
  }
}

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);
//
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   final _fburl = "https://web.facebook.com/farhanaliraza.azeemi.3/";
//   final _githuburl = "https://github.com/FarhanAliRaza";
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           MyImage(),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Center(
//               child: SizedBox(
//                 width: 250.0,
//                 child: DefaultTextStyle(
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 30.0,
//                     fontFamily: 'Agne',
//                   ),
//                   child: AnimatedTextKit(
//                     animatedTexts: [
//                       TypewriterAnimatedText('I am Farhan Ali Raza'),
//                       // TypewriterAnimatedText('I am entrepreneur'),
//                     ],
//                     onTap: () {
//                       print("Tap Event");
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text(
//               "I am a third year student of BSCS in Islamia University Bahawalpur Bahawalnagar.I am interested in backend development, AI and Blockchain.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white70,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
//             child: GestureDetector(
//               onTap: () {
//                 launch(_githuburl);
//                 // if (_formKey.currentState!.validate()) {
//                 //
//                 // }
//                 print("tapped");
//               },
//               child: Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white, width: 1),
//                       borderRadius: BorderRadius.all(Radius.circular(7.0))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Github",
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
//             child: GestureDetector(
//               onTap: () {
//                 launch(_fburl);
//
//                 // if (_formKey.currentState!.validate()) {
//                 //
//                 // }
//                 print("tapped");
//               },
//               child: Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white, width: 1),
//                       borderRadius: BorderRadius.all(Radius.circular(7.0))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Facebook",
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MyImage extends StatelessWidget {
//   const MyImage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: CircleAvatar(
//         backgroundImage: AssetImage("images/pro.png"),
//         radius: 80,
//       ),
//     );
//   }
// }
