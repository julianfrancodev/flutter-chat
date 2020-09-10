import 'package:flutter/material.dart';

class User {
  bool online;
  String email;
  String name;
  String uid;

  User({@required this.online, this.email, this.name, this.uid});
}
