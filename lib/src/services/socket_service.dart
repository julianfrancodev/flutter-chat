import 'package:flutter/material.dart';
import 'package:realtime_chat/src/global/env.dart';
import 'package:realtime_chat/src/services/auth_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;

  Function get emit => this._socket.emit;

  void connect() async {
    final token = await AuthService.getToken();
    // Dart client
    this._socket = IO.io('${Env.socketUrl}', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token},
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  disconnect() {
    _socket.disconnect();
  }
}
