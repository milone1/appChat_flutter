import 'package:appchat_flutter/models/message_response.dart';
import 'package:appchat_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:appchat_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:appchat_flutter/Global/enviroments.dart';

class ChatService with ChangeNotifier {
  late User userFor;
  Future<List<Message>> getChat(String usuarioID) async {
    final url = '${Enviroments.apiUrl}/messages/$usuarioID';
    final token = await AuthService.getToken;

    final resp = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'x-token': token!});

    final mensajesResp = menssagesResponseFromJson(resp.body);

    return mensajesResp.message;
  }
}
