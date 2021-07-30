import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfileScreen extends StatefulWidget {
  static const String id = "MyProfileScreen";
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03002E),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "One Blood",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFF03002E),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _fburl = "https://web.facebook.com/farhanaliraza.azeemi.3/";
  final _githuburl = "https://github.com/FarhanAliRaza";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyImage(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SizedBox(
                width: 250.0,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Agne',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('I am Farhan Ali Raza'),
                      // TypewriterAnimatedText('I am entrepreneur'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "I am a third year student of BSCS in Islamia University Bahawalpur Bahawalnagar.I am interested in backend development, AI and Blockchain.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
            child: GestureDetector(
              onTap: () {
                launch(_githuburl);
                // if (_formKey.currentState!.validate()) {
                //
                // }
                print("tapped");
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Github",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
            child: GestureDetector(
              onTap: () {
                launch(_fburl);

                // if (_formKey.currentState!.validate()) {
                //
                // }
                print("tapped");
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Facebook",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class MyImage extends StatelessWidget {
  const MyImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundImage: AssetImage("images/pro.png"),
        radius: 80,
      ),
    );
  }
}
