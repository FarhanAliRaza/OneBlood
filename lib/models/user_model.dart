// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  UserModel({
    required this.bloodType,
    required this.email,
    required this.lat,
    required this.lon,
    required this.name,
    required this.phone,
    required this.uid,
  });

  String bloodType;
  String email;
  double lat;
  double lon;
  String? name;
  String phone;
  String uid;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        bloodType: json["bloodtype"],
        email: json["email"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        name: json["name"],
        phone: json["phone"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "bloodtype": bloodType,
        "email": email,
        "lat": lat,
        "lon": lon,
        "name": name,
        "phone": phone,
        "uid": uid,
      };
}
