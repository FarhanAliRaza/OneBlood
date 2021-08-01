// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  UserModel({
    required this.bloodtype,
    required this.email,
    required this.lat,
    required this.lon,
    required this.name,
    required this.phone,
    required this.uid,
    required this.filters,
  });

  String bloodtype;
  String email;
  double lat;
  double lon;
  String name;
  String phone;
  String uid;
  Filters filters;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        bloodtype: json["bloodtype"],
        email: json["email"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        name: json["name"],
        phone: json["phone"],
        uid: json["uid"],
        filters: Filters.fromJson(json["filters"]),
      );

  Map<String, dynamic> toJson() => {
        "bloodtype": bloodtype,
        "email": email,
        "lat": lat,
        "lon": lon,
        "name": name,
        "phone": phone,
        "uid": uid,
        "filters": filters.toJson(),
      };
}

class Filters {
  Filters({
    required this.requestingBlood,
  });

  String requestingBlood;

  factory Filters.fromRawJson(String str) => Filters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        requestingBlood: json["requestingBlood"],
      );

  Map<String, dynamic> toJson() => {
        "requestingBlood": requestingBlood,
      };
}
