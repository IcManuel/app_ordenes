import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordenbloc = Provider.of<OrdenBloc>(context);
    final ayudaBloc = Provider.of<AyudaBloc>(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (valor) {
                  ordenbloc.nombres = valor;
                },
                enabled: !ordenbloc.modificar,
                controller: ordenbloc.ctrlNombres,
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
