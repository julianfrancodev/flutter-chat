import 'package:flutter/material.dart';
import 'package:realtime_chat/src/global/env.dart';
import 'package:realtime_chat/src/models/message_response.dart';
import 'package:realtime_chat/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/src/services/auth_service.dart';

class ChatService with ChangeNotifier {
  User userFor;

  Future<List<Message>> getChat(String userID) async {
    final resp = await http.get('${Env.apiUrl}/messages/${userID}', headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final messageResponse = messageResponseFromJson(resp.body);

    return messageResponse.messages;
  }
}
