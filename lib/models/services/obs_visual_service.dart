import 'dart:convert';

import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/responses/obs_visual_response.dart';
import 'package:http/http.dart' as http;

class ObsVisualService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<ObsVisualResponse> buscarVisuales(empresa) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}observacion/seleccionar/$empresa",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        ObsVisualResponse res = ObsVisualResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return ObsVisualResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return ObsVisualResponse(
            ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return ObsVisualResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<ObsVisualResponse> buscarVisualesOrden(id) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}observacion/seleccionarorden/$id",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        ObsVisualResponse res = ObsVisualResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return ObsVisualResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return ObsVisualResponse(
            ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return ObsVisualResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }
}
