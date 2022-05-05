import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/ui/widgets/boton_principal.dart';
import 'package:app_ordenes/ui/widgets/boton_secundario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalleFormulario extends StatelessWidget {
  const DetalleFormulario({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detallesBloc = Provider.of<DetallesBloc>(context);
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          child: TextField(
            controller: TextEditingController(
                text: detallesBloc.producto.proNombre.trim()),
            readOnly: true,
            enabled: false,
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              hintText: 'Producto',
              labelText: 'Producto',
              border: OutlineInputBorder(),
            ),
          ),
          onTap: () {
            detallesBloc.abrirAyudaProducto(context, 2);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: TextField(
            controller:
                TextEditingController(text: detallesBloc.producto.proCodigo),
            readOnly: true,
            enabled: false,
            decoration: const InputDecoration(
              hintText: 'Cód. Producto',
              labelText: 'Cód. Producto',
              border: OutlineInputBorder(),
            ),
          ),
          onTap: () {
            detallesBloc.abrirAyudaProducto(context, 1);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: detallesBloc.ctrlCantidad,
          keyboardType: TextInputType.number,
          style: TextStyle(
              color: detallesBloc.hayStock ? Colors.black : Colors.red),
          decoration: InputDecoration(
            hintText: 'Cantidad',
            labelText: 'Cantidad',
            labelStyle: TextStyle(
                color: detallesBloc.hayStock ? Colors.grey : Colors.red),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: detallesBloc.hayStock ? Colors.grey : Colors.red),
            ),
            focusedBorder: new OutlineInputBorder(
              borderSide: BorderSide(
                  color: detallesBloc.hayStock ? Colors.grey : Colors.red),
            ),
          ),
          onChanged: (e) {
            double.tryParse(e) != null
                ? detallesBloc.cantidad = double.parse(e)
                : detallesBloc.cantidad = 0;
            detallesBloc.calcularTotal();
          },
        ),
        Preferencias().usuario!.pymes == true
            ? detallesBloc.inventario == true
                ? SizedBox(
                    height: 10,
                  )
                : Container()
            : Container(),
        Preferencias().usuario!.pymes == true
            ? detallesBloc.inventario == true
                ? TextField(
                    controller: detallesBloc.ctrlStock,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Stock',
                      labelText: 'Stock',
                      border: OutlineInputBorder(),
                    ),
                  )
                : Container()
            : Container(),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: detallesBloc.ctrlPrecio,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Precio',
            labelText: 'Precio',
            border: OutlineInputBorder(),
          ),
          onChanged: (e) {
            double.tryParse(e) != null
                ? detallesBloc.precio = double.parse(e)
                : detallesBloc.precio = 0;
            detallesBloc.calcularTotal();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: detallesBloc.ctrlTotal,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Total',
            labelText: 'Total',
            border: OutlineInputBorder(),
          ),
          onChanged: (e) {
            double.tryParse(e) != null
                ? detallesBloc.total = double.parse(e)
                : detallesBloc.total = 0;
            detallesBloc.calcularPrecio();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        BotonPrincipal(
          label: 'Guardar',
          onPressed: () {
            detallesBloc.agregarDetalle(context);
          },
          size: size,
        ),
        BotonSecundario(
          label: 'Cancelar',
          size: size,
          onPressed: () {
            detallesBloc.mostrarFormulario = false;
          },
        ),
      ],
    );
  }
}
