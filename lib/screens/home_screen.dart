import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/widgets/homebutton.dart';
import 'package:one_blood/widgets/blood_search.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: Icon(Icons.home_outlined), iconSize: 35, color: KonsecColor, onPressed: () {}),
            // Spacer(),
            IconButton(icon: Icon(Icons.info_outlined), iconSize: 35, color: KonsecColor, onPressed: () {
              Navigator.pushNamed(context, '/info');
            }),
          ],
        ),
      ),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "One Blood",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: KonsecColor,
      ),
      body: Body()
    );
  }
}

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BloodSearch(),

        ],
      ),
    );
  }
}
