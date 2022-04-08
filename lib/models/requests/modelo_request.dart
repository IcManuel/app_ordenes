// To parse this JSON data, do
//
//     final modeloRequest = modeloRequestFromJson(jsonString);

import 'dart:convert';

ModeloRequest modeloRequestFromJson(String str) =>
    ModeloRequest.fromJson(json.decode(str));

String modeloRequestToJson(ModeloRequest data) => json.encode(data.toJson());

class ModeloRequest {
  ModeloRequest({
    required this.marca,
    required this.empresa,
  });

  int marca;
  int empresa;

  factory ModeloRequest.fromJson(Map<String, dynamic> json) => ModeloRequest(
        marca: json["marca"],
        empresa: json["empresa"],
      );

  Map<String, dynamic> toJson() => {
        "marca": marca,
        "empresa": empresa,
      };
}
