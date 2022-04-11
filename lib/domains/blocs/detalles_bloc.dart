import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/dorden_model.dart';
import 'package:app_ordenes/models/marca_producto_model.dart';
import 'package:app_ordenes/models/producto_model.dart';
import 'package:app_ordenes/models/requests/producto_request.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
import 'package:app_ordenes/models/services/modelo_service.dart';
import 'package:app_ordenes/models/services/producto_service.dart';
import 'package:app_ordenes/models/tipo_producto_model.dart';
import 'package:app_ordenes/ui/widgets/dialogo_cargando_widget.dart';
import 'package:app_ordenes/ui/widgets/dialogo_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetallesBloc extends ChangeNotifier {
  bool _escribiendo = false;
  bool _consultando = false;
  bool _cargandoTipos = false;
  bool _inventario = false;
  bool _cargandoMarcas = false;

  String _nombre = '';
  String _codigo = '';
  String _filtroMarca = '';
  String _filtroTipo = '';

  TipoProducto? _tipoSelect = TipoProducto(
      tprId: -1, tprCodigo: '', tprNombre: '', eprId: -1, activo: false);
  MarcaProducto? _marcaSelect = MarcaProducto(
      mprId: -1, mprCodigo: '', mprNombre: '', eprId: -1, activo: false);

  String _filtro = '';
  List<Dorden> _detalles = [];
  bool _mostrarFormulario = false;
  double _cantidad = 0.00;
  double _precio = 0.00;
  double _total = 0.00;
  Producto _producto = Producto(
    proId: -1,
    proCodigo: '',
    proNombre: '',
    proInventario: false,
    tprId: -1,
    tprCodigo: '',
    tprNombre: '',
    mprId: -1,
    mprCodigo: '',
    mprNombre: '',
  );

  List<Producto> _productos = [];
  List<TipoProducto> _tipos = [];
  List<TipoProducto> _tiposFiltrados = [];

  List<MarcaProducto> _marcas = [];
  List<MarcaProducto> _marcasFiltrados = [];

  String get codigo => _codigo;
  List<TipoProducto> get tipos => _tipos;
  List<TipoProducto> get tiposFiltrados => _tiposFiltrados;
  List<MarcaProducto> get marcas => _marcas;
  List<MarcaProducto> get marcasFiltradas => _marcasFiltrados;
  String get nombre => _nombre;
  TipoProducto get tipoSelect => _tipoSelect!;
  MarcaProducto get marcaSelect => _marcaSelect!;
  List<Producto> get productos => _productos;
  bool get cargandoTipos => _cargandoTipos;
  bool get cargandoMarcas => _cargandoMarcas;
  bool get inventario => _inventario;
  Producto get producto => _producto;
  bool get mostrarFormulario => _mostrarFormulario;
  double get cantidad => _cantidad;
  double get precio => _precio;
  double get total => _total;
  String get filtro => _filtro;
  String get filtroTipo => _filtroTipo;
  String get filtroMarca => _filtroMarca;
  List<Dorden> get detalles => _detalles;
  bool get escribiendo => _escribiendo;
  bool get consultando => _consultando;

  final TextEditingController _ctrlCantidad = TextEditingController();
  final TextEditingController _ctrlPrecio = TextEditingController();
  final TextEditingController _ctrlTotal = TextEditingController();

  final TextEditingController _ctrlTipoProducto = TextEditingController();
  final TextEditingController _ctrlFiltroTipoProducto = TextEditingController();
  final TextEditingController _ctrlMarcaProducto = TextEditingController();
  final TextEditingController _ctrlFiltroMarcaProducto =
      TextEditingController();

  TextEditingController get ctrlCantidad => _ctrlCantidad;
  TextEditingController get ctrlTotal => _ctrlTotal;
  TextEditingController get ctrlPrecio => _ctrlPrecio;
  TextEditingController get ctrlTipoProducto => _ctrlTipoProducto;
  TextEditingController get ctrlFiltroTipoProducto => _ctrlFiltroTipoProducto;
  TextEditingController get ctrlMarcaProducto => _ctrlMarcaProducto;
  TextEditingController get ctrlFiltroMarcaProducto => _ctrlMarcaProducto;

  void abrirAyudaProducto(BuildContext context, int tipo) {
    _escribiendo = false;
    _productos = [];
    _filtro = '';
    Navigator.pushNamed(context, 'ayuda_producto', arguments: {
      'tipo': tipo,
    });
  }

  void cargarLista(Preferencias pref, int tipo) async {
    _consultando = true;
    _productos = await ProductoService.obtenerProductosLista(
      ProductoRequest(
        empresa: pref.empresa,
        tipo: -1,
        marca: -1,
        cadena: _filtro,
        tipoFiltro: tipo,
      ),
    );

    _consultando = false;
    notifyListeners();
  }

  void abrirNuevoDetalle() {
    _producto = Producto(
      proId: -1,
      proCodigo: '',
      proNombre: '',
      proInventario: false,
      tprId: -1,
      tprCodigo: '',
      tprNombre: '',
      mprId: -1,
      mprCodigo: '',
      mprNombre: '',
    );
    _cantidad = 0;
    _precio = 0;
    _total = 0;
    _mostrarFormulario = true;
    _ctrlCantidad.text = '0';
    _ctrlTotal.text = '0';
    _ctrlPrecio.text = '0';
    notifyListeners();
  }

  void abrirCrearProducto(BuildContext context) {
    _nombre = '';
    _codigo = '';
    _ctrlMarcaProducto.text = '';
    _ctrlTipoProducto.text = '';
    _tipoSelect = TipoProducto(
        tprId: -1, tprCodigo: '', tprNombre: '', eprId: -1, activo: false);
    _marcaSelect = MarcaProducto(
        mprId: -1, mprCodigo: '', mprNombre: '', eprId: -1, activo: false);
    notifyListeners();

    Navigator.pushNamed(context, 'crear_producto');
  }

  void guardarProducto(
    BuildContext context,
    Size size,
  ) async {
    Preferencias pref = Preferencias();
    if (_codigo.trim().isNotEmpty) {
      if (_nombre.trim().isNotEmpty) {
        if (_tipoSelect!.tprId != -1) {
          if (_marcaSelect!.mprId != -1) {
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
                    texto: 'Enviado producto......',
                  );
                },
              );
              MarcaResponse res = await ModeloService.insertarProducto(
                Producto(
                  proId: -1,
                  proCodigo: _codigo,
                  proNombre: _nombre,
                  proInventario: _inventario,
                  tprId: _tipoSelect!.tprId,
                  tprCodigo: "",
                  tprNombre: "",
                  mprId: _marcaSelect!.mprId,
                  mprCodigo: "",
                  mprNombre: "",
                  eprId: pref.empresa,
                ),
              );
              Navigator.pop(context);

              if (res.ok == true) {
                Producto mar = Producto(
                    proId: res.uid!,
                    proCodigo: _codigo,
                    proNombre: _nombre,
                    proInventario: _inventario,
                    tprId: _tipoSelect!.tprId,
                    tprCodigo: _tipoSelect!.tprCodigo,
                    tprNombre: _tipoSelect!.tprNombre,
                    mprId: _marcaSelect!.mprId,
                    mprCodigo: _marcaSelect!.mprCodigo,
                    mprNombre: _marcaSelect!.mprNombre);
                _producto = mar;
                Navigator.pop(context);
                Navigator.pop(context);
                Fluttertoast.showToast(
                  msg: "Producto guardado correctamente",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green.shade300,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
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
                msg: "Debe seleccionar la marca",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Debe seleccionar el tipo",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Debe ingresar el nombre",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Debe ingresar el código",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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
        Navigator.pushNamed(context, 'ayuda_marca_producto');
      } else {
        _filtroMarca = '';
        _ctrlFiltroMarcaProducto.text = '';
      }
      MarcaResponse res =
          await ModeloService.buscarMarcaProductos(pref.empresa);
      if (res.ok == true) {
        _marcas = res.marcaProductos!;
        _marcasFiltrados = res.marcaProductos!;
        _cargandoMarcas = false;

        if (_marcasFiltrados.isEmpty) {
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
        _cargandoMarcas = false;
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
      _cargandoMarcas = false;
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

  void abrirAyudaTipo(
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
    _cargandoTipos = true;
    final conect = await verificarConexion();
    Navigator.pop(context);
    if (conect) {
      if (cargarPagina) {
        Navigator.pushNamed(context, 'ayuda_tipo_producto');
      } else {
        _filtroTipo = '';
        _ctrlFiltroTipoProducto.text = '';
      }
      MarcaResponse res = await ModeloService.buscarTipoProductos(pref.empresa);
      if (res.ok == true) {
        _tipos = res.tipoProductos!;
        _tiposFiltrados = res.tipoProductos!;
        _cargandoTipos = false;

        if (_tiposFiltrados.isEmpty) {
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
        _cargandoTipos = false;
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
      _cargandoTipos = false;
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

  void filtrarTipos(String v) {
    _tiposFiltrados = _tipos.where((f) {
      return f.tprNombre.toLowerCase().contains(v.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void cargarTipos() {
    _tiposFiltrados = _tipos;
    notifyListeners();
  }

  void filtrarMarcas(String v) {
    _marcasFiltrados = _marcas.where((f) {
      return f.mprNombre.toLowerCase().contains(v.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void cargarMarcas() {
    _ctrlFiltroMarcaProducto.text = '';
    _filtroMarca = '';
    _marcasFiltrados = _marcas;
    notifyListeners();
  }

  set marcas(List<MarcaProducto> m) {
    _marcas = m;
    notifyListeners();
  }

  set marcasFiltradas(List<MarcaProducto> m) {
    _marcasFiltrados = m;
    notifyListeners();
  }

  set inventario(bool v) {
    _inventario = v;
    notifyListeners();
  }

  set tipos(List<TipoProducto> m) {
    _tipos = m;
    notifyListeners();
  }

  set tiposFiltrados(List<TipoProducto> m) {
    _tiposFiltrados = m;
    notifyListeners();
  }

  set productos(List<Producto> l) {
    _productos = l;
    notifyListeners();
  }

  set codigo(String b) {
    _codigo = b;
    notifyListeners();
  }

  set nombre(String b) {
    _nombre = b;
    notifyListeners();
  }

  set filtroTipo(String b) {
    _filtroTipo = b;
    notifyListeners();
  }

  set filtroMarca(String b) {
    _filtroMarca = b;
    notifyListeners();
  }

  set tipoSelect(TipoProducto tipo) {
    _tipoSelect = tipo;
    notifyListeners();
  }

  set marcaSelect(MarcaProducto tipo) {
    _marcaSelect = tipo;
    notifyListeners();
  }

  set escribiendo(bool b) {
    _escribiendo = b;
    notifyListeners();
  }

  set cargandoMarcas(bool b) {
    _cargandoMarcas = b;
    notifyListeners();
  }

  set cargandoTipos(bool b) {
    _cargandoTipos = b;
    notifyListeners();
  }

  set filtro(String f) {
    _filtro = f;
    notifyListeners();
  }

  set consultando(bool b) {
    _consultando = b;
    notifyListeners();
  }

  set detalles(List<Dorden> d) {
    _detalles = d;
    notifyListeners();
  }

  set cantidad(double c) {
    _cantidad = c;
    notifyListeners();
  }

  set precio(double c) {
    _precio = c;
    notifyListeners();
  }

  set total(double c) {
    _total = c;
    notifyListeners();
  }

  set producto(Producto p) {
    _producto = p;
    notifyListeners();
  }

  set mostrarFormulario(bool b) {
    _mostrarFormulario = b;
    notifyListeners();
  }
}