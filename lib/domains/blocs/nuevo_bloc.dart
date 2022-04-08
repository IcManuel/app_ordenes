import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/models/modelo_model.dart';
import 'package:app_ordenes/ui/widgets/dlg_nuevo_modelo.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/marca_model.dart';
import 'package:app_ordenes/models/responses/marca_response.dart';
import 'package:app_ordenes/models/services/modelo_service.dart';
import 'package:app_ordenes/ui/widgets/dialogo_cargando_widget.dart';
import 'package:app_ordenes/ui/widgets/dialogo_general_widget.dart';
import 'package:app_ordenes/ui/widgets/dlg_nueva_marca.dart';
import 'package:flutter/material.dart';

class NuevoBloc extends ChangeNotifier {
  String _codigo = "";
  String _nombre = "";

  String _codigoModelo = "";
  String _nombreModelo = "";

  TextEditingController _ctrlCodigo = TextEditingController();
  TextEditingController _ctrlNombre = TextEditingController();
  TextEditingController _ctrlCodigoModelo = TextEditingController();
  TextEditingController _ctrlNombreModelo = TextEditingController();

  String get codigo => _codigo;
  String get nombre => _nombre;
  String get codigoModelo => _codigoModelo;
  String get nombreModelo => _nombreModelo;

  set codigo(String c) {
    _codigo = c;
    notifyListeners();
  }

  set nombre(String c) {
    _nombre = c;
    notifyListeners();
  }

  set codigoModelo(String c) {
    _codigoModelo = c;
    notifyListeners();
  }

  set nombreModelo(String c) {
    _nombreModelo = c;
    notifyListeners();
  }

  TextEditingController get ctrlCodigo {
    _ctrlCodigo.text = _codigo;
    _ctrlCodigo.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlCodigo.text.length));
    return _ctrlCodigo;
  }

  TextEditingController get ctrlNombre {
    _ctrlNombre.text = _nombre;
    _ctrlNombre.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlNombre.text.length));
    return _ctrlNombre;
  }

  TextEditingController get ctrlCodigoModelo {
    _ctrlCodigoModelo.text = _codigoModelo;
    _ctrlCodigoModelo.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlCodigoModelo.text.length));
    return _ctrlCodigoModelo;
  }

  TextEditingController get ctrlNombreModelo {
    _ctrlNombreModelo.text = _nombreModelo;
    _ctrlNombreModelo.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrlNombreModelo.text.length));
    return _ctrlNombreModelo;
  }

  void abrirCrearMarca(BuildContext context, Size size) {
    _codigo = '';
    _nombre = '';
    ctrlCodigo.text = '';
    ctrlNombre.text = '';
    notifyListeners();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const DialogoNuevaMarca();
        });
  }

  void abrirCrearModelo(BuildContext context, Size size) {
    final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);

    if (vehiculoBloc.marcaSelect.marId != -1) {
      _codigoModelo = '';
      _nombreModelo = '';
      ctrlCodigoModelo.text = '';
      ctrlNombreModelo.text = '';
      notifyListeners();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return const DialogoNuevoModelo();
          });
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
              texto: 'Debe seleccionar una marca para crear un modelo',
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

  void crearMarca(BuildContext context, Size size) async {
    Preferencias pref = Preferencias();
    if (_codigo.isNotEmpty) {
      if (_nombre.isNotEmpty) {
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
                texto: 'Enviado marca......',
              );
            },
          );
          MarcaResponse res = await ModeloService.insertarMarca(Marca(
            marId: -1,
            eprId: pref.empresa,
            marCodigo: _codigo,
            marNombre: _nombre,
            marActivo: true,
          ));
          Navigator.pop(context);

          if (res.ok == true) {
            final vehiculoBloc =
                Provider.of<VehiculoBloc>(context, listen: false);

            Marca mar = Marca(
                marId: res.uid!,
                eprId: pref.empresa,
                marCodigo: _codigo,
                marNombre: _nombre,
                marActivo: true);

            vehiculoBloc.marcas = [...vehiculoBloc.marcas, mar];
            vehiculoBloc.ctrlFiltroMarca.text = '';
            vehiculoBloc.cargarMarcas();
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: "Marca guardada correctamente",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green.shade300,
              textColor: Colors.white,
              fontSize: 16.0,
            );
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
        showDialog(
            context: context,
            builder: (_) {
              return DialogoGeneral(
                size: size,
                lottie: 'assets/lotties/error_lottie.json',
                mostrarBoton1: true,
                mostrarBoton2: false,
                titulo: 'ALERTA',
                texto: 'Debe ingresar el nombre',
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
              lottie: 'assets/lotties/error_lottie.json',
              mostrarBoton1: true,
              mostrarBoton2: false,
              titulo: 'ALERTA',
              texto: 'Debe ingresar el código',
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

  void crearModelo(BuildContext context, Size size) async {
    final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);
    if (_codigoModelo.isNotEmpty) {
      if (_nombreModelo.isNotEmpty) {
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
                texto: 'Enviado modelo......',
              );
            },
          );
          MarcaResponse res = await ModeloService.insertarModelo(Modelo(
            modId: -1,
            marId: vehiculoBloc.marcaSelect.marId,
            marNombre: "",
            modNombre: _nombreModelo,
            codigo: _codigoModelo,
          ));
          Navigator.pop(context);
          if (res.ok == true) {
            final vehiculoBloc =
                Provider.of<VehiculoBloc>(context, listen: false);

            Modelo mar = Modelo(
              modId: res.uid!,
              marId: vehiculoBloc.marcaSelect.marId,
              marNombre: vehiculoBloc.marcaSelect.marNombre,
              modNombre: _nombreModelo,
              codigo: _codigoModelo,
            );
            vehiculoBloc.modelos = [...vehiculoBloc.modelos, mar];
            vehiculoBloc.ctrlFiltroModelo.text = '';
            vehiculoBloc.cargarModelos();

            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: "Modelo guardada correctamente",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green.shade300,
              textColor: Colors.white,
              fontSize: 16.0,
            );
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
        showDialog(
            context: context,
            builder: (_) {
              return DialogoGeneral(
                size: size,
                lottie: 'assets/lotties/error_lottie.json',
                mostrarBoton1: true,
                mostrarBoton2: false,
                titulo: 'ALERTA',
                texto: 'Debe ingresar el nombre',
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
              lottie: 'assets/lotties/error_lottie.json',
              mostrarBoton1: true,
              mostrarBoton2: false,
              titulo: 'ALERTA',
              texto: 'Debe ingresar el código',
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
