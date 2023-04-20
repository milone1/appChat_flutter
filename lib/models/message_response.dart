// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MessageResponse menssagesResponseFromJson(String str) =>
    MessageResponse.fromJson(json.decode(str));

String menssagesResponseToJson(MessageResponse data) =>
    json.encode(data.toJson());

class MessageResponse {
  MessageResponse({
    required this.ok,
    required this.message,
  });

  bool ok;
  List<Message> message;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        ok: json["ok"],
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.de,
    required this.para,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  String de;
  String para;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        de: json["de"],
        para: json["para"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
