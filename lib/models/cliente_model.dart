// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({
    required this.cliId,
    required this.cliIdentificacion,
    this.cliNombres,
    this.cliDireccion,
    this.cliCelular,
    this.cliCorreo,
    this.cliApellidos,
    this.eprId,
  });

  int cliId;
  String cliIdentificacion;
  String? cliNombres;
  String? cliDireccion;
  String? cliCelular;
  String? cliCorreo;
  String? cliApellidos;
  int? eprId;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        cliId: json["cli_id"],
        cliIdentificacion: json["cli_identificacion"],
        cliNombres: json["cli_nombres"],
        cliDireccion: json["cli_direccion"],
        cliCelular: json["cli_celular"],
        cliCorreo: json["cli_correo"],
        cliApellidos: json["cli_apellidos"],
      );

  Map<String, dynamic> toJson() => {
        "cli_id": cliId,
        "cli_identificacion": cliIdentificacion,
        "cli_nombres": cliNombres,
        "cli_direccion": cliDireccion,
        "cli_celular": cliCelular,
        "cli_correo": cliCorreo,
        "cli_apellidos": cliApellidos,
      };

  Map<String, dynamic> toJsonWs() => {
        "id": cliId,
        "identificacion": cliIdentificacion,
        "nombres": cliNombres,
        "direccion": cliDireccion,
        "celular": cliCelular,
        "correo": cliCorreo,
        "apellidos": cliApellidos,
        "empresa": eprId
      };
}
