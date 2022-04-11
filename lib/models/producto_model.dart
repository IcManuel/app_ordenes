// To parse this JSON data, do
//
//     final producto = productoFromJson(jsonString);

import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
  Producto({
    required this.proId,
    required this.proCodigo,
    required this.proNombre,
    required this.proInventario,
    this.proPrecio,
    required this.tprId,
    required this.tprCodigo,
    required this.tprNombre,
    required this.mprId,
    required this.mprCodigo,
    required this.mprNombre,
    this.eprId,
  });

  int proId;
  String proCodigo;
  String proNombre;
  bool proInventario;
  double? proPrecio;
  int tprId;
  String tprCodigo;
  String tprNombre;
  int mprId;
  String mprCodigo;
  String mprNombre;
  int? eprId;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        proId: json["pro_id"],
        proCodigo: json["pro_codigo"],
        proNombre: json["pro_nombre"],
        proInventario: json["pro_inventario"],
        proPrecio: json["pro_precio"].toDouble(),
        tprId: json["tpr_id"],
        tprCodigo: json["tpr_codigo"],
        tprNombre: json["tpr_nombre"],
        mprId: json["mpr_id"],
        mprCodigo: json["mpr_codigo"],
        mprNombre: json["mpr_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "pro_id": proId,
        "pro_codigo": proCodigo,
        "pro_nombre": proNombre,
        "pro_inventario": proInventario,
        "pro_precio": proPrecio,
        "tpr_id": tprId,
        "tpr_codigo": tprCodigo,
        "tpr_nombre": tprNombre,
        "mpr_id": mprId,
        "mpr_codigo": mprCodigo,
        "mpr_nombre": mprNombre,
      };

  Map<String, dynamic> toJsonWs() => {
        "codigo": proCodigo,
        "nombre": proNombre,
        "inventario": proInventario,
        "precio": proPrecio,
        "tipo": tprId,
        "marca": mprId,
        "empresa": eprId,
        "activo": true,
      };
}
