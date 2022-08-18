import 'dart:convert';

import 'package:app_ordenes/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferencias {
  static final Preferencias _instancia = Preferencias._internal();

  factory Preferencias() {
    return _instancia;
  }

  Preferencias._internal();
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //get y sets
  String get token {
    return _prefs.getString('token') ?? "";
  }

  set token(String valor) {
    _prefs.setString('token', valor);
  }

  String get impresora {
    return _prefs.getString('impresora') ?? "";
  }

  set impresora(String valor) {
    _prefs.setString('impresora', valor);
  }

  String get impresoraNOmbre {
    return _prefs.getString('impresoraNombre') ?? "";
  }

  set impresoraNombre(String valor) {
    _prefs.setString('impresoraNombre', valor);
  }

  int get empresa {
    return _prefs.getInt('empresa') ?? -1;
  }

  set empresa(int valor) {
    _prefs.setInt('empresa', valor);
  }

  String get actDatos {
    return _prefs.getString('actDatos') ?? "";
  }

  set actDatos(String valor) {
    _prefs.setString('actDatos', valor);
  }

  String get versionApp {
    return _prefs.getString('versionApp') ?? "";
  }

  set versionApp(String valor) {
    _prefs.setString('versionApp', valor);
  }

  set usuario(Usuario? usuario) {
    if (usuario != null) {
      _prefs.setString('usuario', jsonEncode(usuario.toJson()));
    } else {
      _prefs.setString('usuario', jsonEncode(''));
    }
  }

  Usuario? get usuario {
    String usuarioString = _prefs.getString('usuario') ?? '';
    if (usuarioString.isNotEmpty) {
      Map empleadoMap = jsonDecode(usuarioString);
      Usuario usuario = Usuario.fromJson(empleadoMap.cast<String, dynamic>());
      return usuario;
    } else {
      return null;
    }
  }
}
