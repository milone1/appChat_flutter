// To parse this JSON data, do
//
//  final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';
import 'package:appchat_flutter/models/user.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    required this.usuario,
    required this.token,
  });

  bool ok;
  User usuario;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw ArgumentError("Input JSON cannot be null");
    }
    return LoginResponse(
      ok: json["ok"] ?? false,
      usuario: User.fromJson(json["usuario"] ?? {}),
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
      };
}
