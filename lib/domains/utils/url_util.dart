import 'dart:io';

import 'package:connectivity/connectivity.dart';

//const String url = "https://ordenes.icreativa.com.ec/api/";
const String url = "https://heavy-rockets-vanish-191-100-27-218.loca.lt/api/";

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
