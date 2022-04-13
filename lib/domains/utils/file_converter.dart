import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FileConverter {
  static Future<String?> createFileFromString(
      String data, String nombre) async {
    try {
      Uint8List bytes = base64.decode(data);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File("$dir/" + nombre);
      await file.writeAsBytes(bytes);
      return file.path;
    } on Exception catch (error) {
      print('aqui esta el error');
      print(error);
      return null;
    }
  }
}
