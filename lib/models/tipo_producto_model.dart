// To parse this JSON data, do
//
//     final tipoProducto = tipoProductoFromJson(jsonString);

import 'dart:convert';

TipoProducto tipoProductoFromJson(String str) =>
    TipoProducto.fromJson(json.decode(str));

String tipoProductoToJson(TipoProducto data) => json.encode(data.toJson());

class TipoProducto {
  TipoProducto({
    required this.tprId,
    required this.tprCodigo,
    required this.tprNombre,
    required this.eprId,
    required this.activo,
  });

  int tprId;
  String tprCodigo;
  String tprNombre;
  int eprId;
  bool activo;

  factory TipoProducto.fromJson(Map<String, dynamic> json) => TipoProducto(
      tprId: json["tpr_id"],
      tprCodigo: json["tpr_codigo"],
      tprNombre: json["tpr_nombre"],
      eprId: json["epr_id"],
      activo: json["tpr_activo"]);

  Map<String, dynamic> toJson() => {
        "tpr_id": tprId,
        "tpr_codigo": tprCodigo,
        "tpr_nombre": tprNombre,
        "epr_id": eprId,
      };
  Map<String, dynamic> toJsonWs() => {
        "empresa": eprId,
        "nombre": tprNombre,
        "codigo": tprCodigo,
        "activo": true,
      };
}
