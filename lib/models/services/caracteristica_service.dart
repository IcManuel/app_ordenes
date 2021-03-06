import 'dart:convert';

import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/lista_caracteristica_model.dart';
import 'package:app_ordenes/models/requests/vehiculo_car_request.dart';
import 'package:app_ordenes/models/responses/caracteristica_response.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
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
                "${url}caracteristica/activas/$empresa",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 10,
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
              seconds: 10,
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

  static Future<MarcaResponse> insertarLista(ListaCaracteristica marca) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}caracteristica/lista",
              ),
              body: json.encode(
                marca.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 10,
            ),
          );
      if (respuesta.statusCode == 200 || respuesta.statusCode == 400) {
        var jsonData = json.decode(respuesta.body);
        MarcaResponse res = MarcaResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return MarcaResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return MarcaResponse(ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return MarcaResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<CaracteristicaResponse> buscarCaracteristicasVehiculo(
      vehiculo) async {
    try {
      VehiculoCarRequest marca =
          VehiculoCarRequest(empresa: Preferencias().empresa, id: vehiculo);
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}caracteristica/vehiculo",
              ),
              body: json.encode(
                marca.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 10,
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
      VehiculoCarRequest marca =
          VehiculoCarRequest(empresa: Preferencias().empresa, id: vehiculo);
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}caracteristica/detalle",
              ),
              body: json.encode(
                marca.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 10,
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
