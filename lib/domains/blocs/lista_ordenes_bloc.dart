import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/blocs/visual_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/foto_model.dart';
import 'package:app_ordenes/models/imagen_model.dart';
import 'package:app_ordenes/models/orden_model.dart';
import 'package:app_ordenes/models/requests/filtro_orden_request.dart';
import 'package:app_ordenes/models/requests/pdf_request.dart';
import 'package:app_ordenes/models/responses/detalle_response.dart';
import 'package:app_ordenes/models/responses/orden_response.dart';
import 'package:app_ordenes/models/services/imagen_service.dart';
import 'package:app_ordenes/models/services/orden_service.dart';
import 'package:app_ordenes/ui/widgets/dialogo_cargando_widget.dart';
import 'package:app_ordenes/ui/widgets/dialogo_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';

class ListaOrdenBloc extends ChangeNotifier {
  List<Orden> _lista = [];
  bool _cargando = false;
  String _placa = '';
  String _cliente = '';
  DateTime _fechaI = DateTime.now();
  DateTime _fechaF = DateTime.now();
  int _estado = -1;

  List<Orden> _listaH = [];
  bool _cargandoH = false;
  String _placaH = '';

  int get estado => _estado;

  set estado(int value) {
    _estado = value;
    notifyListeners();
  }

  List<Orden> get lista => _lista;
  bool get cargando => _cargando;
  String get placa => _placa;
  List<Orden> get listaH => _listaH;
  bool get cargandoH => _cargandoH;
  String get placaH => _placaH;

  String get cliente => _cliente;
  DateTime get fechaI => _fechaI;
  DateTime get fechaF => _fechaF;

  set cargando(bool c) {
    _cargando = c;
    notifyListeners();
  }

  set lista(List<Orden> o) {
    _lista = o;
    notifyListeners();
  }

  set placa(value) {
    _placa = value;
    notifyListeners();
  }

  set cargandoH(bool c) {
    _cargandoH = c;
    notifyListeners();
  }

  set listaH(List<Orden> o) {
    _listaH = o;
    notifyListeners();
  }

  set placaH(value) {
    _placaH = value;
    notifyListeners();
  }

  set cliente(value) {
    _cliente = value;
    notifyListeners();
  }

  set fechaI(value) {
    _fechaI = value;
    notifyListeners();
  }

  set fechaF(value) {
    _fechaF = value;
    notifyListeners();
  }

  void modificar(BuildContext context, Orden orden, Size size) async {
    final ordenBloc = Provider.of<OrdenBloc>(context, listen: false);
    final detallesBloc = Provider.of<DetallesBloc>(context, listen: false);
    final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);
    final visualBloc = Provider.of<VisualBloc>(context, listen: false);
    final fotosBloc = Provider.of<FotosBloc>(context, listen: false);
    ordenBloc.habilitarGrabar = false;
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
            texto: 'Obteniendo información',
          );
        },
      );
      ordenBloc.setearDatosSelect(orden);
      vehiculoBloc.setearDatos(orden);
      visualBloc.cargarVisualesOrden(orden);
      DetalleResponse res = await OrdenService.obtenerDetalles(orden.corId);
      if (res.ok) {
        detallesBloc.detalles = res.detalles!;
        print(detallesBloc.detalles.length);
        detallesBloc.calcularTotalFinal();
      }
      DetalleResponse imgRes = await OrdenService.obtenerImagenes(orden.corId);
      List<FotoModel> fotosEntrega = [];
      List<FotoModel> fotosRecibo = [];
      if (res.ok) {
        for (ImagenModel img in imgRes.imagenes!) {
          String path = await ImagenService.downloadImage(img.imagen);
          if (img.tipo == 1) {
            XFile imag = XFile(path);
            fotosRecibo.add(FotoModel(imagen: imag, nombre: img.imagen));
          }
          if (img.tipo == 2) {
            XFile imag = XFile(path);
            fotosEntrega.add(FotoModel(imagen: imag, nombre: img.imagen));
          }
        }
        fotosBloc.fotos = fotosRecibo;
        fotosBloc.fotosEntrega = fotosEntrega;
      }
      Navigator.pop(context);
      Navigator.pushNamed(context, 'orden');
      ordenBloc.habilitarGrabar = true;
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

  Future<bool> eliminarFinal(BuildContext context, Orden orden) async {
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
        barrierDismissible: true,
        builder: (_) {
          return const DialogoCargando(
            texto: 'Consultando orden......',
          );
        },
      );
      DetalleResponse det = await OrdenService.eliminarOrden(orden.corId);
      Navigator.pop(context);
      if (det.ok) {
        return true;
      } else {
        Fluttertoast.showToast(
          msg: det.msg!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade300,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    } else {
      Fluttertoast.showToast(
        msg: 'No hay conexión a internet',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade300,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  void eliminar(BuildContext context, Orden orden, Size size) async {
    if (orden.corEstado == 4) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmar'),
              content: SingleChildScrollView(
                child: Column(
                  children: const [
                    Text(
                        '¿Está seguro que desea eliminar la orden, los datos se perderán?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () async {
                    bool res = await eliminarFinal(context, orden);
                    if (res) {
                      Fluttertoast.showToast(
                        msg: 'Orden eliminada correctamente',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green.shade300,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      filtrar(context, size, true);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      Fluttertoast.showToast(
        msg: 'No se puede eliminar una orden guardad',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void consultar(BuildContext context, Orden orden, Size size) async {
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
        barrierDismissible: true,
        builder: (_) {
          return const DialogoCargando(
            texto: 'Consultando orden......',
          );
        },
      );
      await OrdenService.obtenerPdf(
        context,
        PdfRequest(
          id: orden.corId,
          empresa: Preferencias().empresa,
          crear: false,
        ),
      );
      Navigator.pop(context);
      final blocProforma = Provider.of<OrdenBloc>(context, listen: false);
      if (blocProforma.pdfArchivo != '' &&
          blocProforma.pdfArchivo != 'no hay') {
        await OpenFile.open(blocProforma.pdfArchivo);
      } else {
        Fluttertoast.showToast(
          msg: "Error al obtener el PDF",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade300,
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

  void filtrar(BuildContext context, Size size, bool interno) async {
    _lista = [];
    _cargando = true;
    if (interno == false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const DialogoCargando(
            texto: 'Revisando conexión',
          );
        },
      );
    }
    final conect = await verificarConexion();
    if (interno == false) Navigator.pop(context);
    if (conect) {
      interno == false
          ? showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return const DialogoCargando(
                  texto: 'Consultando órdenes......',
                );
              },
            )
          : null;
      Preferencias pref = Preferencias();
      OrdenResponse res = await OrdenService.obtenerOrdenes(FiltroOrdenRequest(
        empresa: pref.empresa,
        fechai: DateFormat('dd-MM-yyyy').format(_fechaI),
        fechaf: DateFormat('dd-MM-yyyy').format(_fechaF),
        placa: _placa,
        cliente: _cliente,
        estado: _estado,
        usuario: pref.usuario!.usuId,
      ));

      if (interno == false) Navigator.pop(context);
      if (res.ok) {
        _cargando = false;
        _lista = res.ordenes!;
        if (_lista.isEmpty) {
          if (interno == false) {
            Fluttertoast.showToast(
              msg: "No existen datos...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green.shade300,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
        notifyListeners();
      } else {
        _cargando = false;
        if (interno == false) {
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
    } else {
      _cargando = false;
      if (interno == false) {
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
  }

  void buscarHistorial(BuildContext context, Size size, String p) async {
    _placaH = p;
    _listaH = [];
    _cargandoH = true;
    final conect = await verificarConexion();
    if (conect) {
      var fechaI = DateTime.now().subtract(const Duration(
        days: 365 * 5,
      ));
      Preferencias pref = Preferencias();
      OrdenResponse res = await OrdenService.obtenerOrdenes(FiltroOrdenRequest(
        empresa: pref.empresa,
        fechai: DateFormat('dd-MM-yyyy').format(fechaI),
        fechaf: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        placa: _placaH,
        cliente: '',
        estado: 2,
        usuario: pref.usuario!.usuId,
      ));
      if (res.ok) {
        _cargandoH = false;
        _listaH = res.ordenes!;
        notifyListeners();
      } else {
        _cargandoH = false;
        notifyListeners();
      }
    } else {
      _cargandoH = false;
      notifyListeners();
    }
  }
}
