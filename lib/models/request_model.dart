// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

import 'package:one_blood/models/user_model.dart';

class RequestModel {
  RequestModel({
    required this.requestingBlood,
    required this.city,
    required this.latitude,
    required this.user,
    required this.numberOfBottles,
    required this.longitude,
  });

  String requestingBlood;
  String city;
  double latitude;
  UserModel user;
  int numberOfBottles;
  double longitude;

  factory RequestModel.fromRawJson(String str) =>
      RequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        requestingBlood: json["requestingBlood"],
        city: json["city"],
        latitude: json["latitude"].toDouble(),
        user: UserModel.fromJson(json["user"]),
        numberOfBottles: json["numberOfBottles"],
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "requestingBlood": requestingBlood,
        "city": city,
        "latitude": latitude,
        "user": user.toJson(),
        "numberOfBottles": numberOfBottles,
        "longitude": longitude,
      };
}
