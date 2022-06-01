// To parse this JSON data, do
//
//     final orden = ordenFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/cliente_model.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';

Orden ordenFromJson(String str) => Orden.fromJson(json.decode(str));

String ordenToJson(Orden data) => json.encode(data.toJson());

class Orden {
  Orden({
    required this.corId,
    required this.eprId,
    required this.corObsCliente,
    required this.corObsVisual,
    required this.corFecha,
    required this.corObservacion,
    required this.corNumero,
    required this.corTotal,
    required this.corEstado,
    required this.cliente,
    required this.vehiculo,
    required this.usuario,
  });

  int corId;
  int eprId;
  String corObsCliente;
  String corObsVisual;
  String corFecha;
  String corObservacion;
  int corNumero;
  double corTotal;
  int corEstado;
  Cliente cliente;
  Vehiculo vehiculo;
  String usuario;

  factory Orden.fromJson(Map<String, dynamic> json) => Orden(
        corId: json["cor_id"],
        eprId: json["epr_id"],
        corObsCliente: json["cor_obs_cliente"],
        corObsVisual: json["cor_obs_visual"],
        corFecha: json["cor_fecha"],
        corObservacion: json["cor_observacion"],
        corNumero: json["cor_numero"],
        corTotal: json["cor_total"].toDouble(),
        corEstado: json["cor_estado"],
        cliente: Cliente.fromJson(json["cliente"]),
        vehiculo: Vehiculo.fromJson(
          json["vehiculo"],
        ),
        usuario: json["usuario"],
      );

  Map<String, dynamic> toJson() => {
        "cor_id": corId,
        "epr_id": eprId,
        "cor_obs_cliente": corObsCliente,
        "cor_obs_visual": corObsVisual,
        "cor_fecha": corFecha,
        "cor_observacion": corObservacion,
        "cor_numero": corNumero,
        "cor_total": corTotal,
        "cliente": cliente.toJson(),
        "vehiculo": vehiculo.toJson(),
        "usuario": usuario,
      };
}
