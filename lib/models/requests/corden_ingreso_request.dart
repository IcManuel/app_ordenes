// To parse this JSON data, do
//
//     final cordenRequest = cordenRequestFromJson(jsonString);

import 'dart:convert';

import 'package:app_ordenes/models/caracteristica_model.dart';
import 'package:app_ordenes/models/cliente_model.dart';
import 'package:app_ordenes/models/dorden_model.dart';
import 'package:app_ordenes/models/imagen_model.dart';
import 'package:app_ordenes/models/obs_visual_model.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';

CordenRequest cordenRequestFromJson(String str) =>
    CordenRequest.fromJson(json.decode(str));

String cordenRequestToJson(CordenRequest data) => json.encode(data.toJson());

class CordenRequest {
  CordenRequest({
    required this.eprId,
    required this.usuario,
    required this.obscliente,
    required this.obsvisual,
    required this.fecha,
    required this.observacion,
    required this.total,
    required this.estado,
    required this.descuento,
    this.vehiculoModel,
    this.clienteModel,
    this.detalles,
    this.visuales,
    this.imagenes,
    this.idOrden,
    this.caracteristicas,
  });

  int eprId;
  int usuario;
  String obscliente;
  String obsvisual;
  String fecha;
  String observacion;
  double total;
  int estado;
  int descuento;
  Vehiculo? vehiculoModel;
  Cliente? clienteModel;
  List<Dorden>? detalles;
  List<ObsVisual>? visuales;
  List<ImagenModel>? imagenes;
  List<Caracteristica>? caracteristicas;
  int? idOrden;

  factory CordenRequest.fromJson(Map<String, dynamic> json) => CordenRequest(
        eprId: json["epr_id"],
        usuario: json["usuario"],
        obscliente: json["obscliente"],
        obsvisual: json["obsvisual"],
        fecha: json["fecha"],
        observacion: json["observacion"],
        total: json["total"].toDouble(),
        estado: json["estado"],
        descuento: json["descuento"],
      );

  Map<String, dynamic> toJson() => {
        "empresa": eprId,
        "usuario": usuario,
        "obscliente": obscliente,
        "obsvisual": obsvisual,
        "fecha": fecha,
        "idOrden": idOrden,
        "observacion": observacion,
        "total": total,
        "estado": estado,
        "descuento": descuento,
        "vehiculoModel": vehiculoModel!.toJsonWs(),
        "clienteModel": clienteModel!.toJsonWs(),
        "detalles": List<dynamic>.from(detalles!.map((x) => x.toJson())),
        "visuales": List<dynamic>.from(visuales!.map((x) => x.toJsonWs())),
        "imagenes": List<dynamic>.from(imagenes!.map((x) => x.toJson())),
        "caracteristicas":
            List<dynamic>.from(caracteristicas!.map((x) => x.toJson())),
      };
}
