import 'package:http/http.dart' as http;
import 'package:realtime_chat/src/global/env.dart';

import 'package:realtime_chat/src/models/user_model.dart';
import 'package:realtime_chat/src/models/user_response.dart';
import 'package:realtime_chat/src/services/auth_service.dart';

class UserService {
  Future<List<User>> getUsers() async {
    try {
      final resp = await http.get('${Env.apiUrl}/users', headers: {
        'Context-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });

      final userResponse = userResponseFromJson(resp.body);
      return userResponse.users;
    } catch (err) {}
  }
}
