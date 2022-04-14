import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/marca_model.dart';
import 'package:app_ordenes/models/modelo_model.dart';
import 'package:app_ordenes/models/orden_model.dart';
import 'package:app_ordenes/models/requests/modelo_request.dart';
import 'package:app_ordenes/models/requests/vehiculo_request.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
import 'package:app_ordenes/models/responses/modelo_response.dart';
import 'package:app_ordenes/models/responses/vehiculo_response.dart';
import 'package:app_ordenes/models/services/modelo_service.dart';
import 'package:app_ordenes/models/services/vehiculo_service.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';
import 'package:app_ordenes/ui/widgets/dialogo_cargando_widget.dart';
import 'package:app_ordenes/ui/widgets/dialogo_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VehiculoBloc extends ChangeNotifier {
  String _placa = '';
  int idVehiculo = -1;
  int idModelo = -1;
  int idMarca = -1;
  String _modelo = "";
  String _color = "";
  double? _kilometraje;
  int? _anio;
  String? _filtroModelo = "";
  String? _filtroMarca = "";

  List<Modelo> _modelos = [];
  List<Modelo> _modelosFiltrados = [];
  List<Marca> _marcas = [];
  List<Marca> _marcasFiltradas = [];

  List<Vehiculo> _vehiculosCliente = [];
  List<Vehiculo> _vehiculosClienteFiltrados = [];

  Modelo _modeloSelect =
      Modelo(modId: -1, marId: -1, marNombre: "", modNombre: "");
  Marca _marcaSelect = Marca(
      marId: -1, eprId: -1, marCodigo: "", marNombre: "", marActivo: true);

  bool _cargandoModelos = false;
  bool _cargandoMarcas = false;

  TextEditingController _ctrlPlaca = TextEditingController();
  TextEditingController _ctrlFiltroVehiculo = TextEditingController();
  TextEditingController _ctrlFiltroModelo = TextEditingController();
  TextEditingController _ctrlFiltroMarca = TextEditingController();
  TextEditingController _ctrlMarcaSelect = TextEditingController();
  TextEditingController _ctrlModelo = TextEditingController();
  TextEditingController _ctrlColor = TextEditingController();
  TextEditingController _ctrlAnio = TextEditingController();
  TextEditingController _ctrlKilometraje = TextEditingController();

  String get placa => _placa;
  String get filtroModelo => _filtroModelo!;
  String get filtroMarca => _filtroMarca!;
  List<Modelo> get modelos => _modelos;
  List<Modelo> get modelosFiltrados => _modelosFiltrados;
  List<Marca> get marcas => _marcas;
  List<Vehiculo> get vehiculosCliente => _vehiculosCliente;
  List<Vehiculo> get vehiculosClienteFiltrados => _vehiculosClienteFiltrados;
  List<Marca> get marcasFiltradas => _marcasFiltradas;
  bool get cargandoModelos => _cargandoModelos;
  bool get cargandoMarcas => _cargandoMarcas;
  Modelo get modeloSelect => _modeloSelect;
  Marca get marcaSelect => _marcaSelect;
  String get modelo => _modelo;
  String get color => _color;
  double get kilometraje => _kilometraje == null ? 0 : _kilometraje!;
  int get anio => _anio!;

  set modelos(List<Modelo> m) {
    _modelos = m;
    notifyListeners();
  }

  set modelosFiltrados(List<Modelo> m) {
    _modelosFiltrados = m;
    notifyListeners();
  }

  set vehiculosCliente(List<Vehiculo> m) {
    _vehiculosCliente = m;
    notifyListeners();
  }

  set vehiculosClienteFiltrados(List<Vehiculo> m) {
    _vehiculosClienteFiltrados = m;
    notifyListeners();
  }

  set marcas(List<Marca> m) {
    _marcas = m;
    notifyListeners();
  }

  set marcasFiltradas(List<Marca> m) {
    _marcasFiltradas = m;
    notifyListeners();
  }

  set cargandoMarcas(bool m) {
    _cargandoMarcas = m;
    notifyListeners();
  }

  set cargandoModelos(bool m) {
    _cargandoModelos = m;
    notifyListeners();
  }

  set modeloSelect(Modelo m) {
    _modeloSelect = m;
    notifyListeners();
  }

  set marcaSelect(Marca m) {
    _marcaSelect = m;
    notifyListeners();
  }

  void setearDatos(Orden orden) {
    idVehiculo = orden.vehiculo.vehId;
    idMarca = orden.vehiculo.marId;
    idModelo = orden.vehiculo.modId;
    _modeloSelect = Modelo(
        modId: orden.vehiculo.modId,
        marId: orden.vehiculo.marId,
        marNombre: orden.vehiculo.marNombre,
        modNombre: orden.vehiculo.modNombre);
    _modelo = orden.vehiculo.marNombre + " " + orden.vehiculo.modNombre;
    _placa = orden.vehiculo.vehPlaca;
    _kilometraje = orden.corKilometraje;
    ctrlKilometraje.text = _kilometraje.toString();
    _anio = orden.vehiculo.vehAnio;
    ctrlAnio.text = orden.vehiculo.vehAnio.toString();
    _color = orden.vehiculo.vehColor!;
    _vehiculosCliente = [];
    _vehiculosClienteFiltrados = [];
    _ctrlFiltroVehiculo.text = '';
    _filtroMarca = '';
    _filtroModelo = '';
    _marcasFiltradas = [];
    _modelosFiltrados = [];
    _modelos = [];
    _marcas = [];
    notifyListeners();
  }

  void limpiarDatosFinal() {
    idVehiculo = -1;
    idMarca = -1;
    idModelo = -1;
    _modeloSelect = Modelo(modId: -1, marId: -1, marNombre: "", modNombre: "");
    _marcaSelect = Marca(
        marId: -1, eprId: -1, marCodigo: "", marNombre: "", marActivo: true);
    _placa = '';
    _kilometraje = null;
    _anio = 0;
    _color = '';
    _vehiculosCliente = [];
    _vehiculosClienteFiltrados = [];
    _ctrlFiltroVehiculo.text = '';
    _modelo = '';
    _ctrlAnio.text = '';
    _ctrlColor.text = '';
    _ctrlFiltroMarca.text = '';
    _ctrlFiltroModelo.text = '';
    _ctrlKilometraje.text = '';
    _ctrlFiltroVehiculo.text = '';
    _filtroMarca = '';
    _filtroModelo = '';
    _marcasFiltradas = [];
    _modelosFiltrados = [];
    _modelos = [];
    _marcas = [];
    notifyListeners();
  }

  TextEditingController get ctrlModelo {
    _ctrlModelo.text = _modelo;
    _ctrlModelo.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlModelo.text.length));
    return _ctrlModelo;
  }

  TextEditingController get ctrlMarcaSelect {
    _ctrlMarcaSelect.text = _marcaSelect.marNombre;
    _ctrlMarcaSelect.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlMarcaSelect.text.length));
    return _ctrlMarcaSelect;
  }

  TextEditingController get ctrlFiltroModelo {
    return _ctrlFiltroModelo;
  }

  TextEditingController get ctrlFiltroVehiculo {
    return _ctrlFiltroVehiculo;
  }

  TextEditingController get ctrlFiltroMarca {
    return _ctrlFiltroMarca;
  }

  TextEditingController get ctrlColor {
    _ctrlColor.text = _color;
    _ctrlColor.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlColor.text.length));
    return _ctrlColor;
  }

  TextEditingController get ctrlKilometraje {
    return _ctrlKilometraje;
  }

  TextEditingController get ctrlPlaca {
    _ctrlPlaca.text = _placa;
    _ctrlPlaca.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlPlaca.text.length));
    return _ctrlPlaca;
  }

  TextEditingController get ctrlAnio {
    //_ctrlAnio.text = (_anio != 0 && _anio != null ? _anio.toString() : '');
    return _ctrlAnio;
  }

  set anio(int a) {
    _anio = a;
    notifyListeners();
  }

  set color(String c) {
    _color = c;
    notifyListeners();
  }

  set modelo(String c) {
    _modelo = c;
    notifyListeners();
  }

  set filtroModelo(String c) {
    _filtroModelo = c;
    notifyListeners();
  }

  set filtroMarca(String c) {
    _filtroMarca = c;
    notifyListeners();
  }

  set kilometraje(double c) {
    _kilometraje = c;
    notifyListeners();
  }

  set placa(String p) {
    _placa = p;
    notifyListeners();
  }

  void cambioPlaca(String e) {
    _placa = e;
    if (idVehiculo != -1) {
      _modeloSelect =
          Modelo(modId: -1, marId: -1, marNombre: "", modNombre: "");
      _marcaSelect = Marca(
          marId: -1, eprId: -1, marCodigo: "", marNombre: "", marActivo: true);

      idVehiculo = -1;
      idModelo = -1;
      idMarca = -1;
      _color = '';
      _anio = null;
      _kilometraje = null;
      _modelo = '';

      _ctrlModelo.text = '';
      _ctrlAnio.text = '';
      _ctrlKilometraje.text = '';
      _ctrlColor.text = '';
      notifyListeners();
    }
  }

  void filtrarModelos(String v) {
    _modelosFiltrados = _modelos.where((f) {
      return f.modNombre.toLowerCase().contains(v.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void cargarModelos() {
    _modelosFiltrados = _modelos;
    notifyListeners();
  }

  void filtrarMarcas(String v) {
    _marcasFiltradas = _marcas.where((f) {
      return f.marNombre.toLowerCase().contains(v.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void cargarMarcas() {
    _marcasFiltradas = _marcas;
    notifyListeners();
  }

  void filtrarVehiculos(String v) {
    _vehiculosClienteFiltrados = _vehiculosCliente.where((f) {
      return f.vehPlaca.toLowerCase().contains(v.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void cargarVehiculos() {
    _vehiculosClienteFiltrados = _vehiculosCliente;
    notifyListeners();
  }

  void seleccionarMarcaFiltro(
      BuildContext context, Size size, Marca mar) async {
    _ctrlMarcaSelect.text = mar.marNombre;
    _marcaSelect = mar;
    abrirAuydaModelo(context, size, false);
  }

  void abrirAyudaMarca(
      BuildContext context, Size size, bool cargarPagina) async {
    Preferencias pref = Preferencias();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const DialogoCargando(
          texto: 'Revisando conexión',
        );
      },
    );
    _cargandoMarcas = true;
    final conect = await verificarConexion();
    Navigator.pop(context);
    if (conect) {
      if (cargarPagina) {
        Navigator.pushNamed(context, 'ayuda_marca');
      } else {
        _filtroMarca = '';
        _ctrlFiltroMarca.text = '';
      }
      MarcaResponse res = await ModeloService.buscarMarcas(pref.empresa);
      if (res.ok == true) {
        _marcas = res.marcas!;
        _marcasFiltradas = res.marcas!;
        _cargandoMarcas = false;

        notifyListeners();
      } else {
        cargandoMarcas = false;
        showDialog(
            context: context,
            builder: (_) {
              return DialogoGeneral(
                size: size,
                lottie: 'assets/lotties/error_lottie.json',
                mostrarBoton1: true,
                mostrarBoton2: false,
                titulo: 'ALERTA',
                texto: res.msg,
                accion1: () {
                  Navigator.pop(context);
                },
                textoBtn1: 'Ok',
                textoBtn2: 'Cancelar',
                accion2: () {},
              );
            });
      }
    } else {
      cargandoModelos = false;
      showDialog(
          context: context,
          builder: (_) {
            return DialogoGeneral(
              size: size,
              lottie: 'assets/lotties/alerta_lottie.json',
              mostrarBoton1: true,
              mostrarBoton2: false,
              titulo: 'ALERTA',
              texto: 'No hay conexión a internet',
              accion1: () {
                Navigator.pop(context);
              },
              textoBtn1: 'Ok',
              textoBtn2: 'Cancelar',
              accion2: () {},
            );
          });
    }
  }

  void abrirAuydaModelo(
      BuildContext context, Size size, bool cargarPagina) async {
    Preferencias pref = Preferencias();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const DialogoCargando(
          texto: 'Revisando conexión',
        );
      },
    );
    _cargandoModelos = true;
    final conect = await verificarConexion();
    Navigator.pop(context);
    if (conect) {
      if (cargarPagina) {
        Navigator.pushNamed(context, 'ayuda_modelo');
      } else {
        _filtroModelo = '';
        _ctrlFiltroModelo.text = '';
      }
      ModeloResponse res = await ModeloService.buscarModelos(
          ModeloRequest(marca: _marcaSelect.marId, empresa: pref.empresa));

      if (res.ok == true) {
        _modelos = res.modelos!;
        _modelosFiltrados = res.modelos!;
        _cargandoModelos = false;

        if (_modelosFiltrados.isEmpty) {
          Fluttertoast.showToast(
              msg: "No hay datos...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        notifyListeners();
      } else {
        cargandoModelos = false;
        showDialog(
            context: context,
            builder: (_) {
              return DialogoGeneral(
                size: size,
                lottie: 'assets/lotties/error_lottie.json',
                mostrarBoton1: true,
                mostrarBoton2: false,
                titulo: 'ALERTA',
                texto: res.msg,
                accion1: () {
                  Navigator.pop(context);
                },
                textoBtn1: 'Ok',
                textoBtn2: 'Cancelar',
                accion2: () {},
              );
            });
      }
    } else {
      cargandoModelos = false;
      showDialog(
          context: context,
          builder: (_) {
            return DialogoGeneral(
              size: size,
              lottie: 'assets/lotties/alerta_lottie.json',
              mostrarBoton1: true,
              mostrarBoton2: false,
              titulo: 'ALERTA',
              texto: 'No hay conexión a internet',
              accion1: () {
                Navigator.pop(context);
              },
              textoBtn1: 'Ok',
              textoBtn2: 'Cancelar',
              accion2: () {},
            );
          });
    }
  }

  void seleccionarVehiculo(BuildContext context, Vehiculo vehiculo) {
    print(vehiculo.vehColor);
    Preferencias pref = Preferencias();
    idModelo = vehiculo.modId;
    idMarca = -1;
    idVehiculo = vehiculo.vehId;
    _color = vehiculo.vehColor!;
    _anio = vehiculo.vehAnio!;
    _modelo = vehiculo.modelo;
    _ctrlAnio.text = _anio != null ? _anio.toString() : '';
    _placa = vehiculo.vehPlaca;
    _modeloSelect = Modelo(
      modId: vehiculo.modId,
      marId: vehiculo.marId,
      marNombre: vehiculo.marNombre,
      modNombre: vehiculo.modNombre,
    );
    _marcaSelect = Marca(
      marId: vehiculo.marId,
      eprId: pref.empresa,
      marCodigo: '',
      marNombre: vehiculo.marNombre,
      marActivo: true,
    );
    Navigator.pop(context);
    notifyListeners();
  }

  void seleccionar(BuildContext context, Vehiculo vehiculo) {
    idModelo = vehiculo.modId;
    idMarca = -1;
    _placa = vehiculo.vehPlaca;
    idVehiculo = vehiculo.vehId;
    _color = vehiculo.vehColor!;
    _anio = vehiculo.vehAnio!;
    _modelo = vehiculo.modelo;
    _modeloSelect = Modelo(
      modId: vehiculo.modId,
      marId: vehiculo.marId,
      marNombre: vehiculo.marNombre,
      modNombre: vehiculo.modNombre,
    );
    _marcaSelect = Marca(
      marId: vehiculo.marId,
      eprId: Preferencias().empresa,
      marCodigo: '',
      marNombre: vehiculo.marNombre,
      marActivo: true,
    );
    Navigator.pop(context);
    notifyListeners();
  }

  void buscarVehiculo(BuildContext context, Size size) async {
    Preferencias pref = Preferencias();
    if (_placa.trim().isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const DialogoCargando(
            texto: 'Revisando conexión',
          );
        },
      );
      final conect = await verificarConexion();
      Navigator.pop(context);
      if (conect) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return const DialogoCargando(
              texto: 'Buscando información...',
            );
          },
        );

        VehiculoResponse res = await VehiculoService.buscarVehiculo(
            VehiculoRequest(placa: _placa, empresa: pref.empresa));
        Navigator.pop(context);

        if (res.ok == true) {
          if (res.encontrado == true) {
            idModelo = res.vehiculo!.modId;
            idMarca = -1;
            idVehiculo = res.vehiculo!.vehId;
            _color = res.vehiculo!.vehColor!;
            _anio = res.vehiculo!.vehAnio!;
            _modelo = res.vehiculo!.modelo;
            _modeloSelect = Modelo(
              modId: res.vehiculo!.modId,
              marId: res.vehiculo!.marId,
              marNombre: res.vehiculo!.marNombre,
              modNombre: res.vehiculo!.modNombre,
            );
            _marcaSelect = Marca(
              marId: res.vehiculo!.marId,
              eprId: pref.empresa,
              marCodigo: '',
              marNombre: res.vehiculo!.marNombre,
              marActivo: true,
            );
            notifyListeners();
          } else {
            _modeloSelect =
                Modelo(modId: -1, marId: -1, marNombre: "", modNombre: "");
            _marcaSelect = Marca(
                marId: -1,
                eprId: -1,
                marCodigo: "",
                marNombre: "",
                marActivo: true);

            idVehiculo = -1;
            idModelo = -1;
            idMarca = -1;
            _color = '';
            _anio = null;
            _kilometraje = null;
            _modelo = '';

            _ctrlModelo.text = '';
            _ctrlAnio.text = '';
            _ctrlKilometraje.text = '';
            _ctrlColor.text = '';
            notifyListeners();
            Fluttertoast.showToast(
              msg: "No se ha encontrado el vehículo",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red.shade300,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          showDialog(
              context: context,
              builder: (_) {
                return DialogoGeneral(
                  size: size,
                  lottie: 'assets/lotties/error_lottie.json',
                  mostrarBoton1: true,
                  mostrarBoton2: false,
                  titulo: 'ALERTA',
                  texto: res.msg,
                  accion1: () {
                    Navigator.pop(context);
                  },
                  textoBtn1: 'Ok',
                  textoBtn2: 'Cancelar',
                  accion2: () {},
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (_) {
              return DialogoGeneral(
                size: size,
                lottie: 'assets/lotties/alerta_lottie.json',
                mostrarBoton1: true,
                mostrarBoton2: false,
                titulo: 'ALERTA',
                texto: 'No hay conexión a internet',
                accion1: () {
                  Navigator.pop(context);
                },
                textoBtn1: 'Ok',
                textoBtn2: 'Cancelar',
                accion2: () {},
              );
            });
      }
    } else {
      Fluttertoast.showToast(
          msg: "Debe ingresar la placa",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
