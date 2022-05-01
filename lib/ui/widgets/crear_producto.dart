import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/ui/widgets/boton_principal.dart';
import 'package:app_ordenes/ui/widgets/input_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrearProductoPage extends StatelessWidget {
  const CrearProductoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final detallesBloc = Provider.of<DetallesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear producto',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: (valor) {
                detallesBloc.codigo = valor.toUpperCase();
              },
              decoration: const InputDecoration(
                hintText: 'Código',
                labelText: 'Código',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: (valor) {
                detallesBloc.nombre = valor.toUpperCase();
              },
              decoration: const InputDecoration(
                hintText: 'Nombre',
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              child: TextFormField(
                controller: detallesBloc.ctrlTipoProducto,
                readOnly: true,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  hintText: 'Tipo de producto',
                  labelText: 'Tipo de producto',
                  border: OutlineInputBorder(),
                ),
              ),
              onTap: () {
                detallesBloc.abrirAyudaTipo(context, size, true, null);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              child: TextFormField(
                controller: detallesBloc.ctrlMarcaProducto,
                readOnly: true,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  hintText: 'Marca de producto',
                  labelText: 'Marca de producto',
                  border: OutlineInputBorder(),
                ),
              ),
              onTap: () {
                detallesBloc.abrirAyudaMarca(context, size, true);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InputCheck(
              size: size,
              label: 'Inventario',
              value: detallesBloc.inventario,
              onBool: (bool? e) {
                detallesBloc.inventario = e!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BotonPrincipal(
                onPressed: () {
                  detallesBloc.guardarProducto(context, size);
                },
                label: 'Guardar',
                size: size),
          ],
        ),
      ),
    );
  }
}
