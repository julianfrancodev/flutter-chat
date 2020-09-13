import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.name,
    this.online,
    this.email,
    this.uid,
  });

  String name;
  bool online;
  String email;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    online: json["online"],
    email: json["email"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "online": online,
    "email": email,
    "uid": uid,
  };
}
