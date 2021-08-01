import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/screens/blood_request_screen.dart';
import 'package:one_blood/screens/home_screen.dart';
import 'package:one_blood/screens/setting_screen.dart';
import 'package:one_blood/widgets/homebutton.dart';

class TabScreen extends StatefulWidget {
  static const String id = "TabScreen";
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [HomeScreen(), SettingScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: KonsecColor,
        onTap: (index) => setState(() => selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Requests"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("One Blood",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: KonsecColor,
      ),
      body: screens[selectedIndex],
      floatingActionButton: floatingButton(),
    );
  }

  Widget floatingButton() => FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, BloodRequestScreen.id),
        child: Icon(Icons.add),
        backgroundColor: KonsecColor,
      );
}
