// To parse this JSON data, do
//
//     final detalleResponse = detalleResponseFromJson(jsonString);

import 'package:app_ordenes/models/dorden_model.dart';

import 'dart:convert';

import 'package:app_ordenes/models/imagen_model.dart';

DetalleResponse detalleResponseFromJson(String str) =>
    DetalleResponse.fromJson(json.decode(str));

String detalleResponseToJson(DetalleResponse data) =>
    json.encode(data.toJson());

class DetalleResponse {
  DetalleResponse({
    required this.ok,
    this.detalles,
    this.msg,
    this.imagenes,
  });

  bool ok;
  String? msg;
  List<Dorden>? detalles;
  List<ImagenModel>? imagenes;

  factory DetalleResponse.fromJson(Map<String, dynamic> json) =>
      DetalleResponse(
        ok: json["ok"],
        msg: json["msg"],
        detalles: json["detalles"] != null
            ? List<Dorden>.from(json["detalles"].map((x) => Dorden.fromJson(x)))
            : null,
        imagenes: json["imagenes"] != null
            ? List<ImagenModel>.from(
                json["imagenes"].map((x) => ImagenModel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "detalles": List<dynamic>.from(detalles!.map((x) => x.toJson())),
      };
}
