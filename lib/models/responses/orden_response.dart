// To parse this JSON data, do
//
//     final ordenResponse = ordenResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/orden_model.dart';

OrdenResponse ordenResponseFromJson(String str) =>
    OrdenResponse.fromJson(json.decode(str));

String ordenResponseToJson(OrdenResponse data) => json.encode(data.toJson());

class OrdenResponse {
  OrdenResponse({
    required this.ok,
    this.msg,
    this.ordenes,
  });

  bool ok;
  List<Orden>? ordenes;
  String? msg;

  factory OrdenResponse.fromJson(Map<String, dynamic> json) => OrdenResponse(
        ok: json["ok"],
        msg: json["msg"],
        ordenes: json["ordenes"] != null
            ? List<Orden>.from(json["ordenes"].map((x) => Orden.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "ordenes": List<dynamic>.from(ordenes!.map((x) => x.toJson())),
      };
}
