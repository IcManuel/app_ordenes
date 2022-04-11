// To parse this JSON data, do
//
//     final marcaProducto = marcaProductoFromJson(jsonString);

import 'dart:convert';

MarcaProducto marcaProductoFromJson(String str) =>
    MarcaProducto.fromJson(json.decode(str));

String marcaProductoToJson(MarcaProducto data) => json.encode(data.toJson());

class MarcaProducto {
  MarcaProducto(
      {required this.mprId,
      required this.mprCodigo,
      required this.mprNombre,
      required this.eprId,
      required this.activo});

  int mprId;
  String mprCodigo;
  String mprNombre;
  int eprId;
  bool activo;

  factory MarcaProducto.fromJson(Map<String, dynamic> json) => MarcaProducto(
      mprId: json["mpr_id"],
      mprCodigo: json["mpr_codigo"],
      mprNombre: json["mpr_nombre"],
      eprId: json["epr_id"],
      activo: json["mpr_activo"]);

  Map<String, dynamic> toJson() => {
        "mpr_id": mprId,
        "mpr_codigo": mprCodigo,
        "mpr_nombre": mprNombre,
        "epr_id": eprId,
      };

  Map<String, dynamic> toJsonWs() => {
        "empresa": eprId,
        "nombre": mprNombre,
        "codigo": mprCodigo,
        "activo": true,
      };
}
