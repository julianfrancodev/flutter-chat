import 'dart:io';

class Env {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.1.9:3000/api'
      : 'http://localhost:3000/api';
  static String socketUrl =  Platform.isAndroid
      ? 'http://192.168.1.9:3000'
      : 'http://localhost:3000';
}
