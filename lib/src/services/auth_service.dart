import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/src/global/env.dart';
import 'package:realtime_chat/src/models/signin_response.dart';
import 'package:realtime_chat/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  User user;
  bool _authenticating = false;

  bool get authenticating => this._authenticating;

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  // token getters

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('token');
  }

  static Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> signin(String email, String password) async {
    this.authenticating = true;

    final data = {"email": email, "password": password};

    final resp = await http.post('${Env.apiUrl}/signin',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    this.authenticating = false;

    if (resp.statusCode == 200) {
      final signinResponse = signinResponseFromJson(resp.body);
      this.user = signinResponse.user;
      print(user.email);
      // TODO save token
      this._saveToken(signinResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    this.authenticating = true;

    final data = {"name": name, "email": email, "password": password};

    final resp = await http.post('${Env.apiUrl}/signin/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    this.authenticating = false;

    if (resp.statusCode == 200) {
      final signinResponse = signinResponseFromJson(resp.body);
      this.user = signinResponse.user;
      print(user.email);
      // TODO save token
      this._saveToken(signinResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isSigini() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String token = await prefs.getString("token");
    print(token);
    final resp = await http.get('${Env.apiUrl}/signin/renew',
        headers: {'Content-Type': 'application/json','x-token': token});

    print(resp.body);

    if (resp.statusCode == 200) {
      final signinResponse = signinResponseFromJson(resp.body);
      this.user = signinResponse.user;
      print(user.email);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
