/// account : "admin"
/// token : "a71bf2c4-b81c-4d35-acfa-6a589b6b3e72"

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String access_token;
  String refresh_token;


  UserData({
    this.access_token,
    this.refresh_token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    access_token: json["access_token"],
    refresh_token: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": access_token,
    "refresh_token": refresh_token,
  };
}
