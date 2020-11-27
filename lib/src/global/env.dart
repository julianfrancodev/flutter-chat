import 'dart:io';

class Env {
  static String apiUrl = Platform.isAndroid
      ? 'https://socket-chat-flutter.herokuapp.com/api'
      : 'https://socket-chat-flutter.herokuapp.com/api';
  static String socketUrl =  Platform.isAndroid
      ? 'https://socket-chat-flutter.herokuapp.com/'
      : 'https://socket-chat-flutter.herokuapp.com/';
}
