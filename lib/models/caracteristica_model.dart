// To parse this JSON data, do
//
//     final caracteristica = caracteristicaFromJson(jsonString);

import 'dart:convert';

Caracteristica caracteristicaFromJson(String str) =>
    Caracteristica.fromJson(json.decode(str));

String caracteristicaToJson(Caracteristica data) => json.encode(data.toJson());

class Caracteristica {
  Caracteristica({
    required this.carId,
    required this.carNombre,
    required this.carTipo,
    required this.carObligatorio,
    this.valor,
  });

  int carId;
  String carNombre;
  int carTipo;
  bool carObligatorio;
  String? valor;

  factory Caracteristica.fromJson(Map<String, dynamic> json) => Caracteristica(
        carId: json["car_id"],
        carNombre: json["car_nombre"],
        carTipo: json["car_tipo"],
        carObligatorio: json["car_obligatorio"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": carId,
        "car_nombre": carNombre,
        "car_tipo": carTipo,
        "car_obligatorio": carObligatorio,
        "valor": valor,
      };

  Map<String, dynamic> toJsonWs() => {
        "id": carId,
        "valor": valor,
      };
}
