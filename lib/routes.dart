import 'package:app_ordenes/ui/pages/inigio_page.dart';
import 'package:app_ordenes/ui/pages/login_page.dart';
import 'package:app_ordenes/ui/pages/orden_page.dart';
import 'package:app_ordenes/ui/pages/perfil_page.dart';
import 'package:app_ordenes/ui/pages/splash_page.dart';
import 'package:app_ordenes/ui/widgets/ayuda_marca.dart';
import 'package:app_ordenes/ui/widgets/ayuda_modelo.dart';
import 'package:app_ordenes/ui/widgets/ayuda_vehiculo.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> rutas() {
  return <String, WidgetBuilder>{
    "/": (_) => const SplashPage(),
    "login": (_) => const LoginPage(),
    "inicio": (_) => const InicioPage(),
    "perfil": (_) => const PerfilPage(),
    "orden": (_) => const OrdenPage(),
    "ayuda_modelo": (_) => const AyudaModelo(),
    "ayuda_marca": (_) => const AyudaMarca(),
    "ayuda_vehiculo": (_) => const AyudaVehiculo(),
  };
}
