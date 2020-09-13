import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/src/routes/routes.dart';
import 'package:realtime_chat/src/services/auth_service.dart';

void main(){
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService(),)
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      routes: routes,
    ),
  ));
}