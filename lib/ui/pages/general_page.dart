import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordenbloc = Provider.of<OrdenBloc>(context);
    final size = MediaQuery.of(context).size;
    final ayudaBloc = Provider.of<AyudaBloc>(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        SizedBox(
          height: (Preferencias().usuario!.validarCedula ?? false) ? 15 : 1,
        ),
        (Preferencias().usuario!.validarCedula ?? false)
            ? Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade500,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: size.width * .3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tipo identificacion',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      DropdownButton<String>(
                        value: ordenbloc.tipoIdentificacion,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: colorPrincipal,
                        ),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: colorPrincipal,
                        ),
                        onChanged: (String? newValue) {
                          ordenbloc.tipoIdentificacion = newValue!;
                        },
                        items: <String>[
                          'CEDULA',
                          'RUC',
                          'PASAPORTE',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (valor) {
                  ordenbloc.nombres = valor.toUpperCase();
                },
                enabled: !ordenbloc.modificar,
                controller: ordenbloc.ctrlNombres,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                  hintText: 'Nombres',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                if (ordenbloc.modificar == false) {
                  ayudaBloc.abrirAyudaCliente(context, 2, ordenbloc.nombres);
                }
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Focus(
                onFocusChange: (v) {
                  if (!v) {
                    ordenbloc.buscarCliente(context, size);
                  }
                },
                child: TextField(
                  onChanged: (valor) {
                    ordenbloc.cambioIdentificacion(context, valor);
                  },
                  enabled: !ordenbloc.modificar,
                  controller: ordenbloc.ctrlIdentificacion,
                  decoration: const InputDecoration(
                    labelText: 'Identificación',
                    hintText: 'Identificación',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                if (ordenbloc.modificar == false) {
                  ayudaBloc.abrirAyudaCliente(
                      context, 1, ordenbloc.identificacion);
                }
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: ordenbloc.ctrlTelefono,
          enabled: !ordenbloc.modificar,
          textCapitalization: TextCapitalization.characters,
          onChanged: (valor) {
            ordenbloc.telefono = valor.toUpperCase();
          },
          decoration: const InputDecoration(
            hintText: 'Telfs',
            labelText: 'Telfs',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: ordenbloc.ctrlCorreo,
          enabled: !ordenbloc.modificar,
          textCapitalization: TextCapitalization.characters,
          keyboardType: TextInputType.emailAddress,
          onChanged: (valor) {
            ordenbloc.correo = valor.toUpperCase();
          },
          decoration: const InputDecoration(
            hintText: 'Correo ',
            labelText: 'Correo ',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: ordenbloc.ctrlDireccion,
          enabled: !ordenbloc.modificar,
          textCapitalization: TextCapitalization.characters,
          maxLines: 2,
          onChanged: (valor) {
            ordenbloc.direccion = valor.toUpperCase();
          },
          decoration: const InputDecoration(
            hintText: 'Dirección',
            labelText: 'Dirección',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: ordenbloc.ctrlObs,
          textCapitalization: TextCapitalization.characters,
          maxLines: 4,
          onChanged: (valor) {
            ordenbloc.observaciones = valor.toUpperCase();
          },
          decoration: const InputDecoration(
            hintText: 'Observaciones cliente para reparación',
            labelText: 'Observaciones cliente para reparación',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
