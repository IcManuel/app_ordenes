import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/caracteristica_model.dart';
import 'package:app_ordenes/models/marca_model.dart';
import 'package:app_ordenes/models/modelo_model.dart';
import 'package:app_ordenes/models/orden_model.dart';
import 'package:app_ordenes/models/requests/modelo_request.dart';
import 'package:app_ordenes/models/requests/vehiculo_request.dart';
import 'package:app_ordenes/models/responses/caracteristica_response.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
import 'package:app_ordenes/models/responses/modelo_response.dart';
import 'package:app_ordenes/models/responses/vehiculo_response.dart';
import 'package:app_ordenes/models/services/caracteristica_service.dart';
import 'package:app_ordenes/models/services/modelo_service.dart';
import 'package:app_ordenes/models/services/vehiculo_service.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';
import 'package:app_ordenes/ui/widgets/dialogo_cargando_widget.dart';
import 'package:app_ordenes/ui/widgets/dialogo_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VehiculoBloc extends ChangeNotifier {
  String _placa = '';
  bool _cargando = false;
  int idVehiculo = -1;
  int idModelo = -1;
  String _palabraClave = '';
  String _identificador = '';
  int idMarca = -1;
  String _modelo = "";
  String? _filtroModelo = "";
  String? _filtroMarca = "";

  List<Modelo> _modelos = [];
  List<Modelo> _modelosFiltrados = [];
  List<Marca> _marcas = [];
  List<Marca> _marcasFiltradas = [];
  List<Caracteristica> _lista = [];

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

  String get placa => _placa;
  bool get cargando => _cargando;
  String get filtroModelo => _filtroModelo!;
  String get filtroMarca => _filtroMarca!;
  List<Caracteristica> get lista => _lista;
  String get palabraClave => _palabraClave;
  String get identificador => _identificador;
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

  set palabraClave(String s) {
    _palabraClave = s;
    notifyListeners();
  }

  set identificador(String s) {
    _identificador = s;
    notifyListeners();
  }

  set modelos(List<Modelo> m) {
    _modelos = m;
    notifyListeners();
  }

  set lista(List<Caracteristica> m) {
    _lista = m;
    notifyListeners();
  }

  set cargando(bool c) {
    _cargando = c;
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

  void cargarCaracteristicas(int empresa) async {
    _cargando = true;
    final conect = await verificarConexion();
    if (conect) {
      CaracteristicaResponse res =
          await CaracteristicaService.buscarCaracteristicas(empresa);
      if (res.ok == true) {
        _cargando = false;
        _lista = res.caracteristicas!;
        notifyListeners();
      } else {
        _cargando = false;
        Fluttertoast.showToast(
            msg: "No se pudieron cargar caracteristicas, error => " + res.msg!,
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
          msg: "No hay conexión para cargar caracteristicas...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void cargarCaracteristicasVehiculo(int veh) async {
    _cargando = true;
    final conect = await verificarConexion();
    if (conect) {
      CaracteristicaResponse res =
          await CaracteristicaService.buscarCaracteristicasVehiculo(veh);
      if (res.ok == true) {
        _cargando = false;
        _lista = res.caracteristicas!;
        notifyListeners();
      } else {
        _cargando = false;
        Fluttertoast.showToast(
            msg: "No se pudieron cargar caracteristicas, error => " + res.msg!,
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
          msg: "No hay conexión para cargar caracteristicas...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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
    _vehiculosCliente = [];
    _vehiculosClienteFiltrados = [];
    _ctrlFiltroVehiculo.text = '';
    _filtroMarca = '';
    _filtroModelo = '';
    _marcasFiltradas = [];
    _modelosFiltrados = [];
    _modelos = [];
    _marcas = [];
    cargarCaracteristicasVehiculo(idVehiculo);
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
    _vehiculosCliente = [];
    _vehiculosClienteFiltrados = [];
    _ctrlFiltroVehiculo.text = '';
    _modelo = '';
    _ctrlFiltroMarca.text = '';
    _ctrlFiltroModelo.text = '';
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

  TextEditingController get ctrlPlaca {
    _ctrlPlaca.text = _placa;
    _ctrlPlaca.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlPlaca.text.length));
    return _ctrlPlaca;
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

  set placa(String p) {
    _placa = p;
    notifyListeners();
  }

  void cambioPlaca(String e) {
    if (e != _placa) {
      _placa = e;
      if (idVehiculo != -1) {
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

        _modelo = '';

        _ctrlModelo.text = '';
        for (int i = 0; i < _lista.length; i++) {
          _lista[i].valor = '';
        }
        notifyListeners();
      }
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
    Preferencias pref = Preferencias();
    idModelo = vehiculo.modId;
    idMarca = -1;
    idVehiculo = vehiculo.vehId;
    _modelo = vehiculo.modelo;
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
    cargarCaracteristicasVehiculo(vehiculo.vehId);
    Navigator.pop(context);
    notifyListeners();
  }

  void seleccionar(BuildContext context, Vehiculo vehiculo) {
    idModelo = vehiculo.modId;
    idMarca = -1;
    _placa = vehiculo.vehPlaca;
    idVehiculo = vehiculo.vehId;
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
            _modelo = '';

            _ctrlModelo.text = '';
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
