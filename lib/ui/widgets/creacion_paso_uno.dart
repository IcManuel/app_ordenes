import 'dart:io';

import 'package:app_ordenes/domains/blocs/crear_cuenta_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreacionPasoUno extends StatelessWidget {
  const CreacionPasoUno({
    Key? key,
    required this.crearCuentaBloc,
    required this.size,
  }) : super(key: key);

  final CrearCuentaBloc crearCuentaBloc;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: (valor) {
            crearCuentaBloc.nombre = valor;
          },
          controller: crearCuentaBloc.ctrlNombre,
          decoration: const InputDecoration(
            hintText: 'Nombre Empresa',
            labelText: 'Nombre Empresa',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: (valor) {
            crearCuentaBloc.direccion = valor;
          },
          maxLines: 2,
          controller: crearCuentaBloc.ctrlDireccion,
          decoration: const InputDecoration(
            hintText: 'Dirección Empresa',
            labelText: 'Dirección Empresa',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                onChanged: (valor) {
                  crearCuentaBloc.palabraClave = valor;
                },
                controller: crearCuentaBloc.ctrlPalabraClae,
                decoration: const InputDecoration(
                  hintText: 'Palabra clave',
                  labelText: 'Palabra clave',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg:
                      'Define la palabra acerca de qué se trata tu negocio de reparación, por ejemplo para un tecnicentro: VEHICULO',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              icon: Icon(Icons.info),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                onChanged: (valor) {
                  crearCuentaBloc.identificador = valor;
                },
                controller: crearCuentaBloc.ctrlIdentificador,
                decoration: const InputDecoration(
                  hintText: 'Cod. Identificador',
                  labelText: 'Cod. Identificador',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg:
                      'Define un identificador para tus máquinas, como un código único por ejemplo, para un tecnicentro: PLACA',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              icon: Icon(Icons.info),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            crearCuentaBloc.seleccionarLogo();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: crearCuentaBloc.logo.nombre.trim().isEmpty
                  ? Image.asset(
                      "assets/images/no_image.png",
                      height: size.height * .25,
                    )
                  : Image.file(
                      File(
                        crearCuentaBloc.logo.imagen.path,
                      ),
                      fit: BoxFit.fill,
                      width: size.width * .4,
                      height: size.height * .25,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
