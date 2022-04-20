import 'dart:convert';

ListaCaracteristica listaCaracteristicaFromJson(String str) =>
    ListaCaracteristica.fromJson(json.decode(str));

String listaCaracteristicaToJson(ListaCaracteristica data) =>
    json.encode(data.toJson());

class ListaCaracteristica {
  ListaCaracteristica({
    required this.calId,
    required this.calNombre,
  });

  int calId;
  String calNombre;

  factory ListaCaracteristica.fromJson(Map<String, dynamic> json) =>
      ListaCaracteristica(
        calId: json["cal_id"],
        calNombre: json["cal_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "cal_id": calId,
        "cal_nombre": calNombre,
      };
}
