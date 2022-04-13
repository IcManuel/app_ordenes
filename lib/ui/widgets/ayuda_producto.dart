import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/producto_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AyudaProducto extends StatelessWidget {
  const AyudaProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Preferencias pref = Preferencias();
    final size = MediaQuery.of(context).size;
    final detallesBloc = Provider.of<DetallesBloc>(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Producto'),
        actions: [
          IconButton(
            onPressed: () {
              detallesBloc.abrirCrearProducto(context);
            },
            icon: const Icon(
              Icons.add_circle_rounded,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              // controller: ordenbloc.ctrlTelefono,
              textCapitalization: TextCapitalization.characters,
              onChanged: (valor) {
                detallesBloc.filtro = valor;
                if (!detallesBloc.escribiendo) {
                  detallesBloc.escribiendo = true;
                  Future.delayed(const Duration(seconds: 3))
                      .whenComplete(() async {
                    detallesBloc.escribiendo = false;
                    if (!detallesBloc.consultando) {
                      detallesBloc.cargarLista(pref, arguments['tipo']);
                    }
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Buscar por ' +
                    (arguments['tipo'] == 1 ? ' código ' : 'nombre '),
                labelText: 'Buscar por ' +
                    (arguments['tipo'] == 1 ? ' código ' : 'nombre '),
                border: const OutlineInputBorder(),
              ),
            ),
            detallesBloc.escribiendo
                ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  )
                : detallesBloc.consultando
                    ? const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : Expanded(
                        child: detallesBloc.productos.isNotEmpty
                            ? ListView.builder(
                                itemCount: detallesBloc.productos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Producto pro = detallesBloc.productos[index];
                                  return InkWell(
                                    onTap: () {
                                      detallesBloc.producto = pro;
                                      detallesBloc.precio = pro.proPrecio!;
                                      detallesBloc.ctrlPrecio.text =
                                          pro.proPrecio!.toStringAsFixed(2);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  Color.fromRGBO(0, 83, 79, 1),
                                              width: 0.2),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: size.width * .22,
                                              child: Text(
                                                '\$ ${pro.proPrecio}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.grey.shade800,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    pro.proCodigo,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    pro.proNombre,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                  Text(
                                                    pro.tprNombre +
                                                        "  -  " +
                                                        pro.mprNombre,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.green.shade700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Text(
                                'No se ha encontrado información... ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                      ),
          ],
        ),
      ),
    );
  }
}
