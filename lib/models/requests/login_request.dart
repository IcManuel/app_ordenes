// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    required this.alias,
    required this.contrasena,
  });

  String alias;
  String contrasena;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        alias: json["alias"],
        contrasena: json["contrasena"],
      );

  Map<String, dynamic> toJson() => {
        "alias": alias,
        "contrasena": contrasena,
      };
}
