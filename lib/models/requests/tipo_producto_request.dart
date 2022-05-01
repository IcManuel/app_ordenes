// To parse this JSON data, do
//
//     final tipoProductoRequest = tipoProductoRequestFromJson(jsonString);

import 'dart:convert';

TipoProductoRequest tipoProductoRequestFromJson(String str) =>
    TipoProductoRequest.fromJson(json.decode(str));

String tipoProductoRequestToJson(TipoProductoRequest data) =>
    json.encode(data.toJson());

class TipoProductoRequest {
  TipoProductoRequest({
    required this.empresa,
    this.reporta,
  });

  int empresa;
  int? reporta;

  factory TipoProductoRequest.fromJson(Map<String, dynamic> json) =>
      TipoProductoRequest(
        empresa: json["empresa"],
        reporta: json["reporta"],
      );

  Map<String, dynamic> toJson() => {
        "empresa": empresa,
        "reporta": reporta,
      };
}
