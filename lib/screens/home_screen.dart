import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/screens/srch_result.dart';
import 'package:one_blood/services/blood_request.dart';
import 'package:one_blood/services/location.dart';
import 'package:one_blood/widgets/blood_type_dropdown.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  Location location = Location();
  Position? position;

  String selectedBloodType = 'A+';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            searchDropDown(),
            StreamBuilder<List>(
              stream: BloodRequestService().bloodRequests,
              builder: (context, snapshots) {
                if (snapshots.data != null) if (snapshots.data!.isEmpty)
                  return Center(
                    child: Text("No Requests"),
                  );

                if (snapshots.hasData) return requestBuilder(snapshots.data);

                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget requestBuilder(List? data) => Expanded(
        child: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 60,
                child: Row(
                  children: [
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                  ],
                ),
              ),
            );
            // data[index]
          },
        ),
      );

  Widget searchDropDown() => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: BloodTypeDropDown(
                  onChanged: (value) =>
                      setState(() => selectedBloodType = value as String)),
            ),
          )
        ],
      );
}
