// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

User usuarioFromJson(String str) => User.fromJson(json.decode(str));

String usuarioToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.online,
    required this.nombre,
    required this.email,
    required this.uid,
  });

  bool online;
  String nombre;
  String email;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
        online: json["online"] ?? false,
        nombre: json["nombre"] ?? "",
        email: json["email"] ?? "",
        uid: json["uid"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "nombre": nombre,
        "email": email,
        "uid": uid,
      };
}
