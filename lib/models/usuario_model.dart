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
    this.palabraClave,
    this.identificador,
    required this.pymes,
    required this.validarStock,
    this.vehPorDefecto,
    this.impresionTermica,
    this.validarCedula = false,
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
  String? palabraClave;
  String? identificador;
  bool? pymes;
  bool? validarStock;
  String? vehPorDefecto;
  bool? impresionTermica;
  bool? validarCedula;

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
        palabraClave: json["epr_palabra_clave"] ?? '',
        identificador: json["epr_identificador"] ?? '',
        pymes: json["epr_pymes"] ?? false,
        validarStock: json["epr_validar_stock"] ?? false,
        vehPorDefecto: json["veh_id_pordefecto"] ?? '',
        impresionTermica: json["epr_impresion_termica"] ?? false,
        validarCedula: json["epr_validar_cedula"] ?? false,
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
        "epr_activo": eprActivo,
        "epr_palabra_clave": palabraClave,
        "epr_identificador": identificador,
        "epr_pymes": pymes,
        "epr_validar_stock": validarStock ?? false,
        "veh_id_pordefecto": vehPorDefecto ?? '',
        "epr_impresion_termica": impresionTermica ?? false,
        "epr_validar_cedula": validarCedula ?? false,
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
