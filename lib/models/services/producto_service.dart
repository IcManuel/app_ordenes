import 'dart:convert';

import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/producto_model.dart';
import 'package:app_ordenes/models/requests/producto_request.dart';
import 'package:app_ordenes/models/responses/producto_response.dart';
import 'package:http/http.dart' as http;

class ProductoService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<ProductoResponse> obtenerProductos(ProductoRequest p) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}producto/buscar",
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
        ProductoResponse res = ProductoResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return ProductoResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return ProductoResponse(ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return ProductoResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<List<Producto>> obtenerProductosLista(ProductoRequest p) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}producto/buscar",
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
        ProductoResponse res = ProductoResponse.fromJson(jsonData);
        return res.productos!;
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
}
