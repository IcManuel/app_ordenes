import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/models/orden_model.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:app_ordenes/ui/widgets/cabecera_filtro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaOrdenesPage extends StatelessWidget {
  const ListaOrdenesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listaBloc = Provider.of<ListaOrdenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listado de órdenes',
        ),
      ),
      body: Column(
        children: [
          CabeceraFiltro(
            size: size,
            listaBloc: listaBloc,
          ),
          Expanded(
            child: listaBloc.cargando == true
                ? const Center(child: CircularProgressIndicator())
                : listaBloc.lista.isNotEmpty
                    ? ListView.builder(
                        itemCount: listaBloc.lista.length,
                        itemBuilder: (BuildContext context, int index) {
                          Orden mod = listaBloc.lista[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: double.infinity,
                              height: size.height * .2,
                              decoration: BoxDecoration(
                                color: mod.corEstado == 2
                                    ? Colors.lightGreen.shade100
                                    : Colors.orange.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(-1, -1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    color: Colors.grey.shade400,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Orden #' + mod.corNumero.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: colorPrincipal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          mod.corFecha,
                                          style: const TextStyle(),
                                        ),
                                        Text(
                                          mod.corEstado == 2
                                              ? 'GUARDADA'
                                              : 'PREGUARDADA',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        mod.vehiculo.vehPlaca +
                                            " - " +
                                            mod.vehiculo.marNombre +
                                            " " +
                                            mod.vehiculo.modNombre,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        mod.cliente.cliIdentificacion +
                                            ' - ' +
                                            mod.cliente.cliNombres!,
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        mod.corEstado == 4
                                            ? IconButton(
                                                onPressed: () {
                                                  listaBloc.modificar(
                                                      context, mod, size);
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: colorPrincipal,
                                                ),
                                              )
                                            : Container(),
                                        IconButton(
                                          onPressed: () {
                                            listaBloc.consultar(
                                                context, mod, size);
                                          },
                                          icon: Icon(
                                            Icons.search,
                                            color: Colors.green,
                                          ),
                                        ),
                                        mod.corEstado == 4
                                            ? IconButton(
                                                onPressed: () {
                                                  listaBloc.eliminar(
                                                      context, mod, size);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.all(28.0),
                        child: Text(
                          'No hay datos',
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
