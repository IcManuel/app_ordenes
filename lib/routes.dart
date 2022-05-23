import 'package:app_ordenes/ui/pages/inicio_page.dart';
import 'package:app_ordenes/ui/pages/lista_ordenes.dart';
import 'package:app_ordenes/ui/pages/login_page.dart';
import 'package:app_ordenes/ui/pages/orden_page.dart';
import 'package:app_ordenes/ui/pages/pdf_viewer.dart';
import 'package:app_ordenes/ui/pages/perfil_page.dart';
import 'package:app_ordenes/ui/pages/splash_page.dart';
import 'package:app_ordenes/ui/widgets/ayuda_busqueda_vehiculo.dart';
import 'package:app_ordenes/ui/widgets/ayuda_cliente.dart';
import 'package:app_ordenes/ui/widgets/ayuda_historial_vehiculo.dart';
import 'package:app_ordenes/ui/widgets/ayuda_impresoras.dart';
import 'package:app_ordenes/ui/widgets/ayuda_lista.dart';
import 'package:app_ordenes/ui/widgets/ayuda_marca.dart';
import 'package:app_ordenes/ui/widgets/ayuda_marca_producto.dart';
import 'package:app_ordenes/ui/widgets/ayuda_modelo.dart';
import 'package:app_ordenes/ui/widgets/ayuda_producto.dart';
import 'package:app_ordenes/ui/widgets/ayuda_tipo_producto.dart';
import 'package:app_ordenes/ui/widgets/ayuda_vehiculo.dart';
import 'package:app_ordenes/ui/widgets/crear_producto.dart';
import 'package:app_ordenes/ui/widgets/fotos_entrega.dart';
import 'package:app_ordenes/ui/widgets/fotos_ingreso.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> rutas() {
  return <String, WidgetBuilder>{
    "/": (_) => const SplashPage(),
    "login": (_) => const LoginPage(),
    "inicio": (_) => const InicioPage(),
    "perfil": (_) => const PerfilPage(),
    "orden": (_) => const OrdenPage(),
    "ayuda_modelo": (_) => const AyudaModelo(),
    "ayuda_cliente": (_) => const AyudaCliente(),
    "ayuda_tipo_producto": (_) => const AyudaTipoProducto(),
    "ayuda_marca_producto": (_) => const AyudaMarcaProducto(),
    "ayuda_marca": (_) => const AyudaMarca(),
    "ayuda_vehiculo": (_) => const AyudaVehiculo(),
    "crear_producto": (_) => const CrearProductoPage(),
    "ayuda_producto": (_) => const AyudaProducto(),
    "fotos_ingreso": (_) => const FotosIngreso(),
    "fotos_entrega": (_) => const FotosEntrega(),
    "pdf_viewer": (_) => const PdfImpresion(),
    "ayuda_historial": (_) => const AyudaHistorialVehiculo(),
    "ayuda_lista": (_) => const AyudaLista(),
    "ayuda_impresora": (_) => const AyudaImpresora(),
    "ayuda_busqueda_vehiculo": (_) => const AyudaBusquedaVehiculo(),
    "lista_ordenes": (_) => const ListaOrdenesPage(),
  };
}
