import 'dart:convert';

import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/cliente_model.dart';
import 'package:app_ordenes/models/requests/cliente_request.dart';
import 'package:app_ordenes/models/requests/producto_request.dart';
import 'package:app_ordenes/models/responses/cliente_response.dart';
import 'package:http/http.dart' as http;

class ClienteService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<List<Cliente>> obtenerClientesLista(ProductoRequest p) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}cliente/filtro",
              ),
              body: json.encode(
                p.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 100,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        ClienteResponse res = ClienteResponse.fromJson(jsonData);
        return res.clientes!;
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

  static Future<ClienteResponse> buscarCliente(ClienteRequest cli) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}cliente/buscar",
              ),
              body: json.encode(
                cli.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        ClienteResponse res = ClienteResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return ClienteResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return ClienteResponse(ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      return ClienteResponse(
        ok: false,
        cliente: null,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }
}
