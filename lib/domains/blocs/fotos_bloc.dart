import 'package:app_ordenes/models/foto_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotosBloc extends ChangeNotifier {
  List<FotoModel> _fotos = [];
  List<FotoModel> _fotosEntrega = [];
  FotoModel _fotoSelect = FotoModel(imagen: XFile(''), nombre: "");

  List<FotoModel> get fotos => _fotos;
  List<FotoModel> get fotosEntrega => _fotosEntrega;
  FotoModel get fotoSelect => _fotoSelect;

  void limpiarDatos() {
    _fotos = [];
    _fotosEntrega = [];
  }

  set fotoSelect(FotoModel x) {
    _fotoSelect = x;
    notifyListeners();
  }

  set fotos(List<FotoModel> f) {
    _fotos = f;
    notifyListeners();
  }

  set fotosEntrega(List<FotoModel> f) {
    _fotosEntrega = f;
    notifyListeners();
  }

  void anadirFotos(List<XFile> pickedFileList, int tipo) {
    print('Datos ' + pickedFileList.length.toString());
    List<FotoModel> fotos = [];
    var pos = 1;
    for (XFile f in pickedFileList) {
      int i = f.name.lastIndexOf('.');
      String ext = f.name.substring(i, f.name.length);
      print(ext);
      fotos.add(FotoModel(
        imagen: f,
        nombre: 'img' + pos.toString() + ext,
      ));
      pos++;
    }
    tipo == 1 ? _fotos.addAll(fotos) : _fotosEntrega.addAll(fotos);
    notifyListeners();
  }

  void anadirFotoSimple(XFile pickedFileList, String nombre, int tipo) {
    tipo == 1
        ? _fotos.add(FotoModel(
            imagen: pickedFileList,
            nombre: nombre,
          ))
        : _fotosEntrega.add(FotoModel(
            imagen: pickedFileList,
            nombre: nombre,
          ));
    notifyListeners();
  }

  void eliminarFoto(int index, int tipo) {
    tipo == 1 ? _fotos.removeAt(index) : _fotosEntrega.removeAt(index);
    notifyListeners();
  }

  void setearNombre(int idx, String texto, int tipo) {
    tipo == 1 ? _fotos[idx].nombre = texto : _fotosEntrega[idx].nombre = texto;
    notifyListeners();
  }
}
