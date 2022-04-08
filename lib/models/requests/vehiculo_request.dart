// To parse this JSON data, do
//
//     final vehiculoRequest = vehiculoRequestFromJson(jsonString);

import 'dart:convert';

VehiculoRequest vehiculoRequestFromJson(String str) =>
    VehiculoRequest.fromJson(json.decode(str));

String vehiculoRequestToJson(VehiculoRequest data) =>
    json.encode(data.toJson());

class VehiculoRequest {
  VehiculoRequest({
    required this.empresa,
    required this.placa,
  });

  int empresa;
  String placa;

  factory VehiculoRequest.fromJson(Map<String, dynamic> json) =>
      VehiculoRequest(
        empresa: json["empresa"],
        placa: json["placa"],
      );

  Map<String, dynamic> toJson() => {
        "empresa": empresa,
        "placa": placa,
      };
}
