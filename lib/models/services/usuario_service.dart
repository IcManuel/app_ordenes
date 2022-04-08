// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/requests/login_request.dart';
import 'package:app_ordenes/models/responses/usuario_reponse.dart';
import 'package:app_ordenes/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<UsuarioReponse> actualizarDatos(Usuario usu) async {
    try {
      var respuesta = await http
          .put(
              Uri.parse(
                "${url}usuario/",
              ),
              body: json.encode(
                usu.toJsonWs(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      if (respuesta.statusCode == 200) {
        var jsonData = json.decode(respuesta.body);
        UsuarioReponse res = UsuarioReponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return UsuarioReponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return UsuarioReponse(ok: false, msg: "Error al obtener información");
      }
    } catch (error) {
      return UsuarioReponse(
        ok: false,
        usuario: null,
        msg: "Error al comunicarse con el servidor",
      );
    }
  }

  static Future<UsuarioReponse> loginUsuario(LoginRequest datos) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}usuario/login",
              ),
              body: json.encode(
                datos.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 20,
            ),
          );
      // ignore: avoid_print
      if (respuesta.statusCode == 200 || respuesta.statusCode == 400) {
        var jsonData = json.decode(respuesta.body);
        UsuarioReponse res = UsuarioReponse.fromJson(jsonData);
        return res;
      } else if (respuesta.statusCode == 502) {
        return UsuarioReponse(
            ok: false,
            msg: "No se pudo lograr una comunicación con el servidor");
      } else {
        return UsuarioReponse(ok: false, msg: "Error al ejecutar ");
      }
    } catch (error) {
      return UsuarioReponse(
        ok: false,
        usuario: null,
        msg: "Error al ejecutar el WebService",
      );
    }
  }
}
