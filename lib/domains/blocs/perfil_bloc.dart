import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:app_ordenes/domains/utils/url_util.dart';

import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart' as url;
import 'package:app_ordenes/models/services/imagen_service.dart';
import 'package:path/path.dart';
import 'package:app_ordenes/models/foto_model.dart';
import 'package:app_ordenes/models/requests/login_request.dart';
import 'package:app_ordenes/models/responses/usuario_reponse.dart';
import 'package:app_ordenes/models/services/usuario_service.dart';
import 'package:app_ordenes/models/usuario_model.dart';
import 'package:app_ordenes/ui/widgets/dialogo_cargando_widget.dart';
import 'package:app_ordenes/ui/widgets/dialogo_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PerfilBloc extends ChangeNotifier {
  bool _revConexion = false;
  bool? _cambioClave = false;
  bool _hayConexion = false;
  String _txtRevisando = "";
  String _usuario = "";
  String _pss = "";
  bool _mostrar = false;

  String _nombres = "";
  String _apellidos = "";
  String _correo = "";
  String _claveAntigua = "";
  String _claveNueva = "";
  String _confClave = "";
  String _imgFirma = "";
  SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
  );
  FotoModel _firma = FotoModel(imagen: XFile(''), nombre: '');

  Usuario? _usuFinal;
  Usuario? _usuClon;
  String get imgFirma => _imgFirma;
  bool get revConexion => _revConexion;
  bool get mostrar => _mostrar;
  Usuario get usuFinal => _usuFinal!;
  bool get hayConexion => _hayConexion;
  String get txtRevisando => _txtRevisando;
  String get usuario => _usuario;
  String get pss => _pss;
  SignatureController get controller => _controller;
  FotoModel get firma => _firma;

  String get nombres => _nombres;
  String get apellidos => _apellidos;
  String get correo => _correo;
  String get claveAntigua => _claveAntigua;
  String get claveNueva => _claveNueva;
  String get confClave => _confClave;
  bool get cambioClave => _cambioClave!;

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
        final pathOfImage = await File('${directory.path}/firmaUsuario_' +
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

  void guardarCambios(BuildContext context, Size size) async {
    bool pasa = true;
    String msj = "";
    if (_nombres.trim().isNotEmpty) {
      if (_apellidos.trim().isNotEmpty) {
        if (_cambioClave!) {
          if (_claveAntigua.trim().isNotEmpty) {
            if (_claveNueva.trim().isNotEmpty && _confClave.trim().isNotEmpty) {
              if (_claveAntigua == _usuFinal!.usuContrasena) {
                if (_claveNueva == _confClave) {
                } else {
                  pasa = false;
                  msj = "Las claves no coinciden";
                }
              } else {
                pasa = false;
                msj = "La clave actual no es la correcta";
              }
            } else {
              pasa = false;
              msj = "Debe ingresar la nueva clave y su confirmación";
            }
          } else {
            pasa = false;
            msj = "Debe ingresar la clave actual";
          }
        }
      } else {
        pasa = false;
        msj = "Debe ingresar los apellidos";
      }
    } else {
      pasa = false;
      msj = "Debe ingresar los nombres";
    }
    if (pasa) {
      _txtRevisando = 'Revisando conexión...';
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return DialogoCargando(
            texto: _txtRevisando,
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
              texto: 'Enviando información',
            );
          },
        );

        if (_firma.imagen.path.isNotEmpty) {
          io.Directory documentsDirectory =
              await getApplicationDocumentsDirectory();
          String path = join(documentsDirectory.path, "imagenes");
          String pathFnal = join(path, _firma.imagen.name);
          final File imagenCache = File(_firma.imagen.path);
          imagenCache.copy(pathFnal);
          await ImagenService.uploadImage(_firma.imagen.path);
        }
        _usuClon = Usuario(
          usuId: _usuFinal!.usuId,
          identificador: _usuFinal!.identificador,
          eprId: _usuFinal!.eprId,
          pymes: false,
          validarStock: false,
          palabraClave: _usuFinal!.palabraClave,
          eprActivo: _usuFinal!.eprActivo,
          usuAlias: _usuFinal!.usuAlias,
          usuContrasena:
              _cambioClave! == true ? _claveNueva : _usuFinal!.usuContrasena,
          usuRol: _usuFinal!.usuRol,
          usuActivo: _usuFinal!.usuActivo,
          usuCorreo: _correo,
          usuNombres: _nombres,
          usuApellidos: _apellidos,
          firma: _firma.imagen.path.isNotEmpty ? _firma.imagen.name : null,
        );

        UsuarioReponse res = await UsuarioService.actualizarDatos(_usuClon!);
        // ignore: avoid_print

        Navigator.pop(context);
        if (res.ok == true) {
          _imgFirma = "${url.url}/foto/" + _firma.imagen.name;
          _firma = FotoModel(imagen: XFile(''), nombre: '');
          print(_imgFirma);
          _controller.clear();
          _usuFinal!.usuNombres = _nombres;
          _usuFinal!.usuApellidos = _apellidos;
          _usuFinal!.usuCorreo = _correo;
          if (_cambioClave == true) {
            _usuFinal!.usuContrasena = _claveNueva;
          }
          Preferencias pref = Preferencias();
          pref.usuario = _usuFinal!;
          encerarDatos();

          showDialog(
              context: context,
              builder: (_) {
                return DialogoGeneral(
                  size: size,
                  lottie: 'assets/lotties/succes_lottie.json',
                  mostrarBoton1: true,
                  mostrarBoton2: false,
                  titulo: 'Info',
                  texto: 'Datos guardados correctamente',
                  accion1: () {
                    Navigator.pop(context);
                  },
                  textoBtn1: 'Ok',
                  textoBtn2: 'Cancelar',
                  accion2: () {},
                );
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
              lottie: 'assets/lotties/alerta_lottie.json',
              mostrarBoton1: true,
              mostrarBoton2: false,
              titulo: 'ALERTA',
              texto: msj,
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

  void encerarDatos() {
    _apellidos = _usuFinal!.usuApellidos;
    _nombres = _usuFinal!.usuNombres;
    _correo = _usuFinal!.usuCorreo;
    _claveAntigua = "";
    _claveNueva = "";
    _confClave = "";
    _cambioClave = false;
    notifyListeners();
  }

  set usuFinal(Usuario? usu) {
    _usuFinal = usu;
    notifyListeners();
  }

  set cambioClave(bool? c) {
    _cambioClave = c;
    notifyListeners();
  }

  set claveAntigua(String c) {
    _claveAntigua = c;
    notifyListeners();
  }

  set confClave(String c) {
    _confClave = c;
    notifyListeners();
  }

  set claveNueva(String c) {
    _claveNueva = c;
    notifyListeners();
  }

  set nombres(String c) {
    _nombres = c;
    notifyListeners();
  }

  set apellidos(String c) {
    _apellidos = c;
    notifyListeners();
  }

  set correo(String c) {
    _correo = c;
    notifyListeners();
  }

  set mostrar(bool m) {
    _mostrar = m;
    notifyListeners();
  }

  set usuario(String u) {
    _usuario = u;
    notifyListeners();
  }

  set pss(String u) {
    _pss = u;
    notifyListeners();
  }

  set revConexion(bool r) {
    _revConexion = r;
    notifyListeners();
  }

  set hayConexion(bool r) {
    _hayConexion = r;
    notifyListeners();
  }

  set txtRevisando(String r) {
    _txtRevisando = r;
    notifyListeners();
  }

  void login(BuildContext context, Size size) async {
    if (_usuario.trim().isNotEmpty && _pss.trim().isNotEmpty) {
      _txtRevisando = 'Revisando conexión...';
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return DialogoCargando(
            texto: _txtRevisando,
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
              texto: 'Iniciando sesión',
            );
          },
        );
        UsuarioReponse res = await UsuarioService.loginUsuario(
            LoginRequest(alias: _usuario, contrasena: _pss));
        // ignore: avoid_print
        Navigator.pop(context);
        if (res.ok == true) {
          Preferencias pref = Preferencias();
          pref.token = res.usuario!.usuAlias;
          pref.empresa = res.usuario!.eprId;
          pref.usuario = res.usuario!;
          if ((res.usuario!.firma ?? '').isNotEmpty) {
            List<String> f = (res.usuario!.firma ?? '').split("/");
            _imgFirma = "${url.url}/foto/" + f[f.length - 1];
          }
          final vehiculoBloc =
              Provider.of<VehiculoBloc>(context, listen: false);
          vehiculoBloc.palabraClave = res.usuario!.palabraClave!;
          vehiculoBloc.identificador = res.usuario!.identificador!;
          _usuFinal = res.usuario!;
          notifyListeners();
          Navigator.pushReplacementNamed(context, "inicio");
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
              lottie: 'assets/lotties/alerta_lottie.json',
              mostrarBoton1: true,
              mostrarBoton2: false,
              titulo: 'ALERTA',
              texto: 'Debe ingresar alias/correo y contraseña',
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

  Future<void> loginBack(
      BuildContext context, String usuario, String contrasena) async {
    final conect = await verificarConexion();
    if (conect) {
      Preferencias pref = Preferencias();
      UsuarioReponse res = await UsuarioService.loginUsuario(
          LoginRequest(alias: usuario, contrasena: contrasena));
      if (res.ok == true) {
        pref.token = res.usuario!.usuAlias;
        pref.empresa = res.usuario!.eprId;
        pref.usuario = res.usuario!;
        _usuFinal = res.usuario!;
        final vehiculoBloc = Provider.of<VehiculoBloc>(context, listen: false);
        print(res.usuario!.palabraClave);
        vehiculoBloc.palabraClave = res.usuario!.palabraClave!;
        vehiculoBloc.identificador = res.usuario!.identificador!;
        notifyListeners();
        if (res.usuario!.usuActivo == true) {
          if (res.usuario!.eprActivo == true) {
            Navigator.pushReplacementNamed(context, 'inicio');
          } else {
            pref.token = '';
            pref.usuario = null;
            Navigator.pushReplacementNamed(context, 'login');
          }
        } else {
          pref.token = '';
          pref.usuario = null;
          Navigator.pushReplacementNamed(context, 'login');
        }
      } else {
        if (res.statusCode == 400) {
          pref.token = '';
          pref.usuario = null;
          Navigator.pushReplacementNamed(context, 'login');
        } else {
          Navigator.pushReplacementNamed(context, 'inicio');
        }
      }
    } else {
      Navigator.pushReplacementNamed(context, 'inicio');
    }
  }

  void cerrarSesion(BuildContext context) async {
    Preferencias pref = Preferencias();
    pref.token = "";
    final perfilBloc = Provider.of<PerfilBloc>(context, listen: false);
    pref.usuario = Usuario(
      usuId: -1,
      usuRol: -1,
      usuNombres: "",
      usuApellidos: "",
      validarStock: false,
      pymes: false,
      usuAlias: "",
      palabraClave: "",
      usuContrasena: "",
      usuCorreo: "",
      usuActivo: true,
      eprId: -1,
      identificador: "",
      eprActivo: false,
    );
    perfilBloc.usuFinal = pref.usuario!;
    Navigator.pushReplacementNamed(context, "login");
  }
}
