import 'dart:convert';

import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/utils/file_converter.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/requests/pdf_request.dart';
import 'package:provider/provider.dart';
import 'package:app_ordenes/models/requests/corden_ingreso_request.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
import 'package:app_ordenes/models/responses/pdf_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrdenService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<void> obtenerPdf(BuildContext context, PdfRequest marca) async {
    try {
      var response = await http
          .post(
            Uri.parse("${url}orden/pdf"),
            body: json.encode(
              marca.toJson(),
            ),
            headers: cabecera(),
          )
          .timeout(const Duration(milliseconds: 30000));

      var jsonData = json.decode(response.body);
      print('jsonData $jsonData');
      PdfResponse respuesta = PdfResponse.fromJson(jsonData);
      String? urlPdf = await FileConverter.createFileFromString(
          respuesta.base64, respuesta.nombre);
      print('urlPdf --> $urlPdf');
      if (urlPdf != null) {
        final blocProforma = Provider.of<OrdenBloc>(context, listen: false);
        blocProforma.pdfArchivo = urlPdf;
        blocProforma.pdfNombre = respuesta.nombre;
        print('urlPdf2 --> $urlPdf');
      } else {
        print('urlPdf es nulo');
      }
    } catch (err) {
      print(err);
    }
  }

  static Future<MarcaResponse> insertarOrden(CordenRequest marca) async {
    try {
      var respuesta = await http
          .post(
              Uri.parse(
                "${url}orden/",
              ),
              body: json.encode(
                marca.toJson(),
              ),
              headers: cabecera())
          .timeout(
            const Duration(
              seconds: 30,
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
