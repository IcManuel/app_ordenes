// To parse this JSON data, do
//
//     final productoResponse = productoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/producto_model.dart';

ProductoResponse productoResponseFromJson(String str) =>
    ProductoResponse.fromJson(json.decode(str));

String productoResponseToJson(ProductoResponse data) =>
    json.encode(data.toJson());

class ProductoResponse {
  ProductoResponse({
    required this.ok,
    this.msg,
    this.productos,
  });

  bool ok;
  String? msg;
  List<Producto>? productos;

  factory ProductoResponse.fromJson(Map<String, dynamic> json) =>
      ProductoResponse(
        ok: json["ok"],
        msg: json["msg"],
        productos: json["productos"] != null
            ? List<Producto>.from(
                json["productos"].map((x) => Producto.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "productos": List<dynamic>.from(productos!.map((x) => x.toJson())),
      };
}
