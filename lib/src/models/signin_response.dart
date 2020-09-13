import 'dart:convert';

import 'package:realtime_chat/src/models/user_model.dart';

SigninResponse signinResponseFromJson(String str) => SigninResponse.fromJson(json.decode(str));

String signinResponseToJson(SigninResponse data) => json.encode(data.toJson());

class SigninResponse {
  SigninResponse({
    this.ok,
    this.user,
    this.token,
  });

  bool ok;
  User user;
  String token;

  factory SigninResponse.fromJson(Map<String, dynamic> json) => SigninResponse(
    ok: json["ok"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "user": user.toJson(),
    "token": token,
  };
}
