import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/obs_visual_model.dart';
import 'package:app_ordenes/models/orden_model.dart';
import 'package:app_ordenes/models/responses/obs_visual_response.dart';
import 'package:app_ordenes/models/services/obs_visual_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VisualBloc extends ChangeNotifier {
  bool _cargando = false;
  List<ObsVisual> _lista = [];
  String _obsVisual = '';
  final TextEditingController _ctrlObs = TextEditingController();

  bool get cargando => _cargando;
  List<ObsVisual> get lista => _lista;
  String get obsVisual => _obsVisual;
  void cambioCheck(int index, bool? e) {
    _lista[index].check = e!;
    notifyListeners();
  }

  void cargarVisuales(int empresa) async {
    _cargando = true;
    final conect = await verificarConexion();
    if (conect) {
      ObsVisualResponse res = await ObsVisualService.buscarVisuales(empresa);
      if (res.ok == true) {
        _lista = res.observaciones!;
        notifyListeners();
      } else {
        _cargando = false;
        Fluttertoast.showToast(
            msg: "No se pudieron cargar visuales, error => " + res.msg!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      _cargando = false;
      Fluttertoast.showToast(
          msg: "No hay conexión para cargar visuales...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void cargarVisualesOrden(Orden or) async {
    _obsVisual = or.corObsVisual;
    _ctrlObs.text = _obsVisual;
    _cargando = true;
    final conect = await verificarConexion();
    if (conect) {
      ObsVisualResponse res =
          await ObsVisualService.buscarVisualesOrden(or.corId);
      if (res.ok == true) {
        _lista = res.observaciones!;
        notifyListeners();
      } else {
        _cargando = false;
        Fluttertoast.showToast(
            msg: "No se pudieron cargar visuales, error => " + res.msg!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      _cargando = false;
      Fluttertoast.showToast(
          msg: "No hay conexión para cargar visuales...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void limpiarDatos() {
    _ctrlObs.text = '';
    _obsVisual = '';
    _lista = [];
    notifyListeners();
  }

  set cargando(bool b) {
    _cargando = b;
    notifyListeners();
  }

  set lista(List<ObsVisual> l) {
    _lista = l;
    notifyListeners();
  }

  set obsVisual(String o) {
    _obsVisual = o;
    notifyListeners();
  }

  TextEditingController get ctrlObs {
    return _ctrlObs;
  }
}
