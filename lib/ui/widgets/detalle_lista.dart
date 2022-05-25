import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/models/dorden_model.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:app_ordenes/ui/widgets/boton_principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalleLista extends StatelessWidget {
  const DetalleLista({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final detallesBloc = Provider.of<DetallesBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BotonPrincipal(
            onPressed: () {
              detallesBloc.abrirNuevoDetalle();
            },
            label: "AGREGAR PRODUCTO/SERVICIO",
            size: size,
          ),
          Expanded(
              child: detallesBloc.detalles.isNotEmpty
                  ? ListView.builder(
                      itemCount: detallesBloc.detalles.length,
                      itemBuilder: (BuildContext context, int index) {
                        Dorden detalle = detallesBloc.detalles[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                detalle.productoFinal!
                                                        .proCodigo +
                                                    " - " +
                                                    detalle.productoFinal!
                                                        .proNombre,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: size.width * .15,
                                                  child: const Text(
                                                    'Cantidad',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: size.width * .4,
                                                  child: Text(
                                                    '   ${detalle.cantidad}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: size.width * .15,
                                                  child: const Text(
                                                    'Precio',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: size.width * .4,
                                                  child: Text(
                                                    '\$ ${detalle.precio}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: size.width * .15,
                                                  child: const Text(
                                                    'Total',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: size.width * .4,
                                                  child: Text(
                                                    '\$ ${detalle.total}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                detallesBloc
                                                    .abrirModificarDetalle(
                                                        detalle, index);
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: colorPrincipal,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                detallesBloc.borrarDetalle(
                                                    context, detalle);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No se han agregado detalles',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))
        ],
      ),
    );
  }
}
