// To parse this JSON data, do
//
//     final marcaResponse = marcaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/marca_model.dart';
import 'package:app_ordenes/models/marca_producto_model.dart';
import 'package:app_ordenes/models/tipo_producto_model.dart';

MarcaResponse marcaResponseFromJson(String str) =>
    MarcaResponse.fromJson(json.decode(str));

String marcaResponseToJson(MarcaResponse data) => json.encode(data.toJson());

class MarcaResponse {
  MarcaResponse(
      {required this.ok,
      this.msg,
      this.marcas,
      this.uid,
      this.tipoProductos,
      this.marcaProductos});

  bool ok;
  String? msg;
  List<Marca>? marcas;
  List<TipoProducto>? tipoProductos;
  List<MarcaProducto>? marcaProductos;
  int? uid;

  factory MarcaResponse.fromJson(Map<String, dynamic> json) => MarcaResponse(
        ok: json["ok"],
        msg: json["msg"],
        uid: json["uid"],
        marcas: (json["marcas"] != null
            ? List<Marca>.from(json["marcas"].map((x) => Marca.fromJson(x)))
            : null),
        tipoProductos: (json["tipos"] != null
            ? List<TipoProducto>.from(
                json["tipos"].map((x) => TipoProducto.fromJson(x)))
            : null),
        marcaProductos: (json["marcas_producto"] != null
            ? List<MarcaProducto>.from(
                json["marcas_producto"].map((x) => MarcaProducto.fromJson(x)))
            : null),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "uid": uid,
        "msg": msg,
        "marcas": List<Marca>.from(marcas!.map((x) => x.toJson())),
      };
}
