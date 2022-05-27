import 'dart:convert';

import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/cliente_model.dart';
import 'package:app_ordenes/models/requests/cliente_request.dart';
import 'package:app_ordenes/models/requests/producto_request.dart';
import 'package:app_ordenes/models/responses/cliente_response.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClienteService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<List<Cliente>> obtenerClientesLista(
      ProductoRequest p, BuildContext context) async {
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
        if (res.clientes!.isEmpty) {
          Fluttertoast.showToast(
              msg: 'No se han encontrado clientes',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
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

  static Future<MarcaResponse> crearCliente(Cliente cli) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}cliente",
              ),
              body: json.encode(
                cli.toJsonWs(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 15,
            ),
          );
      print(respuesta.statusCode);
      if (respuesta.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(respuesta.body);
        print(jsonData.toString());
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
      return MarcaResponse(ok: false, msg: "Error al ejecutar webservice");
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
              seconds: 10,
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
