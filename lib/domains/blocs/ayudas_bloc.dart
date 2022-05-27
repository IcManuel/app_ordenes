import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/cliente_model.dart';
import 'package:app_ordenes/models/requests/producto_request.dart';
import 'package:app_ordenes/models/requests/vehiculo_request.dart';
import 'package:app_ordenes/models/services/cliente_service.dart';
import 'package:app_ordenes/models/services/vehiculo_service.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';
import 'package:flutter/material.dart';

class AyudaBloc extends ChangeNotifier {
  String _filtro = '';
  bool _habNombre = false;
  bool _habIdent = false;
  bool _escribiendo = false;
  bool _consultando = false;
  List<Cliente> _clientes = [];
  TextEditingController _ctrlFiltro = TextEditingController();
  bool _mostrarLista = false;

  String _filtroV = '';
  bool _escribiendoV = false;
  bool _consultandoV = false;
  List<Vehiculo> _vehiculos = [];
  TextEditingController _ctrlFiltroV = TextEditingController();

  bool get habNombre => _habNombre;
  bool get habIdent => _habIdent;
  bool get mostrarLista => _mostrarLista;
  String get filtro => _filtro;
  bool get escribiendo => _escribiendo;
  bool get consultando => _consultando;
  List<Cliente> get clientes => _clientes;

  String get filtroV => _filtroV;
  bool get escribiendoV => _escribiendoV;
  bool get consultandoV => _consultandoV;
  List<Vehiculo> get vehiculos => _vehiculos;

  TextEditingController get ctrlFiltro {
    _ctrlFiltro.text = _filtro;
    _ctrlFiltro.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlFiltro.text.length));
    return _ctrlFiltro;
  }

  void inicializar() {
    _escribiendo = false;
    _mostrarLista = false;
    _habIdent = true;
    _habNombre = true;
    _consultando = false;
    _clientes = [];
    notifyListeners();
  }

  set habNombre(bool m) {
    _habNombre = m;
    notifyListeners();
  }

  set habIdent(bool m) {
    _habIdent = m;
    notifyListeners();
  }

  set mostrarLista(bool m) {
    _mostrarLista = m;
    notifyListeners();
  }

  set clientes(List<Cliente> c) {
    _clientes = c;
    notifyListeners();
  }

  set filtro(String f) {
    _filtro = f;
    notifyListeners();
  }

  set escribiendo(bool b) {
    _escribiendo = b;
    notifyListeners();
  }

  set consultando(bool b) {
    _consultando = b;
    notifyListeners();
  }

  TextEditingController get ctrlFiltroV {
    _ctrlFiltroV.text = _filtroV;
    _ctrlFiltroV.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlFiltroV.text.length));
    return _ctrlFiltroV;
  }

  set vehiculos(List<Vehiculo> c) {
    _vehiculos = c;
    notifyListeners();
  }

  set filtroV(String f) {
    _filtroV = f;
    notifyListeners();
  }

  set escribiendoV(bool b) {
    _escribiendoV = b;
    notifyListeners();
  }

  set consultandoV(bool b) {
    _consultandoV = b;
    notifyListeners();
  }

  void abrirAyudaCliente(BuildContext context, int tipo, String valor) {
    _escribiendo = false;
    //_clientes = [];

    _filtro = valor;
    _ctrlFiltro.text = _filtro;
    if (_filtro.trim().isNotEmpty) {
      if (!_consultando) {
        cargarLista(Preferencias(), tipo, context);
      }
    }
    Navigator.pushNamed(context, 'ayuda_cliente', arguments: {
      'tipo': tipo,
    });
  }

  void abrirAyudaVehiculo(BuildContext context, String valor) {
    _escribiendoV = false;
    //_clientes = [];

    _filtroV = valor;
    _ctrlFiltroV.text = _filtroV;
    if (_filtroV.trim().isNotEmpty) {
      if (!_consultandoV) {
        cargarListaVehiculos(Preferencias().empresa);
      }
    }
    Navigator.pushNamed(context, 'ayuda_busqueda_vehiculo');
  }

  void cargarLista(Preferencias pref, int tipo, BuildContext context) async {
    _consultando = true;
    _clientes = await ClienteService.obtenerClientesLista(
      ProductoRequest(
        empresa: pref.empresa,
        cadena: _filtro,
        tipoFiltro: tipo,
      ),
      context,
    );
    if (tipo == 2) {
      _habIdent = true;
    } else {
      _habNombre = true;
    }
    _consultando = false;
    notifyListeners();
  }

  void cargarListaVehiculos(int empresa) async {
    _consultandoV = true;
    _vehiculos = await VehiculoService.obtenerVehiculosPorPlaca(
        VehiculoRequest(empresa: empresa, placa: _filtroV));

    _consultandoV = false;
    notifyListeners();
  }
}
