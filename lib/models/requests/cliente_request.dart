// To parse this JSON data, do
//
//     final clienteRequest = clienteRequestFromJson(jsonString);

import 'dart:convert';

ClienteRequest clienteRequestFromJson(String str) =>
    ClienteRequest.fromJson(json.decode(str));

String clienteRequestToJson(ClienteRequest data) => json.encode(data.toJson());

class ClienteRequest {
  ClienteRequest({
    required this.identificacion,
    required this.empresa,
  });

  String identificacion;
  int empresa;

  factory ClienteRequest.fromJson(Map<String, dynamic> json) => ClienteRequest(
        identificacion: json["identificacion"],
        empresa: json["empresa"],
      );

  Map<String, dynamic> toJson() => {
        "identificacion": identificacion,
        "empresa": empresa,
      };
}
