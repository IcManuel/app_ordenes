// To parse this JSON data, do
//
//     final dorden = dordenFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/producto_model.dart';

Dorden dordenFromJson(String str) => Dorden.fromJson(json.decode(str));

String dordenToJson(Dorden data) => json.encode(data.toJson());

class Dorden {
  Dorden(
      {required this.producto,
      required this.cantidad,
      required this.precio,
      required this.descuento,
      required this.vdescuento,
      required this.total,
      required this.observacion,
      this.productoFinal});

  int producto;
  double cantidad;
  double precio;
  double descuento;
  double vdescuento;
  double total;
  String observacion;
  Producto? productoFinal;

  factory Dorden.fromJson(Map<String, dynamic> json) => Dorden(
        producto: json["producto"],
        cantidad: json["cantidad"].toDouble(),
        precio: json["precio"].toDouble(),
        descuento: json["descuento"].toDouble(),
        vdescuento: json["vdescuento"].toDouble(),
        total: json["total"].toDouble(),
        observacion: json["observacion"],
      );

  Map<String, dynamic> toJson() => {
        "producto": producto,
        "cantidad": cantidad,
        "precio": precio,
        "descuento": descuento,
        "vdescuento": vdescuento,
        "total": total,
        "observacion": observacion,
      };
}
