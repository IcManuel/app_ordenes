// To parse this JSON data, do
//
//     final caracteristicaResponse = caracteristicaResponseFromJson(jsonString);

import 'package:app_ordenes/models/caracteristica_model.dart';
import 'dart:convert';

import 'package:app_ordenes/models/lista_caracteristica_model.dart';

CaracteristicaResponse caracteristicaResponseFromJson(String str) =>
    CaracteristicaResponse.fromJson(json.decode(str));

String caracteristicaResponseToJson(CaracteristicaResponse data) =>
    json.encode(data.toJson());

class CaracteristicaResponse {
  CaracteristicaResponse({
    required this.ok,
    this.caracteristicas,
    this.msg,
    this.lista,
  });

  bool ok;
  List<Caracteristica>? caracteristicas;
  List<ListaCaracteristica>? lista;
  String? msg;

  factory CaracteristicaResponse.fromJson(Map<String, dynamic> json) =>
      CaracteristicaResponse(
        ok: json["ok"],
        msg: json["msg"],
        caracteristicas: json["caracteristicas"] != null
            ? List<Caracteristica>.from(
                json["caracteristicas"].map((x) => Caracteristica.fromJson(x)))
            : null,
        lista: json["lista"] != null
            ? List<ListaCaracteristica>.from(
                json["lista"].map((x) => ListaCaracteristica.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "caracteristicas":
            List<dynamic>.from(caracteristicas!.map((x) => x.toJson())),
      };
}
