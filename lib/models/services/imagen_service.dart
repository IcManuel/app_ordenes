//CONSUMO DE WEB SERVICE
import 'dart:io';
import 'dart:convert';
import 'dart:io' as io;

import 'package:app_ordenes/domains/utils/url_util.dart' as urlF;
import 'package:app_ordenes/models/responses/imagen_response.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImagenService {
  static cabecera() {
    Map<String, String> userHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return userHeader;
  }

  static Future<bool> downloadImage(String img) async {
    var respuesta = await http
        .get(
          Uri.parse(
            urlF.direccionImagen + img,
          ),
          headers: cabecera(),
        )
        .timeout(
          const Duration(
            seconds: 3,
          ),
        );
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "imagenes");
    if (await Directory(path).exists() == false) {
      Directory(path).create().then((Directory directory) {});
    }
    var filePathAndName = join(path, img);
    File file2 = File(filePathAndName); // <-- 2
    file2.writeAsBytesSync(
      respuesta.bodyBytes,
      flush: true,
      mode: FileMode.write,
    );

    return true;
  }

  static Future<String> uploadImage(String path) async {
    try {
      String urlWs = urlF.url + "imagen";
      var request = http.MultipartRequest('POST', Uri.parse(urlWs));
      request.files.add(await http.MultipartFile.fromPath('file', path));
      var res = await request.send();
      String dato = await res.stream.bytesToString();
      ImagenResponse respuesta = ImagenResponse.fromJson(json.decode(dato));
      if (respuesta.ok) {
        return respuesta.nombre!;
      } else {
        return "";
      }
    } catch (error) {
      return "";
    }
  }
}


//WEB SERVICE