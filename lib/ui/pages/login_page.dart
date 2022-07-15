import 'package:app_ordenes/domains/blocs/crear_cuenta_bloc.dart';
import 'package:app_ordenes/domains/blocs/perfil_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginBloc = Provider.of<PerfilBloc>(context);
    final crearCuentaBloc = Provider.of<CrearCuentaBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.grey.shade100,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/MILA.png",
                height: size.height * .3,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                ),
                height: size.height * 0.35,
                width: double.maxFinite,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Inicio de sesión',
                          style: TextStyle(
                            fontSize: size.height * 0.030,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Usuario/correo',
                          ),
                          onChanged: (e) {
                            loginBloc.usuario = e;
                          },
                        ),
                        TextField(
                          obscureText: !loginBloc.mostrar,
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginBloc.mostrar = !loginBloc.mostrar;
                              },
                              icon: Icon(
                                !loginBloc.mostrar
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onChanged: (e) {
                            loginBloc.pss = e;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RecupearrPssPage(),
                                    ),
                                  );*/
                              },
                              child: Text(
                                'Olvidaste tu contraseña?',
                                style: TextStyle(
                                  fontSize: size.height * 0.020,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿No tienes cuenta?',
                              style: TextStyle(
                                color: colorPrincipal,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                crearCuentaBloc.inicializar(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  primary: colorPrincipal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Padding(
                                padding: EdgeInsets.all(size.height * 0.01),
                                child: Text(
                                  'REGÍSTRATE',
                                  style: TextStyle(
                                      fontSize: size.height * 0.015,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03, vertical: size.height * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        loginBloc.login(context, size);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: Text(
                          'INICIAR SESIÓN',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.copyright,
                            color: colorPrincipal,
                            size: 14,
                          ),
                          Text(
                            'VitelSoft',
                            style: TextStyle(
                              color: colorPrincipal,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Versión ' + Preferencias().versionApp,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
