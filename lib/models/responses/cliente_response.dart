// To parse this JSON data, do
//
//     final clienteResponse = clienteResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/cliente_model.dart';

ClienteResponse clienteResponseFromJson(String str) =>
    ClienteResponse.fromJson(json.decode(str));

String clienteResponseToJson(ClienteResponse data) =>
    json.encode(data.toJson());

class ClienteResponse {
  ClienteResponse({
    required this.ok,
    this.encontrado = false,
    this.msg,
    this.cliente,
    this.clientes,
  });

  bool ok;
  bool? encontrado;
  String? msg;
  Cliente? cliente;
  List<Cliente>? clientes;

  factory ClienteResponse.fromJson(Map<String, dynamic> json) =>
      ClienteResponse(
        ok: json["ok"],
        msg: json["msg"],
        encontrado: json["encontrado"],
        cliente:
            json["cliente"] != null ? Cliente.fromJson(json["cliente"]) : null,
        clientes: (json["clientes"] != null
            ? List<Cliente>.from(
                json["clientes"].map((x) => Cliente.fromJson(x)))
            : null),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
      };
}
