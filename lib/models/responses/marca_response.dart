// To parse this JSON data, do
//
//     final marcaResponse = marcaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/marca_model.dart';

MarcaResponse marcaResponseFromJson(String str) =>
    MarcaResponse.fromJson(json.decode(str));

String marcaResponseToJson(MarcaResponse data) => json.encode(data.toJson());

class MarcaResponse {
  MarcaResponse({
    required this.ok,
    this.msg,
    this.marcas,
    this.uid,
  });

  bool ok;
  String? msg;
  List<Marca>? marcas;
  int? uid;

  factory MarcaResponse.fromJson(Map<String, dynamic> json) => MarcaResponse(
        ok: json["ok"],
        msg: json["msg"],
        uid: json["uid"],
        marcas: (json["marcas"] != null
            ? List<Marca>.from(json["marcas"].map((x) => Marca.fromJson(x)))
            : null),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "uid": uid,
        "msg": msg,
        "marcas": List<Marca>.from(marcas!.map((x) => x.toJson())),
      };
}
