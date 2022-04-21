import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/models/orden_model.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaHistorialVehiculo extends StatelessWidget {
  const AyudaHistorialVehiculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listaBloc = Provider.of<ListaOrdenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HISTORIAL ' + listaBloc.placaH,
        ),
      ),
      body: listaBloc.cargandoH == true
          ? const Center(child: CircularProgressIndicator())
          : listaBloc.listaH.isNotEmpty
              ? ListView.builder(
                  itemCount: listaBloc.listaH.length,
                  itemBuilder: (BuildContext context, int index) {
                    Orden mod = listaBloc.listaH[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: double.infinity,
                        height: size.height * .15,
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
                                  IconButton(
                                    onPressed: () {
                                      listaBloc.consultar(context, mod, size);
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: colorPrincipal,
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
                              )
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
    );
  }
}
