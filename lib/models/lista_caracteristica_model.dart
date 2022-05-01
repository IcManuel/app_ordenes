import 'dart:convert';

ListaCaracteristica listaCaracteristicaFromJson(String str) =>
    ListaCaracteristica.fromJson(json.decode(str));

String listaCaracteristicaToJson(ListaCaracteristica data) =>
    json.encode(data.toJson());

class ListaCaracteristica {
  ListaCaracteristica({
    required this.calId,
    required this.calNombre,
    this.carId,
    this.eprId,
  });

  int calId;
  String calNombre;
  int? carId;
  int? eprId;

  factory ListaCaracteristica.fromJson(Map<String, dynamic> json) =>
      ListaCaracteristica(
        calId: json["cal_id"],
        calNombre: json["cal_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "cal_nombre": calNombre,
        "car_id": carId,
        "empresa": eprId,
      };
}
