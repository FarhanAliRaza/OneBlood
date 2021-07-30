import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_blood/screens/srch_result.dart';

class BloodSearch extends StatefulWidget {
  @override
  _BloodSearchState createState() => _BloodSearchState();
}

class _BloodSearchState extends State<BloodSearch> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> listOfBlood = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  String? bloodType;
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
                child: DropdownButtonFormField(
                  validator: (value) {
                    print(value.toString());
                    if (value.toString() == "null") {
                      return 'Please Select a Blood Type';
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KonsecColor, width: 3)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KonsecColor, width: 1)),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    'Select Blood Type',
                  ),
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      this.bloodType = value.toString();
                    });
                  },
                  onSaved: (value) {
                    setState(() {});
                  },
                  items: listOfBlood.map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                        val,
                        style: TextStyle(
                          fontSize: 15,
                          color: KonsecColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
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
                          arguments: bloodType.toString());
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
