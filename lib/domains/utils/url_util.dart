import 'package:connectivity/connectivity.dart';

const String url = "https://bad-rat-14.loca.lt/api/";
//final String url = "https://6a82-190-63-235-202.ngrok.io/api/";
const String direccionImagen = url + 'foto/';
verificarConexion() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
