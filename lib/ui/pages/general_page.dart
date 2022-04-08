import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ordenbloc = Provider.of<OrdenBloc>(context);
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
                  ordenbloc.cambioIdentificacion(context, valor);
                },
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
                ordenbloc.buscarCliente(context, size);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: ordenbloc.ctrlNombres,
          textCapitalization: TextCapitalization.characters,
          onChanged: (valor) {
            ordenbloc.nombres = valor.toUpperCase();
          },
          decoration: const InputDecoration(
            hintText: 'Nombres',
            labelText: 'Nombres',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: ordenbloc.ctrlTelefono,
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
          textCapitalization: TextCapitalization.characters,
          maxLines: 3,
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
          maxLines: 5,
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
