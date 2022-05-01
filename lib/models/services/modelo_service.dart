import 'dart:convert';

import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/marca_model.dart';
import 'package:app_ordenes/models/marca_producto_model.dart';
import 'package:app_ordenes/models/modelo_model.dart';
import 'package:app_ordenes/models/producto_model.dart';
import 'package:app_ordenes/models/requests/modelo_request.dart';
import 'package:app_ordenes/models/requests/tipo_producto_request.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
import 'package:app_ordenes/models/responses/modelo_response.dart';
import 'package:app_ordenes/models/tipo_producto_model.dart';
import 'package:http/http.dart' as http;

class ModeloService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<ModeloResponse> buscarModelos(ModeloRequest cli) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}modelo/buscar",
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
        ModeloResponse res = ModeloResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return ModeloResponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return ModeloResponse(ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      print(error);
      return ModeloResponse(
        ok: false,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<MarcaResponse> buscarMarcas(empresa) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}marca/$empresa",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
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

  static Future<MarcaResponse> buscarTipoProductos(
      TipoProductoRequest cli) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}tipo_producto/buscar",
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

  static Future<MarcaResponse> buscarMarcaProductos(empresa) async {
    try {
      var respuesta = await http
          .get(
              Uri.parse(
                "${url}marca_producto/$empresa",
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
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

  static Future<MarcaResponse> insertarMarca(Marca marca) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}marca/",
              ),
              body: json.encode(
                marca.toJsonWs(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
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

  static Future<MarcaResponse> insertarTipo(TipoProducto marca) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}tipo_producto/",
              ),
              body: json.encode(
                marca.toJsonWs(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
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

  static Future<MarcaResponse> insertarMarcaProducto(
      MarcaProducto marca) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}marca_producto/",
              ),
              body: json.encode(
                marca.toJsonWs(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
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

  static Future<MarcaResponse> insertarProducto(Producto marca) async {
    try {
      print("${url}producto/");
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}producto/",
              ),
              body: json.encode(
                marca.toJsonWs(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      print(respuesta.statusCode);
      if (respuesta.statusCode == 200 || respuesta.statusCode == 400) {
        var jsonData = json.decode(respuesta.body);

        MarcaResponse res = MarcaResponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502 || respuesta.statusCode == 404) {
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

  static Future<MarcaResponse> insertarModelo(Modelo marca) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}modelo/",
              ),
              body: json.encode(
                marca.toJsonWs(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
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
}
