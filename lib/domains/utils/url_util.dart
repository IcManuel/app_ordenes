import 'package:connectivity/connectivity.dart';

//const String url = "https://ordenes.icreativa.com.ec/api/";
const String url = "https://light-quail-90.loca.lt/api/";
const String direccionImagen = url + 'foto/';
verificarConexion() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
