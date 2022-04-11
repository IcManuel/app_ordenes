// To parse this JSON data, do
//
//     final productoRequest = productoRequestFromJson(jsonString);

import 'dart:convert';

ProductoRequest productoRequestFromJson(String str) =>
    ProductoRequest.fromJson(json.decode(str));

String productoRequestToJson(ProductoRequest data) =>
    json.encode(data.toJson());

class ProductoRequest {
  ProductoRequest({
    required this.empresa,
    required this.tipo,
    required this.marca,
    required this.cadena,
    required this.tipoFiltro,
  });

  int empresa;
  int tipo;
  int marca;
  String cadena;
  int tipoFiltro;

  factory ProductoRequest.fromJson(Map<String, dynamic> json) =>
      ProductoRequest(
        empresa: json["empresa"],
        tipo: json["tipo"],
        marca: json["marca"],
        cadena: json["cadena"],
        tipoFiltro: json["tipoFiltro"],
      );

  Map<String, dynamic> toJson() => {
        "empresa": empresa,
        "tipo": tipo,
        "marca": marca,
        "cadena": cadena,
        "tipoFiltro": tipoFiltro,
      };
}
