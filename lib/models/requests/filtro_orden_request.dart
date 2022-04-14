// To parse this JSON data, do
//
//     final filtroOrdenRequest = filtroOrdenRequestFromJson(jsonString);

import 'dart:convert';

FiltroOrdenRequest filtroOrdenRequestFromJson(String str) =>
    FiltroOrdenRequest.fromJson(json.decode(str));

String filtroOrdenRequestToJson(FiltroOrdenRequest data) =>
    json.encode(data.toJson());

class FiltroOrdenRequest {
  FiltroOrdenRequest({
    required this.empresa,
    required this.fechai,
    required this.fechaf,
    required this.placa,
    required this.cliente,
    required this.estado,
  });

  int empresa;
  String fechai;
  String fechaf;
  String placa;
  String cliente;
  int estado;

  factory FiltroOrdenRequest.fromJson(Map<String, dynamic> json) =>
      FiltroOrdenRequest(
        empresa: json["empresa"],
        fechai: json["fechai"],
        fechaf: json["fechaf"],
        placa: json["placa"],
        cliente: json["cliente"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "empresa": empresa,
        "fechai": fechai,
        "fechaf": fechaf,
        "placa": placa,
        "cliente": cliente,
        "estado": estado,
      };
}
