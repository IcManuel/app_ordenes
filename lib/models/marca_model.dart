// To parse this JSON data, do
//
//     final marca = marcaFromJson(jsonString);

import 'dart:convert';

Marca marcaFromJson(String str) => Marca.fromJson(json.decode(str));

String marcaToJson(Marca data) => json.encode(data.toJson());

class Marca {
  Marca({
    required this.marId,
    required this.eprId,
    required this.marCodigo,
    required this.marNombre,
    required this.marActivo,
  });

  int marId;
  int eprId;
  String marCodigo;
  String marNombre;
  bool marActivo;

  factory Marca.fromJson(Map<String, dynamic> json) => Marca(
        marId: json["mar_id"],
        eprId: json["epr_id"],
        marCodigo: json["mar_codigo"],
        marNombre: json["mar_nombre"],
        marActivo: json["mar_activo"],
      );

  Map<String, dynamic> toJson() => {
        "mar_id": marId,
        "epr_id": eprId,
        "mar_codigo": marCodigo,
        "mar_nombre": marNombre,
        "mar_activo": marActivo,
      };

  Map<String, dynamic> toJsonWs() => {
        "empresa": eprId,
        "codigo": marCodigo,
        "nombre": marNombre,
        "activo": marActivo,
      };
}
