import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/crear_cuenta_bloc.dart';
import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/domains/blocs/nuevo_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/blocs/perfil_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/blocs/visual_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/routes.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preferencias pref = Preferencias();
  await pref.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PerfilBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdenBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => VehiculoBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => CrearCuentaBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => NuevoBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => FotosBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => VisualBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetallesBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => AyudaBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => ListaOrdenBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'MILA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: colorPrincipal,
        ),
        routes: rutas(),
        initialRoute: '/',
      ),
    );
  }
}
