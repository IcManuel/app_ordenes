import 'dart:typed_data';

import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class OrdenBloc extends ChangeNotifier {
  String _tipoIdentificacion = 'CEDULA';
  String _identificacion = '';
  int tipoFiltro = 1;
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
  SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
  );
  FotoModel _firma = FotoModel(imagen: XFile(''), nombre: '');

  Cliente nuevo = Cliente(
    cliId: -1,
    cliIdentificacion: "",
    cliApellidos: "",
    cliCelular: "",
    cliCorreo: "",
    cliDireccion: "",
    cliNombres: "",
    cliTipoIdentificacion: "1",
    eprId: -1,
  );

  TextEditingController _ctrlIdentificacion = TextEditingController();
  TextEditingController _ctrlNombres = TextEditingController();
  TextEditingController _ctrlApellidos = TextEditingController();
  TextEditingController _ctrlDireccion = TextEditingController();
  TextEditingController _ctrlCorreo = TextEditingController();
  TextEditingController _ctrlTelefono = TextEditingController();
  TextEditingController _ctrlObs = TextEditingController();
  TextEditingController _ctrlObsUsu = TextEditingController();

  SignatureController get controller => _controller;
  String get identificacion => _identificacion;
  String get tipoIdentificacion => _tipoIdentificacion;
  String get nombres => _nombres;
  bool get cargandoClientes => _cargandoClientes;
  String get direccion => _direccion;
  int get numeroOrden => _numeroOrden!;
  String get telefono => _telefono;
  String get observaciones => _observaciones;
  String get observacionesUsu => _observacionesUsu;
  bool get modificar => _modificar;
  bool get habilitarGrabar => _habilitarGrabar;
  FotoModel get firma => _firma;
  String get correo => _correo;
  int get tipo => _tipo;
  int get idCliente => _idCliente;
  String get apellidos => _apellidos;
  List<Cliente> get clientesFiltrados => _clientesFiltrados;

  void nuevoCliente(BuildContext context) {
    _tipoIdentificacion = "CEDULA";
    nuevo = Cliente(
      cliId: -1,
      cliIdentificacion: "",
      cliApellidos: "",
      cliCelular: "",
      cliCorreo: "",
      cliDireccion: "",
      cliNombres: "",
      cliTipoIdentificacion: "1",
      eprId: -1,
    );
    notifyListeners();
    Navigator.pushNamed(context, 'ayuda_cliente');
  }

  void limpiarFirma() {
    _firma = FotoModel(imagen: XFile(''), nombre: '');
    _controller.clear();
    notifyListeners();
  }

  void volverImagen() {
    if (_firma.imagen.path.isEmpty) {
      _controller.clear();
    }
    notifyListeners();
  }

  void guardarFirma(BuildContext context) async {
    DateTime d = DateTime.now();
    if (_controller.isNotEmpty) {
      final Uint8List? data = await _controller.toPngBytes();
      if (data != null) {
        final directory = await getApplicationDocumentsDirectory();
        final pathOfImage = await File('${directory.path}/firma_' +
                d.millisecondsSinceEpoch.toString() +
                '.png')
            .create();
        final Uint8List bytes = data.buffer.asUint8List();
        await pathOfImage.writeAsBytes(bytes);
        _firma =
            FotoModel(imagen: XFile(pathOfImage.path), nombre: 'firma.png');
        notifyListeners();
        Navigator.pop(context);
      }
    } else {
      _firma = FotoModel(imagen: XFile(''), nombre: '');
      notifyListeners();
      Navigator.pop(context);
    }
  }

  void guardarNuevo(BuildContext context, Size size) async {
    String msg = "";
    bool pasa = true;
    if (nuevo.cliIdentificacion.trim().isNotEmpty) {
      bool pasaI = true;
      if ((Preferencias().usuario!.validarCedula ?? false) == true) {
        String tipo = (_tipoIdentificacion == "CEDULA"
            ? "1"
            : (_tipoIdentificacion == "RUC" ? "2" : "3"));
        pasaI = validarCedula(tipo, nuevo.cliIdentificacion);
      }
      if (pasaI) {
        if ((nuevo.cliCelular ?? '').trim().isNotEmpty) {
          if ((nuevo.cliCorreo ?? '').trim().isNotEmpty) {
            if ((nuevo.cliDireccion ?? '').trim().isNotEmpty) {
            } else {
              pasa = false;
              msg = 'Debe ingresar una dirección';
            }
          } else {
            pasa = false;
            msg = 'Debe ingresar un correo';
          }
        } else {
          pasa = false;
          msg = 'Debe ingresar un teléfono';
        }
      } else {
        pasa = false;
        msg = 'La identificación ingresada es inválida';
      }
    } else {
      pasa = false;
      msg = 'Debe ingresar la identificación';
    }

    if (pasa) {
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
              texto: 'Guardando cliente......',
            );
          },
        );
        nuevo.eprId = Preferencias().empresa;
        MarcaResponse res = await ClienteService.crearCliente(nuevo);
        Navigator.pop(context);
        if (res.ok == true) {
          _idCliente = res.uid!;
          _nombres = nuevo.cliNombres!;
          _apellidos = nuevo.cliApellidos!;
          _direccion = nuevo.cliDireccion!;
          _telefono = nuevo.cliCelular!;
          _correo = nuevo.cliCorreo!;
          _identificacion = nuevo.cliIdentificacion;

          _ctrlNombres.text = nuevo.cliNombres!;
          _ctrlApellidos.text = nuevo.cliApellidos!;
          _ctrlDireccion.text = nuevo.cliDireccion!;
          _ctrlTelefono.text = nuevo.cliCelular!;
          _ctrlCorreo.text = nuevo.cliCorreo!;
          _ctrlIdentificacion.text = _identificacion;
          Navigator.pop(context);
          notifyListeners();
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
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

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

  void inicializar() {
    _habilitarGrabar = false;
    _modificar = false;
    idOrden = -1;
    _habilitarGrabar = true;
  }

  void setearDatosSelect(Orden orden) {
    _firma = FotoModel(imagen: XFile(''), nombre: '');
    _controller.clear();
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

    if (orden.cliente.cliTipoIdentificacion != null) {
      if (orden.cliente.cliTipoIdentificacion == "1") {
        _tipoIdentificacion = "CEDULA";
      } else if (orden.cliente.cliTipoIdentificacion == "2") {
        _tipoIdentificacion = "RUC";
      } else {
        _tipoIdentificacion = "PASAPORTE";
      }
    } else {
      _tipoIdentificacion = "CEDULA";
    }

    notifyListeners();
  }

  void seleccionar(BuildContext context, Cliente pro) async {
    final ayudaBloc = Provider.of<AyudaBloc>(context, listen: false);
    _idCliente = pro.cliId;
    _identificacion = pro.cliIdentificacion;
    _nombres = pro.cliNombres!;
    if (tipoFiltro == 2) {
      ayudaBloc.filtro = _nombres;
    } else {
      ayudaBloc.filtro = _identificacion;
    }

    _telefono = pro.cliCelular!;
    _correo = pro.cliCorreo!;
    _direccion = pro.cliDireccion!;
    _ctrlCorreo.text = _correo;
    _ctrlTelefono.text = _telefono;
    _ctrlNombres.text = _nombres;
    _ctrlIdentificacion.text = _identificacion;
    _ctrlDireccion.text = _direccion;

    if (pro.cliTipoIdentificacion != null) {
      if (pro.cliTipoIdentificacion == "1") {
        _tipoIdentificacion = "CEDULA";
      } else if (pro.cliTipoIdentificacion == "2") {
        _tipoIdentificacion = "RUC";
      } else {
        _tipoIdentificacion = "PASAPORTE";
      }
    } else {
      _tipoIdentificacion = "CEDULA";
    }
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
    if (resVeh.ok) {
      final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);
      vehiculoBloc.vehiculosCliente = resVeh.vehiculos ?? [];
    }

    ayudaBloc.inicializar();
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

  set tipoIdentificacion(String i) {
    _tipoIdentificacion = i;
    notifyListeners();
  }

  void limpiar() {
    _identificacion = '';
  }

  void cambioIdentificacion(BuildContext context, String e, int tipo) {
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
        if (tipo == 2) {
          _ctrlIdentificacion.text = '';
        } else {
          _ctrlNombres.text = '';
        }

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

            if (res.cliente!.cliTipoIdentificacion != null) {
              if (res.cliente!.cliTipoIdentificacion == "1") {
                _tipoIdentificacion = "CEDULA";
              } else if (res.cliente!.cliTipoIdentificacion == "2") {
                _tipoIdentificacion = "RUC";
              } else {
                _tipoIdentificacion = "PASAPORTE";
              }
            } else {
              _tipoIdentificacion = "CEDULA";
            }
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
    _firma = FotoModel(imagen: XFile(''), nombre: '');
    _controller.clear();
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
        cliTipoIdentificacion: _tipoIdentificacion == "CEDULA"
            ? "1"
            : _tipoIdentificacion == "RUC"
                ? "2"
                : "3",
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

      if (_firma.imagen.path.isNotEmpty) {
        String pathFnal = join(path, _firma.imagen.name);
        final File imagenCache = File(_firma.imagen.path);
        imagenCache.copy(pathFnal);
        await ImagenService.uploadImage(_firma.imagen.path);
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
        firma: (_firma.imagen.path.isNotEmpty ? _firma.imagen.name : null),
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

  guardarProforma(BuildContext context, Size size) async {
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
    final visualBloc = Provider.of<VisualBloc>(context, listen: false);
    if (visualBloc.lista.length > 0) {
      if (idCliente != -1) {
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
        msj = 'Debe seleccionar un cliente';
        res = false;
      }
    } else {
      msj = 'No se han cargado las opciones visuales, por favor, refrescar';
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
