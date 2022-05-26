import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaBusquedaVehiculo extends StatelessWidget {
  const AyudaBusquedaVehiculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Preferencias pref = Preferencias();
    final ayudaBloc = Provider.of<AyudaBloc>(context);
    final vehiculoBloc = Provider.of<VehiculoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar ' + vehiculoBloc.palabraClave),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ayudaBloc.ctrlFiltroV,
              textCapitalization: TextCapitalization.characters,
              onChanged: (valor) {
                ayudaBloc.filtroV = valor;
                if (!ayudaBloc.escribiendoV) {
                  ayudaBloc.escribiendoV = true;
                  Future.delayed(const Duration(seconds: 2))
                      .whenComplete(() async {
                    ayudaBloc.escribiendoV = false;
                    if (!ayudaBloc.escribiendoV) {
                      ayudaBloc.cargarListaVehiculos(pref.empresa);
                    }
                  });
                }
              },
              decoration: const InputDecoration(
                hintText: 'Buscar por placa',
                labelText: 'Buscar por placa',
                border: OutlineInputBorder(),
              ),
            ),
            ayudaBloc.escribiendoV
                ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  )
                : ayudaBloc.consultandoV
                    ? const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : Expanded(
                        child: ayudaBloc.vehiculos.isNotEmpty
                            ? ListView.builder(
                                itemCount: ayudaBloc.vehiculos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Vehiculo pro = ayudaBloc.vehiculos[index];
                                  return InkWell(
                                    onTap: () {
                                      vehiculoBloc.seleccionarVehiculo(
                                          context, pro);
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pro.vehPlaca,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              pro.marNombre +
                                                  " " +
                                                  pro.modNombre,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
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
