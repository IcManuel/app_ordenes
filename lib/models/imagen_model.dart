// To parse this JSON data, do
//
//     final imagenModel = imagenModelFromJson(jsonString);

import 'dart:convert';

ImagenModel imagenModelFromJson(String str) =>
    ImagenModel.fromJson(json.decode(str));

String imagenModelToJson(ImagenModel data) => json.encode(data.toJson());

class ImagenModel {
  ImagenModel({
    required this.tipo,
    required this.imagen,
  });

  int tipo;
  String imagen;

  factory ImagenModel.fromJson(Map<String, dynamic> json) => ImagenModel(
        tipo: json["tipo"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "imagen": imagen,
      };
}
