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
        future: validSigninState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text("Loading..."),
          );
        },
      ),
    );
  }

  Future validSigninState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);


    final auth = await authService.isSignin();
    if (auth) {
      socketService.connect();
      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) => UsersPage()));
    } else {
      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()));
    }
  }
}
