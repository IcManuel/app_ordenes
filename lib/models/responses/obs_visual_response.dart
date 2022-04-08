import 'dart:convert';

import 'package:app_ordenes/models/obs_visual_model.dart';

ObsVisualResponse obsVisualResponseFromJson(String str) =>
    ObsVisualResponse.fromJson(json.decode(str));

String obsVisualResponseToJson(ObsVisualResponse data) =>
    json.encode(data.toJson());

class ObsVisualResponse {
  ObsVisualResponse({
    required this.ok,
    this.observaciones,
    this.msg,
  });

  bool ok;
  List<ObsVisual>? observaciones;
  String? msg;

  factory ObsVisualResponse.fromJson(Map<String, dynamic> json) =>
      ObsVisualResponse(
        ok: json["ok"],
        msg: json["msg"],
        observaciones: (json["observaciones"]
            ? List<ObsVisual>.from(
                json["observaciones"].map((x) => ObsVisual.fromJson(x)))
            : null),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "observaciones":
            List<ObsVisual>.from(observaciones!.map((x) => x.toJson())),
      };
}
