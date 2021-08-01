import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/models/request_model.dart';
import 'package:one_blood/models/user_model.dart';
import 'package:one_blood/screens/srch_result.dart';
import 'package:one_blood/services/authentication.dart';
import 'package:one_blood/services/blood_request.dart';
import 'package:one_blood/services/location.dart';
import 'package:one_blood/services/user_services.dart';
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
        child: StreamBuilder<UserModel>(
          stream: UserService().userStream(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  searchDropDown(snapshot.data!),
                  StreamBuilder<List<RequestModel>>(
                    stream: BloodRequestService()
                        .bloodRequests(snapshot.data!.filters.requestingBlood),
                    builder: (context, snapshots) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Expanded(
                            child: Center(child: CircularProgressIndicator()));
                      if (snapshots.data != null) if (snapshots.data!.isEmpty)
                        return Expanded(
                          child: Center(
                            child: Text("No Requests"),
                          ),
                        );

                      if (snapshots.hasData)
                        return requestBuilder(snapshots.data!);

                      return Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    },
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget requestBuilder(List<RequestModel> data) => Expanded(
        child: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(data[index].user.name),
                    Text(data[index].numberOfBottles.toString()),
                    Text(data[index].city),
                  ],
                ),
              ),
            );
            // data[index]
          },
        ),
      );

  Widget searchDropDown(UserModel user) => Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: BloodTypeDropDown(
                  value: user.filters.requestingBlood,
                  onChanged: (value) =>
                      UserService().updateUserFilters(value as String)),
            ),
          )
        ],
      );
}
