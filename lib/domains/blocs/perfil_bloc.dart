import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/domains/utils/url_util.dart';
import 'package:app_ordenes/models/requests/login_request.dart';
import 'package:app_ordenes/models/responses/usuario_reponse.dart';
import 'package:app_ordenes/models/services/usuario_service.dart';
import 'package:app_ordenes/models/usuario_model.dart';
import 'package:app_ordenes/ui/widgets/dialogo_cargando_widget.dart';
import 'package:app_ordenes/ui/widgets/dialogo_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilBloc extends ChangeNotifier {
  bool _revConexion = false;
  bool? _cambioClave = false;
  bool _hayConexion = false;
  String _txtRevisando = "";
  String _usuario = "";
  String _pss = "";

  String _nombres = "";
  String _apellidos = "";
  String _correo = "";
  String _claveAntigua = "";
  String _claveNueva = "";
  String _confClave = "";

  Usuario? _usuFinal;
  Usuario? _usuClon;

  bool get revConexion => _revConexion;
  Usuario get usuFinal => _usuFinal!;
  bool get hayConexion => _hayConexion;
  String get txtRevisando => _txtRevisando;
  String get usuario => _usuario;
  String get pss => _pss;

  String get nombres => _nombres;
  String get apellidos => _apellidos;
  String get correo => _correo;
  String get claveAntigua => _claveAntigua;
  String get claveNueva => _claveNueva;
  String get confClave => _confClave;
  bool get cambioClave => _cambioClave!;

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
              texto: 'Iniciando sesión',
            );
          },
        );
        _usuClon = Usuario(
            usuId: _usuFinal!.usuId,
            eprId: _usuFinal!.eprId,
            eprActivo: _usuFinal!.eprActivo,
            usuAlias: _usuFinal!.usuAlias,
            usuContrasena:
                _cambioClave! == true ? _claveNueva : _usuFinal!.usuContrasena,
            usuRol: _usuFinal!.usuRol,
            usuActivo: _usuFinal!.usuActivo,
            usuCorreo: _correo,
            usuNombres: _nombres,
            usuApellidos: _apellidos);
        UsuarioReponse res = await UsuarioService.actualizarDatos(_usuClon!);
        // ignore: avoid_print
        Navigator.pop(context);
        if (res.ok == true) {
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

  void cerrarSesion(BuildContext context) async {
    Preferencias pref = Preferencias();
    pref.token = "";
    final perfilBloc = Provider.of<PerfilBloc>(context, listen: false);
    pref.usuario = Usuario(
      usuId: -1,
      usuRol: -1,
      usuNombres: "",
      usuApellidos: "",
      usuAlias: "",
      usuContrasena: "",
      usuCorreo: "",
      usuActivo: true,
      eprId: -1,
      eprActivo: false,
    );
    perfilBloc.usuFinal = pref.usuario!;
    Navigator.pushReplacementNamed(context, "login");
  }
}
