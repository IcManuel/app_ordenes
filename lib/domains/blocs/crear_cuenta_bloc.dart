import 'package:app_ordenes/models/caracteristica_model.dart';
import 'package:app_ordenes/models/foto_model.dart';
import 'package:app_ordenes/models/lista_caracteristica_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CrearCuentaBloc extends ChangeNotifier {
  int _paso = 1;
  String _nombre = '';
  String _direccion = '';
  bool modificar = false;
  int index = 0;
  String _palabraClave = '';
  String _identificador = '';
  bool _validarIdentificacion = false;
  FotoModel _logo = FotoModel(imagen: XFile(''), nombre: '');
  TextEditingController _ctrlNombre = new TextEditingController();
  TextEditingController _ctrlNombreLista = new TextEditingController();
  TextEditingController _ctrlDireccion = new TextEditingController();
  TextEditingController _ctrlPalabraClave = new TextEditingController();
  TextEditingController _ctrlIdentificador = new TextEditingController();
  List<Caracteristica> _caracteristicas = [];
  String _titulo = 'DATOS GENERALES';
  String _nombreLista = '';
  Caracteristica _caracteristica = Caracteristica(
    carId: -1,
    carNombre: '',
    carTipo: 1,
    carObligatorio: false,
    carSeleccionadble: false,
  );
  List<ListaCaracteristica> _detalles = [];

  String get nombre => _nombre;
  String get direccion => _direccion;
  String get palabraClave => _palabraClave;
  String get identificador => _identificador;
  bool get validarIdentificacion => _validarIdentificacion;
  int get paso => _paso;
  FotoModel get logo => _logo;
  TextEditingController get ctrlNombre => _ctrlNombre;
  TextEditingController get ctrlNombreLista => _ctrlNombreLista;
  TextEditingController get ctrlDireccion => _ctrlDireccion;
  TextEditingController get ctrlPalabraClae => _ctrlPalabraClave;
  TextEditingController get ctrlIdentificador => _ctrlIdentificador;
  List<Caracteristica> get caracteristicas => _caracteristicas;
  String get titulo => _titulo;
  Caracteristica get caracteristica => _caracteristica;
  List<ListaCaracteristica> get detalles => _detalles;
  String get nombreLista => _nombreLista;

  set nombreLista(String n) {
    _nombreLista = n;
    notifyListeners();
  }

  set detalles(List<ListaCaracteristica> c) {
    _detalles = c;
    notifyListeners();
  }

  set caracteristica(Caracteristica c) {
    _caracteristica = c;
    notifyListeners();
  }

  set titulo(String t) {
    _titulo = t;
    notifyListeners();
  }

  set logo(FotoModel f) {
    _logo = f;
    notifyListeners();
  }

  set paso(int i) {
    _paso = i;
    notifyListeners();
  }

  set nombre(String n) {
    _nombre = n;
    notifyListeners();
  }

  set caracteristicas(List<Caracteristica> c) {
    _caracteristicas = c;
    notifyListeners();
  }

  set direccion(String n) {
    _direccion = n;
    notifyListeners();
  }

  set palabraClave(String n) {
    _palabraClave = n;
    notifyListeners();
  }

  set identificador(String n) {
    _identificador = n;
    notifyListeners();
  }

  set validarIdentificacion(bool n) {
    _validarIdentificacion = n;
    notifyListeners();
  }

  void borrarCaracteristica(int car) {
    _caracteristicas.removeAt(car);
    notifyListeners();
  }

  void agregarCaracteristica(context) {
    if (_caracteristica.carNombre.trim().isNotEmpty) {
      if (!modificar) {
        bool existe = false;
        for (Caracteristica ca in _caracteristicas) {
          if (ca.carNombre.trim() == _caracteristica.carNombre.trim()) {
            existe = true;
            break;
          }
        }
        if (!existe) {
          bool pasa = true;
          if (_caracteristica.carSeleccionadble) {
            if (_detalles.isEmpty) {
              pasa = false;
            }
          }
          if (pasa) {
            _caracteristica.detalles = _detalles;
            _caracteristica.carNombre = _caracteristica.carNombre.toUpperCase();
            _caracteristicas.add(_caracteristica);

            _caracteristica = Caracteristica(
              carId: -1,
              carNombre: '',
              carTipo: 1,
              carObligatorio: false,
              carSeleccionadble: false,
            );
            _detalles = [];
            notifyListeners();
            Navigator.pop(context);
          } else {
            Fluttertoast.showToast(
              msg: 'Debe ingresar al menos un detalle',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'El nombre ingresado ya existe',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        bool existe = false;
        int i = 0;
        for (Caracteristica ca in _caracteristicas) {
          if (i != index) {
            if (ca.carNombre.trim() == _caracteristica.carNombre.trim()) {
              existe = true;
              break;
            }
          }
          i++;
        }
        if (!existe) {
          bool pasa = true;
          if (_caracteristica.carSeleccionadble) {
            if (_detalles.isEmpty) {
              pasa = false;
            }
          }
          if (pasa) {
            _caracteristica.detalles = _detalles;
            _caracteristica.carNombre = _caracteristica.carNombre.toUpperCase();
            _caracteristicas.removeAt(index);
            _caracteristicas.add(_caracteristica);

            _caracteristica = Caracteristica(
              carId: -1,
              carNombre: '',
              carTipo: 1,
              carObligatorio: false,
              carSeleccionadble: false,
            );
            _detalles = [];
            notifyListeners();
            Navigator.pop(context);
          } else {
            Fluttertoast.showToast(
              msg: 'Debe ingresar al menos un detalle',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'El nombre ingresado ya existe',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Debe ingresar el nombre',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void borrarDetalle(ListaCaracteristica d) {
    _detalles.remove(d);
    notifyListeners();
  }

  void nuevoDetalle() {
    if (_nombreLista.trim().isNotEmpty) {
      bool existe = false;
      for (ListaCaracteristica d in _detalles) {
        if (d.calNombre.trim() == _nombreLista.trim()) {
          existe = true;
          break;
        }
      }
      if (!existe) {
        _detalles.add(
            ListaCaracteristica(calId: -1, calNombre: _nombreLista.trim()));
        _nombreLista = '';
        _ctrlNombreLista.text = '';
        notifyListeners();
      } else {
        Fluttertoast.showToast(
          msg: 'El nombre ingresado ya existe',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Debe ingresar el nombre',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void seleccionarLogo() async {
    final ImagePicker _picker = ImagePicker();
    try {
      XFile? x = await _picker.pickImage(
        imageQuality: 25,
        source: ImageSource.gallery,
      );
      if (x != null) {
        _logo = FotoModel(imagen: x, nombre: 'LOGO.png');
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void volver() {
    if (_paso == 2) {
      _titulo = 'DATOS GENERALES';
      _paso = 1;
      notifyListeners();
    } else if (_paso == 3) {
      _titulo = 'CARACTERISTICAS';
      _paso = 2;
      notifyListeners();
    }
  }

  void siguiente() {
    if (_paso == 1) {
      if (_nombre.trim().isNotEmpty) {
        if (_direccion.trim().isNotEmpty) {
          if (_palabraClave.trim().isNotEmpty) {
            if (_identificador.trim().isNotEmpty) {
              _paso = 2;
              _titulo = 'CARACTERISTICAS';
              notifyListeners();
            } else {
              Fluttertoast.showToast(
                msg: 'Debe ingresar el identificador',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          } else {
            Fluttertoast.showToast(
              msg: 'Debe ingresar la palabra clave',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Debe ingresar la dirección de la empresa',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Debe ingresar el nombre de la empresa',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else if (paso == 2) {
      if (_caracteristicas.isNotEmpty) {
        _paso = 3;
        notifyListeners();
      } else {
        Fluttertoast.showToast(
          msg: 'Debe ingresar al menos una característica',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  void mostrarAyudaTitulo() {
    if (_paso == 1) {
      Fluttertoast.showToast(
        msg: 'DATOS GENERALES DE TU EMPRESA',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else if (_paso == 2) {
      Fluttertoast.showToast(
        msg:
            'LAS CARACTERÍSTICAS INDICAN QUE DATOS LLENAR ACERCA DE LAS MÁQUINAS A REPARAR, EJEMPLO EN UN VEHÍCULO: KILOMETRAJE, AÑO, COLOR, ETC',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void cambioObligatorio(bool? v) {
    _caracteristica.carObligatorio = v ?? false;
    notifyListeners();
  }

  void cambioTipo(int valor) {
    _caracteristica.carTipo = valor;
    notifyListeners();
  }

  void cambioSeleccionable(bool valor) {
    _caracteristica.carSeleccionadble = valor;
    notifyListeners();
  }

  void nuevaCaracteristica(BuildContext context) {
    modificar = false;
    _caracteristica = Caracteristica(
      carId: -1,
      carNombre: '',
      carTipo: 1,
      carObligatorio: false,
      carSeleccionadble: false,
    );
    _detalles = [];
    Navigator.pushNamed(context, 'nueva_caracteristica');
    notifyListeners();
  }

  void modificarCaracteristica(
      BuildContext context, Caracteristica car, int idx) {
    modificar = true;
    index = idx;
    _caracteristica = Caracteristica(
      carId: -1,
      carNombre: car.carNombre,
      carTipo: car.carTipo,
      carObligatorio: car.carObligatorio,
      carSeleccionadble: car.carSeleccionadble,
    );
    _detalles = car.detalles ?? [];
    Navigator.pushNamed(context, 'nueva_caracteristica');
    notifyListeners();
  }

  void inicializar(BuildContext context) {
    _nombre = '';
    _direccion = '';
    _identificador = '';
    _palabraClave = '';
    _validarIdentificacion = false;
    notifyListeners();
    Navigator.pushNamed(context, 'crear_empresa');
  }
}
