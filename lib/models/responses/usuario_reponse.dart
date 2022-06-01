// To parse this JSON data, do
//
//     final usuarioReponse = usuarioReponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/usuario_model.dart';

UsuarioReponse usuarioReponseFromJson(String str) =>
    UsuarioReponse.fromJson(json.decode(str));

String usuarioReponseToJson(UsuarioReponse data) => json.encode(data.toJson());

class UsuarioReponse {
  UsuarioReponse({
    required this.ok,
    this.usuario,
    this.msg,
    this.statusCode,
    this.usuarios,
  });

  bool ok;
  Usuario? usuario;
  String? msg;
  int? statusCode;
  List<Usuario>? usuarios;

  factory UsuarioReponse.fromJson(Map<String, dynamic> json) => UsuarioReponse(
        ok: json["ok"],
        msg: json["msg"],
        usuario:
            json["usuario"] != null ? Usuario.fromJson(json["usuario"]) : null,
        usuarios: json["usuarios"] != null
            ? List<Usuario>.from(
                json["usuarios"].map(
                  (x) => Usuario.fromJson(x),
                ),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
      };
}
