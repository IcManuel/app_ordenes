import 'package:app_ordenes/domains/blocs/crear_cuenta_bloc.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:app_ordenes/ui/widgets/creacion_paso_dos.dart';
import 'package:app_ordenes/ui/widgets/creacion_paso_uno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrearEmpresaPage extends StatelessWidget {
  const CrearEmpresaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final crearCuentaBloc = Provider.of<CrearCuentaBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(crearCuentaBloc.titulo),
            IconButton(
              onPressed: () {
                crearCuentaBloc.mostrarAyudaTitulo();
              },
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                crearCuentaBloc.paso != 1
                    ? ElevatedButton(
                        onPressed: () {
                          crearCuentaBloc.volver();
                          //crearCuentaBloc.inicializar(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            primary: colorPrincipal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'VOLVER',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 40,
                      ),
                ElevatedButton(
                  onPressed: () {
                    crearCuentaBloc.siguiente();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: colorPrincipal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Row(
                    children: [
                      Text(
                        'SIGUIENTE',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.arrow_forward,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            crearCuentaBloc.paso == 1
                ? CreacionPasoUno(crearCuentaBloc: crearCuentaBloc, size: size)
                : crearCuentaBloc.paso == 2
                    ? CreacionPasoDos(
                        size: size, crearCuentaBloc: crearCuentaBloc)
                    : Text('Paso 3'),
          ],
        ),
      ),
    );
  }
}
