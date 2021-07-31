import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_blood/screens/srch_result.dart';
import 'package:one_blood/widgets/blood_type_dropdown.dart';

class BloodSearch extends StatefulWidget {
  @override
  _BloodSearchState createState() => _BloodSearchState();
}

class _BloodSearchState extends State<BloodSearch> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String selectedBloodType = listOfBlood[0];
  double? lon;
  double? lat;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                width: 300,
                child: BloodTypeDropDown(
                    onChanged: (value) =>
                        setState(() => selectedBloodType = value as String)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 220,
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, SearchScreen.id,
                          arguments: selectedBloodType.toString());
                    }
                    print("tapped");
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: KonsecColor, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/logo.png',
                            height: 40,
                            width: 20,
                          ),
                          SizedBox(width: 7),
                          Text(
                            "Search Blood",
                            style: Konbtntext,
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
