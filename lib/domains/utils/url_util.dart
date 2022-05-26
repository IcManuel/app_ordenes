import 'dart:io';

import 'package:connectivity/connectivity.dart';

const String url = "https://ordenes.icreativa.com.ec/api/";
//const String url = "https://shaky-pets-smash-200-55-228-16.loca.lt/api/";

const String direccionImagen = url + 'foto/';

Future<bool> verificarConexion() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    try {
      final result = await InternetAddress.lookup('google.com').timeout(
        Duration(
          seconds: 2,
        ),
      );
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}

bool validarCedula(String tipo, String identificacion) {
  bool res = true;
  if (tipo == "1") {
  } else if (tipo == "2") {
    if (identificacion.trim().length != 13) {
      res = false;
    }
  }
  return res;
}
