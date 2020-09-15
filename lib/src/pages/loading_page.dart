import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/src/pages/login_page.dart';
import 'package:realtime_chat/src/pages/users_page.dart';
import 'package:realtime_chat/src/services/auth_service.dart';
import 'package:realtime_chat/src/services/socket_service.dart';

class LoadinPage extends StatefulWidget {
  @override
  _LoadinPageState createState() => _LoadinPageState();
}

class _LoadinPageState extends State<LoadinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: validSiginiState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text("Please Wait..."),
          );
        },
      ),
    );
  }

  Future validSiginiState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);


    final authted = await authService.isSigini();
    if (authted) {
      socketService.connect();
      // Navigator.pushReplacementNamed(context, '/users');
      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) => UsersPage()));
    } else {
      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()));
    }
  }
}
