// ignore_for_file: unnecessary_this

import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/models/cliente_model.dart';
import 'package:app_ordenes/models/responses/vehiculo_response.dart';
import 'package:app_ordenes/models/services/vehiculo_service.dart';
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

class OrdenBloc extends ChangeNotifier {
  String _identificacion = '';
  String _nombres = '';
  String _apellidos = '';
  String _direccion = '';
  String _observaciones = '';
  String _telefono = '';
  String _correo = '';
  int _idCliente = -1;
  List<Cliente> _clientesFiltrados = [];
  bool _cargandoClientes = true;

  TextEditingController _ctrlIdentificacion = TextEditingController();
  TextEditingController _ctrlNombres = TextEditingController();
  TextEditingController _ctrlApellidos = TextEditingController();
  TextEditingController _ctrlDireccion = TextEditingController();
  TextEditingController _ctrlCorreo = TextEditingController();
  TextEditingController _ctrlTelefono = TextEditingController();
  TextEditingController _ctrlObs = TextEditingController();

  String get identificacion => _identificacion;
  String get nombres => _nombres;
  bool get cargandoClientes => _cargandoClientes;
  String get direccion => _direccion;
  String get telefono => _telefono;
  String get observaciones => _observaciones;

  String get correo => _correo;
  int get idCliente => _idCliente;
  String get apellidos => _apellidos;
  List<Cliente> get clientesFiltrados => _clientesFiltrados;

  TextEditingController get ctrlIdentificacion {
    this._ctrlIdentificacion.text = this._identificacion;
    this._ctrlIdentificacion.selection = TextSelection.fromPosition(
        TextPosition(offset: this._ctrlIdentificacion.text.length));
    return this._ctrlIdentificacion;
  }

  TextEditingController get ctrlObs {
    _ctrlObs.text = this._observaciones;
    this._ctrlObs.selection = TextSelection.fromPosition(
        TextPosition(offset: this._ctrlObs.text.length));
    return this._ctrlObs;
  }

  TextEditingController get ctrlNombres {
    this._ctrlNombres.text = this._nombres;
    this._ctrlNombres.selection = TextSelection.fromPosition(
        TextPosition(offset: this._ctrlNombres.text.length));
    return this._ctrlNombres;
  }

  TextEditingController get ctrlApellidos {
    this._ctrlApellidos.text = this._apellidos;
    this._ctrlApellidos.selection = TextSelection.fromPosition(
        TextPosition(offset: this._ctrlApellidos.text.length));
    return this._ctrlApellidos;
  }

  TextEditingController get ctrlDireccion {
    this._ctrlDireccion.text = this._direccion;
    this._ctrlDireccion.selection = TextSelection.fromPosition(
        TextPosition(offset: this._ctrlDireccion.text.length));
    return this._ctrlDireccion;
  }

  TextEditingController get ctrlCorreo {
    this._ctrlCorreo.text = this._correo;
    this._ctrlCorreo.selection = TextSelection.fromPosition(
        TextPosition(offset: this._ctrlCorreo.text.length));
    return this._ctrlCorreo;
  }

  TextEditingController get ctrlTelefono {
    this._ctrlTelefono.text = this._telefono;
    this._ctrlTelefono.selection = TextSelection.fromPosition(
        TextPosition(offset: this._ctrlTelefono.text.length));
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

  void buscarCliente(BuildContext context, Size size) async {
    Preferencias pref = Preferencias();
    if (_identificacion.trim().isNotEmpty) {
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
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return const DialogoCargando(
                  texto: 'Buscando vehiculos...',
                );
              },
            );
            VehiculoResponse resVeh =
                await VehiculoService.obtenerVehiculosPorCliente(
                    res.cliente!.cliId);
            Navigator.pop(context);
            if (resVeh.ok) {
              final vehiculoBloc =
                  Provider.of<VehiculoBloc>(context, listen: false);
              vehiculoBloc.vehiculosCliente = resVeh.vehiculos ?? [];
            }
            notifyListeners();
          } else {
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
            Fluttertoast.showToast(
                msg: "No se ha encontrado el cliente",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red.shade300,
                textColor: Colors.white,
                fontSize: 16.0);
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
          msg: "Debe ingresar la identificación",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
