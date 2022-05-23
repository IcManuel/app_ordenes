import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/blocs/visual_bloc.dart';
import 'package:app_ordenes/models/caracteristica_model.dart';
import 'package:app_ordenes/models/foto_model.dart';
import 'package:app_ordenes/models/orden_model.dart';
import 'package:app_ordenes/models/requests/pdf_request.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
import 'package:app_ordenes/models/services/imagen_service.dart';
import 'package:app_ordenes/models/services/orden_service.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'dart:io';
import 'package:app_ordenes/models/cliente_model.dart';
import 'package:app_ordenes/models/imagen_model.dart';
import 'package:intl/intl.dart';
import 'package:app_ordenes/models/obs_visual_model.dart';
import 'package:app_ordenes/models/requests/corden_ingreso_request.dart';
import 'package:app_ordenes/models/responses/vehiculo_response.dart';
import 'package:app_ordenes/models/services/vehiculo_service.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/requests/cliente_request.dart';
import 'package:app_ordenes/models/responses/cliente_response.dart';
import 'package:app_ordenes/models/services/cliente_service.dart';
import 'package:app_ordenes/ui/widgets/dialogo_cargando_widget.dart';
import 'package:app_ordenes/ui/widgets/dialogo_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class OrdenBloc extends ChangeNotifier {
  String _identificacion = '';
  String msj = '';
  int _tipo = 1;
  int? _numeroOrden;
  bool _habilitarGrabar = false;
  String _nombres = '';
  String _apellidos = '';
  String _direccion = '';
  String _observaciones = '';
  String _observacionesUsu = '';
  String _telefono = '';
  String _correo = '';
  int _idCliente = -1;
  List<Cliente> _clientesFiltrados = [];
  bool _cargandoClientes = true;
  String _pdfArchivo = '';
  String _pdfNombre = '';
  bool _modificar = false;
  int idOrden = -1;

  TextEditingController _ctrlIdentificacion = TextEditingController();
  TextEditingController _ctrlNombres = TextEditingController();
  TextEditingController _ctrlApellidos = TextEditingController();
  TextEditingController _ctrlDireccion = TextEditingController();
  TextEditingController _ctrlCorreo = TextEditingController();
  TextEditingController _ctrlTelefono = TextEditingController();
  TextEditingController _ctrlObs = TextEditingController();
  TextEditingController _ctrlObsUsu = TextEditingController();

  String get identificacion => _identificacion;
  String get nombres => _nombres;
  bool get cargandoClientes => _cargandoClientes;
  String get direccion => _direccion;
  int get numeroOrden => _numeroOrden!;
  String get telefono => _telefono;
  String get observaciones => _observaciones;
  String get observacionesUsu => _observacionesUsu;
  bool get modificar => _modificar;
  bool get habilitarGrabar => _habilitarGrabar;

  String get correo => _correo;
  int get tipo => _tipo;
  int get idCliente => _idCliente;
  String get apellidos => _apellidos;
  List<Cliente> get clientesFiltrados => _clientesFiltrados;

  set numeroOrden(int n) {
    _numeroOrden = n;
    notifyListeners();
  }

  set habilitarGrabar(bool h) {
    _habilitarGrabar = h;
    notifyListeners();
  }

  set modificar(bool m) {
    _modificar = m;
    notifyListeners();
  }

  set tipo(int t) {
    _tipo = t;
    notifyListeners();
  }

  /**   void scannear(BuildContext context, bool navegar) async {
    _scanResult = [];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const DialogoCargando(
          texto: 'Buscando dispositivos...',
        );
      },
    );
    bool estaPrendido = false;
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    estaPrendido = await bluetooth.isOn ?? false;
    if (estaPrendido) {
      _scanResult = await bluetooth.getBondedDevices();
      Navigator.pop(context);
      if (navegar) Navigator.pushNamed(context, 'ayuda_impresora');
      notifyListeners();
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: 'Debe encender el bluetooth',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void seleccionarImpresora(int index, context) async {
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    bluetooth.connect(_scanResult![index]);
  }
*/
  void setearDatosSelect(Orden orden) {
    _identificacion = orden.cliente.cliIdentificacion;
    _idCliente = orden.cliente.cliId;
    idOrden = orden.corId;
    _modificar = true;
    _numeroOrden = orden.corNumero;
    _nombres = orden.cliente.cliNombres!;
    _telefono = orden.cliente.cliCelular!;
    _correo = orden.cliente.cliCorreo!;
    _direccion = orden.cliente.cliDireccion!;
    _observaciones = orden.corObsCliente;
    _observacionesUsu = orden.corObservacion;

    ctrlCorreo.text = _correo;
    _ctrlTelefono.text = _telefono;
    _ctrlNombres.text = _nombres;
    _ctrlIdentificacion.text = _identificacion;
    _ctrlDireccion.text = _direccion;
    _ctrlObs.text = _observaciones;
    _ctrlObsUsu.text = _observacionesUsu;

    notifyListeners();
  }

  void seleccionar(BuildContext context, Cliente pro) async {
    _idCliente = pro.cliId;
    _identificacion = pro.cliIdentificacion;
    _nombres = pro.cliNombres!;
    _telefono = pro.cliCelular!;
    _correo = pro.cliCorreo!;
    _direccion = pro.cliDireccion!;
    _ctrlCorreo.text = _correo;
    _ctrlTelefono.text = _telefono;
    _ctrlNombres.text = _nombres;
    _ctrlIdentificacion.text = _identificacion;
    _ctrlDireccion.text = _direccion;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const DialogoCargando(
          texto: 'Buscando datos...',
        );
      },
    );
    VehiculoResponse resVeh =
        await VehiculoService.obtenerVehiculosPorCliente(pro.cliId);
    Navigator.pop(context);
    Navigator.pop(context);
    if (resVeh.ok) {
      final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);
      vehiculoBloc.vehiculosCliente = resVeh.vehiculos ?? [];
    }
    notifyListeners();
  }

  TextEditingController get ctrlIdentificacion {
    return this._ctrlIdentificacion;
  }

  TextEditingController get ctrlObs {
    return this._ctrlObs;
  }

  TextEditingController get ctrlObsUsu {
    return this._ctrlObsUsu;
  }

  TextEditingController get ctrlNombres {
    return this._ctrlNombres;
  }

  TextEditingController get ctrlApellidos {
    return this._ctrlApellidos;
  }

  TextEditingController get ctrlDireccion {
    return this._ctrlDireccion;
  }

  TextEditingController get ctrlCorreo {
    return this._ctrlCorreo;
  }

  TextEditingController get ctrlTelefono {
    return this._ctrlTelefono;
  }

  set cargandoClientes(bool c) {
    _cargandoClientes = c;
    notifyListeners();
  }

  set clientesFiltrados(List<Cliente> c) {
    _clientesFiltrados = c;
    notifyListeners();
  }

  set idCliente(int n) {
    _idCliente = n;
    notifyListeners();
  }

  void cambioNombres(String v) {
    _nombres = v;
    notifyListeners();
  }

  set nombres(String n) {
    _nombres = n;
    notifyListeners();
  }

  set apellidos(String n) {
    _apellidos = n;
    notifyListeners();
  }

  set direccion(String n) {
    _direccion = n;
    notifyListeners();
  }

  set telefono(String n) {
    _telefono = n;
    notifyListeners();
  }

  set observaciones(String c) {
    _observaciones = c;
    notifyListeners();
  }

  set observacionesUsu(String c) {
    _observacionesUsu = c;
    notifyListeners();
  }

  set correo(String n) {
    _correo = n;
    notifyListeners();
  }

  set identificacion(String i) {
    _identificacion = i;
    notifyListeners();
  }

  void limpiar() {
    _identificacion = '';
  }

  void cambioIdentificacion(BuildContext context, String e) {
    if (_identificacion != e) {
      _identificacion = e;
      if (_idCliente != -1) {
        final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);
        vehiculoBloc.vehiculosCliente = [];
        _idCliente = -1;
        _nombres = '';
        _apellidos = '';
        _direccion = '';
        _telefono = '';
        _correo = '';

        _ctrlNombres.text = '';
        _ctrlApellidos.text = '';
        _ctrlDireccion.text = '';
        _ctrlTelefono.text = '';
        _ctrlCorreo.text = '';
        notifyListeners();
      }
    }
  }

  void buscarCliente(BuildContext context, Size size) async {
    Preferencias pref = Preferencias();
    if (_identificacion.trim().isNotEmpty) {
      final conect = await verificarConexion();
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
        ClienteResponse res = await ClienteService.buscarCliente(ClienteRequest(
            identificacion: _identificacion, empresa: pref.empresa));
        Navigator.pop(context);
        if (res.ok == true) {
          if (res.encontrado == true) {
            _idCliente = res.cliente!.cliId;
            _nombres = res.cliente!.cliNombres!;
            _apellidos = res.cliente!.cliApellidos!;
            _direccion = res.cliente!.cliDireccion!;
            _telefono = res.cliente!.cliCelular!;
            _correo = res.cliente!.cliCorreo!;
            _identificacion = res.cliente!.cliIdentificacion;

            _ctrlNombres.text = res.cliente!.cliNombres!;
            _ctrlApellidos.text = res.cliente!.cliApellidos!;
            _ctrlDireccion.text = res.cliente!.cliDireccion!;
            _ctrlTelefono.text = res.cliente!.cliCelular!;
            _ctrlCorreo.text = res.cliente!.cliCorreo!;
            _ctrlIdentificacion.text = _identificacion;
            VehiculoResponse resVeh =
                await VehiculoService.obtenerVehiculosPorCliente(
                    res.cliente!.cliId);
            if (resVeh.ok) {
              final vehiculoBloc =
                  Provider.of<VehiculoBloc>(context, listen: false);
              vehiculoBloc.vehiculosCliente = resVeh.vehiculos ?? [];
            }
            notifyListeners();
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
      }
    }
  }

  void limpiarFinal(VehiculoBloc vehiculoBloc, DetallesBloc detallesBloc,
      VisualBloc visual, FotosBloc fotosBloc) {
    _idCliente = -1;
    _identificacion = '';
    _nombres = '';
    _telefono = '';
    _correo = '';
    _direccion = '';
    _observaciones = '';
    _observacionesUsu = '';

    _clientesFiltrados = [];
    _ctrlApellidos.text = '';
    _ctrlCorreo.text = '';
    _ctrlDireccion.text = '';
    _ctrlIdentificacion.text = '';
    _ctrlNombres.text = '';
    _ctrlObs.text = '';
    _ctrlObsUsu.text = '';
    _ctrlTelefono.text = '';

    vehiculoBloc.limpiarDatosFinal();
    fotosBloc.limpiarDatos();
    visual.limpiarDatos();
    detallesBloc.limpiarDatos();
    notifyListeners();
  }

  void guardarFinal(BuildContext context, VehiculoBloc vehiculoBloc,
      DetallesBloc detallesBloc, VisualBloc visualBloc, Size size) async {
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
    final conect = await verificarConexion();
    Navigator.pop(context);
    if (conect) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const DialogoCargando(
            texto: 'Enviado orden......',
          );
        },
      );
      Cliente cli = Cliente(
        cliId: _idCliente,
        cliIdentificacion: _identificacion,
        cliApellidos: '',
        cliCelular: _telefono,
        cliCorreo: _correo,
        cliDireccion: _direccion,
        cliNombres: _nombres,
        eprId: pref.empresa,
      );
      Vehiculo veh = Vehiculo(
        vehId: vehiculoBloc.idVehiculo,
        modelo: '',
        modId: vehiculoBloc.modeloSelect.modId,
        vehPlaca: vehiculoBloc.placa,
        marId: -1,
        marNombre: '',
        modNombre: '',
        eprId: pref.empresa,
      );

      List<ObsVisual> visuales = [];
      for (int i = 0; i < visualBloc.lista.length; i++) {
        if (visualBloc.lista[i].check) {
          visuales.add(visualBloc.lista[i]);
        }
      }

      List<Caracteristica> carac = [];
      for (int i = 0; i < vehiculoBloc.lista.length; i++) {
        if (vehiculoBloc.lista[i].valor != null &&
            vehiculoBloc.lista[i].valor!.trim().isNotEmpty) {
          print('AÑADE ' + vehiculoBloc.lista[i].idCal.toString());
          carac.add(vehiculoBloc.lista[i]);
        }
      }

      List<ImagenModel> imagenes = [];

      final fotosBloc = Provider.of<FotosBloc>(context, listen: false);

      io.Directory documentsDirectory =
          await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "imagenes");
      if (await Directory(path).exists() == false) {
        Directory(path).create().then((Directory directory) {});
      }

      for (FotoModel f in fotosBloc.fotos) {
        String pathFnal = join(path, f.imagen.name);
        final File imagenCache = File(f.imagen.path);
        imagenCache.copy(pathFnal);
        String imgPath = await ImagenService.uploadImage(f.imagen.path);
        imagenes.add(ImagenModel(tipo: 1, imagen: imgPath));
      }

      for (FotoModel f in fotosBloc.fotosEntrega) {
        String pathFnal = join(path, f.imagen.name);
        final File imagenCache = File(f.imagen.path);
        imagenCache.copy(pathFnal);
        String imgPath = await ImagenService.uploadImage(f.imagen.path);
        imagenes.add(ImagenModel(tipo: 2, imagen: imgPath));
      }

      CordenRequest cor = CordenRequest(
        eprId: pref.empresa,
        usuario: pref.usuario!.usuId,
        obscliente: _observaciones,
        obsvisual: visualBloc.obsVisual,
        fecha: DateFormat('dd-MM-yyyy kk:mm:ss').format(DateTime.now()),
        observacion: _observacionesUsu,
        total: detallesBloc.totalFinal,
        estado: tipo == 1 ? 2 : 4,
        descuento: 0,
        clienteModel: cli,
        vehiculoModel: veh,
        caracteristicas: carac,
        detalles: detallesBloc.detalles,
        visuales: visuales,
        imagenes: imagenes,
        idOrden: modificar == true ? idOrden : -1,
      );
      MarcaResponse res = await OrdenService.insertarOrden(cor);
      Navigator.pop(context);
      if (res.ok == true) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) {
            return const DialogoCargando(
              texto: 'Generando PDF......',
            );
          },
        );

        await OrdenService.obtenerPdf(
          context,
          PdfRequest(
            id: res.uid!,
            empresa: pref.empresa,
            crear: true,
          ),
        );
        Navigator.pop(context);
        // ignore: unnecessary_null_comparison
        if (_pdfArchivo.trim() != '' && _pdfArchivo.trim() != 'no hay') {
          limpiarFinal(vehiculoBloc, detallesBloc, visualBloc, fotosBloc);
          Navigator.pushNamed(context, 'pdf_viewer');
        } else {
          Fluttertoast.showToast(
              msg: 'Error al generar pdf',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          final listaOrdenBloc =
              Provider.of<ListaOrdenBloc>(context, listen: false);
          listaOrdenBloc.filtrar(context, size, true);
          Navigator.pop(context);
          limpiarFinal(vehiculoBloc, detallesBloc, visualBloc, fotosBloc);
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
  }

  void imprimir() async {}

  void guardarProforma(BuildContext context, Size size) async {
    if (_habilitarGrabar) {
      final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);
      final detallesBloc = Provider.of<DetallesBloc>(context, listen: false);
      final visualBloc = Provider.of<VisualBloc>(context, listen: false);
      Preferencias pref = Preferencias();
      if (pref.usuario!.vehPorDefecto != null &&
          pref.usuario!.vehPorDefecto!.trim().length > 0) {
        vehiculoBloc.placa = pref.usuario!.vehPorDefecto ?? '';
        await vehiculoBloc.buscarVehiculo(context, size, true);
      }
      if (validarDatos(context, vehiculoBloc, detallesBloc)) {
        guardarFinal(context, vehiculoBloc, detallesBloc, visualBloc, size);
      } else {
        Fluttertoast.showToast(
            msg: msj,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Espera un momento",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  bool validarDatos(BuildContext context, VehiculoBloc vehiculoBloc,
      DetallesBloc detallesBloc) {
    bool res = true;

    if (_identificacion.trim().isNotEmpty) {
      if (_nombres.trim().isNotEmpty) {
        if (_telefono.trim().isNotEmpty) {
          if (vehiculoBloc.placa.trim().isNotEmpty) {
            if (vehiculoBloc.modeloSelect.modId != -1) {
              bool pasa = true;
              for (int i = 0; i < vehiculoBloc.lista.length; i++) {
                if (vehiculoBloc.lista[i].carObligatorio == true) {
                  if (vehiculoBloc.lista[i].carSeleccionadble == true) {
                    if (vehiculoBloc.lista[i].idCal == null ||
                        vehiculoBloc.lista[i].idCal == -1) {
                      res = false;
                      msj = 'Debe ingresar el ' +
                          vehiculoBloc.lista[i].carNombre.toUpperCase();
                    }
                  } else {
                    if (vehiculoBloc.lista[i].valor == null ||
                        vehiculoBloc.lista[i].valor!.trim().isEmpty) {
                      res = false;
                      msj = 'Debe ingresar el ' +
                          vehiculoBloc.lista[i].carNombre.toUpperCase();
                    }
                  }
                }
              }
              if (pasa) {
                if (tipo == 1) {
                  if (detallesBloc.detalles.isNotEmpty) {
                  } else {
                    msj = 'Debe ingresar detalles';
                    res = false;
                  }
                }
              }
            } else {
              msj = 'No se ha seleccionado un modelo';
              res = false;
            }
          } else {
            msj = 'No se ha ingresado la placa del vehículo';
            res = false;
          }
        } else {
          msj = 'No se ha ingresado un teléfono';
          res = false;
        }
      } else {
        msj = 'No se ha ingresado los nombres';
        res = false;
      }
    } else {
      msj = 'No se ha ingresado una identificación';
      res = false;
    }
    return res;
  }

  String get pdfArchivo => this._pdfArchivo;
  set pdfArchivo(String dato) {
    this._pdfArchivo = dato;
    notifyListeners();
  }

  String get pdfNombre => this._pdfNombre;
  set pdfNombre(String dato) {
    this._pdfNombre = dato;
    notifyListeners();
  }
}
