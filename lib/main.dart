import 'package:flutter/material.dart';
import 'package:realtime_chat/src/routes/routes.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: routes,
  ));
}