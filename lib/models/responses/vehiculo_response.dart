import 'dart:convert';

import 'package:app_ordenes/models/vehiculo_model.dart';

VehiculoResponse clienteResponseFromJson(String str) =>
    VehiculoResponse.fromJson(json.decode(str));

String clienteResponseToJson(VehiculoResponse data) =>
    json.encode(data.toJson());

class VehiculoResponse {
  VehiculoResponse({
    required this.ok,
    this.encontrado = false,
    this.msg,
    this.vehiculo,
    this.vehiculos,
  });

  bool ok;
  bool? encontrado;
  String? msg;
  Vehiculo? vehiculo;
  List<Vehiculo>? vehiculos;

  factory VehiculoResponse.fromJson(Map<String, dynamic> json) =>
      VehiculoResponse(
        ok: json["ok"],
        msg: json["msg"],
        encontrado: json["encontrado"],
        vehiculo: json["vehiculo"] != null
            ? Vehiculo.fromJson(json["vehiculo"])
            : null,
        vehiculos: (json["vehiculos"] != null
            ? List<Vehiculo>.from(
                json["vehiculos"].map((x) => Vehiculo.fromJson(x)))
            : null),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
      };
}
