import 'dart:io';

import 'package:connectivity/connectivity.dart';

const String url = "https://ordenes.icreativa.com.ec/api/";
//const String url = "https://cold-facts-like-191-100-27-218.loca.lt/api/";

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
  print(tipo);
  print(identificacion);
  if (tipo == "1") {
    if (identificacion.trim().length == 10) {
      String digito_region = identificacion.substring(0, 2);
      if (int.parse(digito_region) >= 1 && int.parse(digito_region) <= 24) {
        String ultimo_digito = identificacion.substring(9, 10);
        int pares = int.parse(identificacion.substring(1, 2)) +
            int.parse(identificacion.substring(3, 4)) +
            int.parse(identificacion.substring(5, 6)) +
            int.parse(identificacion.substring(7, 8));

        int numero1 = int.parse(identificacion.substring(0, 1));
        numero1 = (numero1 * 2);
        numero1 = numero1 > 9 ? numero1 - 9 : numero1;

        int numero3 = int.parse(identificacion.substring(2, 3));
        numero3 = (numero3 * 2);
        numero3 = numero3 > 9 ? numero3 - 9 : numero3;

        int numero5 = int.parse(identificacion.substring(4, 5));
        numero5 = (numero5 * 2);
        numero5 = numero5 > 9 ? numero5 - 9 : numero5;

        int numero7 = int.parse(identificacion.substring(6, 7));
        numero7 = (numero7 * 2);
        numero7 = numero7 > 9 ? numero7 - 9 : numero7;

        int numero9 = int.parse(identificacion.substring(8, 9));
        numero9 = (numero9 * 2);
        numero9 = numero9 > 9 ? numero9 - 9 : numero9;

        int impares = numero1 + numero3 + numero5 + numero7 + numero9;

        int suma_total = (pares + impares);

        String primer_digito_suma = (suma_total).toString().substring(0, 1);

        int decena = (int.parse(primer_digito_suma) + 1) * 10;

        int digito_validador = decena - suma_total;

        digito_validador = digito_validador == 10 ? 0 : digito_validador;
        if (digito_validador.toString() != ultimo_digito) {
          res = false;
        }
      } else {
        res = false;
      }
    } else {
      res = false;
    }
  } else if (tipo == "2") {
    if (identificacion.trim().length != 13) {
      res = false;
    }
  } else if (tipo == "3") {
    if (identificacion.trim().isEmpty) {
      res = false;
    }
  }
  return res;
}
