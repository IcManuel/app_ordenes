// To parse this JSON data, do
//
//     final vehiculoCarRequest = vehiculoCarRequestFromJson(jsonString);

import 'dart:convert';

VehiculoCarRequest vehiculoCarRequestFromJson(String str) =>
    VehiculoCarRequest.fromJson(json.decode(str));

String vehiculoCarRequestToJson(VehiculoCarRequest data) =>
    json.encode(data.toJson());

class VehiculoCarRequest {
  VehiculoCarRequest({
    required this.empresa,
    required this.id,
  });

  int empresa;
  int id;

  factory VehiculoCarRequest.fromJson(Map<String, dynamic> json) =>
      VehiculoCarRequest(
        empresa: json["empresa"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "empresa": empresa,
        "id": id,
      };
}
