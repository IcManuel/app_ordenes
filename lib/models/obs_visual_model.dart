// To parse this JSON data, do
//
//     final obsVisual = obsVisualFromJson(jsonString);

import 'dart:convert';

ObsVisual obsVisualFromJson(String str) => ObsVisual.fromJson(json.decode(str));

String obsVisualToJson(ObsVisual data) => json.encode(data.toJson());

class ObsVisual {
  ObsVisual({
    required this.obsId,
    required this.obsCodigo,
    required this.obsNombre,
    required this.check,
  });

  int obsId;
  String obsCodigo;
  String obsNombre;
  bool check;

  factory ObsVisual.fromJson(Map<String, dynamic> json) => ObsVisual(
        obsId: json["obs_id"],
        obsCodigo: json["obs_codigo"],
        obsNombre: json["obs_nombre"],
        check: json["check"],
      );

  Map<String, dynamic> toJson() => {
        "obs_id": obsId,
        "obs_codigo": obsCodigo,
        "obs_nombre": obsNombre,
        "check": check,
      };
}
