// To parse this JSON data, do
//
//     final modelo = modeloFromJson(jsonString);

import 'dart:convert';

Modelo modeloFromJson(String str) => Modelo.fromJson(json.decode(str));

String modeloToJson(Modelo data) => json.encode(data.toJson());

class Modelo {
  Modelo({
    required this.modId,
    required this.marId,
    required this.marNombre,
    required this.modNombre,
    this.codigo,
    this.eprId,
  });

  int modId;
  int marId;
  String marNombre;
  String modNombre;
  String? codigo;
  int? eprId;

  factory Modelo.fromJson(Map<String, dynamic> json) => Modelo(
        modId: json["mod_id"],
        marId: json["mar_id"],
        marNombre: json["mar_nombre"],
        modNombre: json["mod_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "mod_id": modId,
        "mar_id": marId,
        "mar_nombre": marNombre,
        "mod_nombre": modNombre,
      };
  Map<String, dynamic> toJsonWs() => {
        "marca": marId,
        "nombre": modNombre,
        "codigo": modNombre,
        "activo": true,
        "empresa": eprId,
      };
}
