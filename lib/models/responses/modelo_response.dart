// To parse this JSON data, do
//
//     final modeloResponse = modeloResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/modelo_model.dart';

ModeloResponse modeloResponseFromJson(String str) =>
    ModeloResponse.fromJson(json.decode(str));

String modeloResponseToJson(ModeloResponse data) => json.encode(data.toJson());

class ModeloResponse {
  ModeloResponse({
    required this.ok,
    this.modelos,
    this.msg,
  });

  bool ok;
  List<Modelo>? modelos;
  String? msg;

  factory ModeloResponse.fromJson(Map<String, dynamic> json) => ModeloResponse(
        ok: json["ok"],
        msg: json["msg"],
        modelos: (json["modelos"] != null
            ? List<Modelo>.from(json["modelos"].map((x) => Modelo.fromJson(x)))
            : null),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "modelos": List<Modelo>.from(modelos!.map((x) => x)),
      };
}
