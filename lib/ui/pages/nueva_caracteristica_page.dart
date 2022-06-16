import 'package:app_ordenes/domains/blocs/crear_cuenta_bloc.dart';
import 'package:app_ordenes/models/lista_caracteristica_model.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NuevaCaracteristicaPage extends StatelessWidget {
  const NuevaCaracteristicaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final crearCuentaBloc = Provider.of<CrearCuentaBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva característica',
        ),
        actions: [
          IconButton(
            onPressed: () {
              crearCuentaBloc.agregarCaracteristica(context);
            },
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.characters,
              initialValue: crearCuentaBloc.caracteristica.carNombre,
              onChanged: (valor) {
                crearCuentaBloc.caracteristica.carNombre = valor;
              },
              decoration: const InputDecoration(
                hintText: 'NOMBRE',
                labelText: 'NOMBRE',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: size.width * .1,
                ),
                child: Row(
                  children: [
                    Text(
                      'DIGITABLE',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                    Radio(
                      value: false,
                      groupValue:
                          crearCuentaBloc.caracteristica.carSeleccionadble,
                      onChanged: (valor) {
                        crearCuentaBloc
                            .cambioSeleccionable(valor.toString() == 'true');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'SELECCIONABLE',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                    Radio(
                      value: true,
                      groupValue:
                          crearCuentaBloc.caracteristica.carSeleccionadble,
                      onChanged: (valor) {
                        crearCuentaBloc
                            .cambioSeleccionable(valor.toString() == 'true');
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            !crearCuentaBloc.caracteristica.carSeleccionadble
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade500,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: size.width * .1,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'TEXTO',
                            style: TextStyle(color: Colors.grey.shade900),
                          ),
                          Radio(
                            value: 2,
                            groupValue: crearCuentaBloc.caracteristica.carTipo,
                            onChanged: (valor) {
                              crearCuentaBloc
                                  .cambioTipo(int.parse(valor.toString()));
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'NUMÉRICO',
                            style: TextStyle(color: Colors.grey.shade900),
                          ),
                          Radio(
                            value: 1,
                            groupValue: crearCuentaBloc.caracteristica.carTipo,
                            onChanged: (valor) {
                              crearCuentaBloc
                                  .cambioTipo(int.parse(valor.toString()));
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: size.width * .1,
                ),
                child: Row(
                  children: [
                    Text(
                      'OBLIGATORIA',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                    Checkbox(
                        value: crearCuentaBloc.caracteristica.carObligatorio,
                        onChanged: (valor) {
                          crearCuentaBloc.cambioObligatorio(valor);
                        })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            crearCuentaBloc.caracteristica.carSeleccionadble
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Detalles',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            crearCuentaBloc.caracteristica.carSeleccionadble
                ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          textCapitalization: TextCapitalization.characters,
                          onChanged: (valor) {
                            crearCuentaBloc.nombreLista = valor;
                          },
                          controller: crearCuentaBloc.ctrlNombreLista,
                          decoration: const InputDecoration(
                            hintText: 'NOMBRE',
                            labelText: 'NOMBRE',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          crearCuentaBloc.nuevoDetalle();
                        },
                        icon: Icon(
                          Icons.add_circle_rounded,
                          color: colorPrincipal,
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            crearCuentaBloc.caracteristica.carSeleccionadble
                ? SizedBox(
                    height: size.height * .4,
                    child: Container(
                      width: size.width * .85,
                      decoration: BoxDecoration(
                        border: Border.all(color: colorPrincipal.shade500),
                      ),
                      child: ListView.builder(
                        itemCount: crearCuentaBloc.detalles.length,
                        itemBuilder: (BuildContext context, int index) {
                          ListaCaracteristica mod =
                              crearCuentaBloc.detalles[index];
                          return ListTile(
                            title: Text(mod.calNombre),
                            //subtitle: Text(mod.marNombre),
                            trailing: IconButton(
                              onPressed: () {
                                crearCuentaBloc.borrarDetalle(mod);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
