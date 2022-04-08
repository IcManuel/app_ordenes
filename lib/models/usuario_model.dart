// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    required this.usuId,
    required this.eprId,
    this.eprActivo = true,
    required this.usuAlias,
    required this.usuContrasena,
    required this.usuRol,
    required this.usuActivo,
    required this.usuCorreo,
    required this.usuNombres,
    required this.usuApellidos,
  });

  int usuId;
  int eprId;
  bool? eprActivo;
  String usuAlias;
  String usuContrasena;
  int usuRol;
  bool usuActivo;
  String usuCorreo;
  String usuNombres;
  String usuApellidos;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuId: json["usu_id"],
        eprId: json["epr_id"],
        eprActivo: json["epr_activo"],
        usuAlias: json["usu_alias"],
        usuContrasena: json["usu_contrasena"],
        usuRol: json["usu_rol"],
        usuActivo: json["usu_activo"],
        usuCorreo: json["usu_correo"],
        usuNombres: json["usu_nombres"],
        usuApellidos: json["usu_apellidos"],
      );

  Map<String, dynamic> toJson() => {
        "usu_id": usuId,
        "epr_id": eprId,
        "usu_alias": usuAlias,
        "usu_contrasena": usuContrasena,
        "usu_rol": usuRol,
        "usu_activo": usuActivo,
        "usu_correo": usuCorreo,
        "usu_nombres": usuNombres,
        "usu_apellidos": usuApellidos,
        "epr_activo": eprActivo
      };
  Map<String, dynamic> toJsonWs() => {
        "id": usuId,
        "empresa": eprId,
        "alias": usuAlias,
        "contrasena": usuContrasena,
        "rol": usuRol,
        "activo": usuActivo,
        "correo": usuCorreo,
        "nombres": usuNombres,
        "apellidos": usuApellidos,
      };
}