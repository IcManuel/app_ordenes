import 'dart:convert';

import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/requests/vehiculo_request.dart';
import 'package:app_ordenes/models/responses/vehiculo_response.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';
import 'package:http/http.dart' as http;

class VehiculoService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<List<Vehiculo>> obtenerVehiculosPorPlaca(
      VehiculoRequest p) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}vehiculo/filtro",
              ),
              body: json.encode(
                p.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        print(jsonData);
        VehiculoResponse res = VehiculoResponse.fromJson(jsonData);
        return res.vehiculos!;
      } else if (respuesta.statusCode == 502) {
        return [];
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  static Future<VehiculoResponse> buscarVehiculo(VehiculoRequest cli) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}vehiculo/buscar",
              ),
              body: json.encode(
                cli.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 10,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        VehiculoResponse res = VehiculoResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return VehiculoResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return VehiculoResponse(ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return VehiculoResponse(
        ok: false,
        vehiculo: null,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<VehiculoResponse> obtenerVehiculosPorCliente(cli) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}vehiculo/$cli",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        print(jsonData);
        VehiculoResponse res = VehiculoResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return VehiculoResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return VehiculoResponse(ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return VehiculoResponse(
        ok: false,
        vehiculo: null,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }
}
