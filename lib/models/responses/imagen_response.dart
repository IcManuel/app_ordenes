// To parse this JSON data, do
//
//     final imagenResponse = imagenResponseFromJson(jsonString);

import 'dart:convert';

ImagenResponse imagenResponseFromJson(String str) =>
    ImagenResponse.fromJson(json.decode(str));

String imagenResponseToJson(ImagenResponse data) => json.encode(data.toJson());

class ImagenResponse {
  ImagenResponse({
    required this.ok,
    this.nombre,
  });

  bool ok;
  String? nombre;

  factory ImagenResponse.fromJson(Map<String, dynamic> json) => ImagenResponse(
        ok: json["ok"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "nombre": nombre,
      };
}
