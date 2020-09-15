import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/src/routes/routes.dart';
import 'package:realtime_chat/src/services/auth_service.dart';
import 'package:realtime_chat/src/services/chat_service.dart';
import 'package:realtime_chat/src/services/socket_service.dart';

void main(){
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService(),),
      ChangeNotifierProvider(create: (_) => SocketService(),),
      ChangeNotifierProvider(create: (_) => ChatService(),),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      routes: routes,
    ),
  ));
}