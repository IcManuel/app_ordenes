// To parse this JSON data, do
//
//     final vehiculo = vehiculoFromJson(jsonString);

import 'dart:convert';

Vehiculo vehiculoFromJson(String str) => Vehiculo.fromJson(json.decode(str));

String vehiculoToJson(Vehiculo data) => json.encode(data.toJson());

class Vehiculo {
  Vehiculo({
    required this.vehId,
    required this.modelo,
    required this.vehPlaca,
    required this.modId,
    this.vehAnio,
    this.vehColor,
    this.vehKilometraje,
    required this.marId,
    required this.marNombre,
    required this.modNombre,
  });

  int vehId;
  String modelo;
  int modId;
  int marId;
  String marNombre;
  String modNombre;
  String vehPlaca;
  int? vehAnio;
  String? vehColor;
  double? vehKilometraje;

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        vehId: json["veh_id"],
        modId: json["mod_id"],
        marId: json["mar_id"],
        marNombre: json["mar_nombre"],
        modNombre: json["mod_nombre"],
        modelo: json["modelo"],
        vehPlaca: json["veh_placa"],
        vehAnio: json["veh_anio"],
        vehColor: json["veh_color"],
        vehKilometraje: json["veh_kilometraje"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "veh_id": vehId,
        "modelo": modelo,
        "veh_placa": vehPlaca,
        "veh_anio": vehAnio,
        "veh_color": vehColor,
        "mod_id": modId,
        "veh_kilometraje": vehKilometraje,
      };
}
