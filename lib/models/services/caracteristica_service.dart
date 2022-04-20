import 'dart:convert';

import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/responses/caracteristica_response.dart';
import 'package:http/http.dart' as http;

class CaracteristicaService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<CaracteristicaResponse> buscarCaracteristicas(empresa) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}caracteristica/$empresa",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        CaracteristicaResponse res = CaracteristicaResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return CaracteristicaResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return CaracteristicaResponse(
            ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return CaracteristicaResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<CaracteristicaResponse> buscarListaCaracteristicas(id) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}caracteristica/lista/$id",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        CaracteristicaResponse res = CaracteristicaResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return CaracteristicaResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return CaracteristicaResponse(
            ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return CaracteristicaResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<CaracteristicaResponse> buscarCaracteristicasVehiculo(
      vehiculo) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}caracteristica/vehiculo/$vehiculo",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        CaracteristicaResponse res = CaracteristicaResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return CaracteristicaResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return CaracteristicaResponse(
            ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return CaracteristicaResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<CaracteristicaResponse> buscarCaracteristicasDetalleVehiculo(
      vehiculo) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}caracteristica/detalle/$vehiculo",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        CaracteristicaResponse res = CaracteristicaResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return CaracteristicaResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return CaracteristicaResponse(
            ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return CaracteristicaResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }
}
