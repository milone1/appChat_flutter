import 'dart:convert';

import 'package:appchat_flutter/models/login_response.dart';
import 'package:appchat_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:appchat_flutter/Global/enviroments.dart';

class AuthService with ChangeNotifier {
  late User usuario;
  final String url = '${Enviroments.apiUrl}/login';
  final String urlRegister = '${Enviroments.apiUrl}/login/new';
  final String urlRenew = '${Enviroments.apiUrl}/login/renew';

  final _storage = const FlutterSecureStorage();

  bool _autenticando = false;

  bool get autenticando => _autenticando;

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  //* getters de manera estatica
  static Future<String?> get getToken async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> get deleteToken async {
    const storage = FlutterSecureStorage();
    await storage.read(key: 'token');
  }

  // ignore: non_constant_identifier_names
  Future Login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};
    final res = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    autenticando = false;

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};
    final res = await http.post(
      Uri.parse(urlRegister),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    autenticando = false;

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(res.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';

    final res = await http.post(Uri.parse(urlRenew),
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      logOut();
      return false;
    }
  }

  Future _saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    await _storage.delete(key: 'token');
  }
}
