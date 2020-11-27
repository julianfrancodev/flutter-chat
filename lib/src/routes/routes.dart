import 'package:flutter/cupertino.dart';
import 'package:realtime_chat/src/pages/chat_page.dart';
import 'package:realtime_chat/src/pages/loading_page.dart';
import 'package:realtime_chat/src/pages/login_page.dart';
import 'package:realtime_chat/src/pages/register_page.dart';
import 'package:realtime_chat/src/pages/users_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => LoginPage(),
  '/users' : (context) => UsersPage(),
  '/chat' : (context) => ChatPage(),
  '/register': (context) => RegisterPage(),
  '/loading' : (context) => LoadinPage(),
};
