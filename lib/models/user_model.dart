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
  });

  String bloodType;
  DateTime email;
  double lat;
  double lon;
  String name;
  String phone;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        bloodType: json["bloodtype"],
        email: DateTime.parse(json["email"]),
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "bloodtype": bloodType,
        "email": email.toIso8601String(),
        "lat": lat,
        "lon": lon,
        "name": name,
        "phone": phone,
      };
}
