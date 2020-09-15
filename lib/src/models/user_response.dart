// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

import 'package:realtime_chat/src/models/user_model.dart';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.msg,
    this.users,
  });

  bool msg;
  List<User> users;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    msg: json["msg"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}


