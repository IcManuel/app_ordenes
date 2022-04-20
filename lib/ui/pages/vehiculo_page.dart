import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/models/caracteristica_model.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiculoPage extends StatelessWidget {
  const VehiculoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final vehiculobloc = Provider.of<VehiculoBloc>(context);
    final ordenbloc = Provider.of<OrdenBloc>(context, listen: false);
    final ayudaBloc = Provider.of<AyudaBloc>(context);
    return Column(
      children: [
        SizedBox(
          height: vehiculobloc.vehiculosCliente.isNotEmpty
              ? size.height * 0.30
              : size.height * 0.22,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              vehiculobloc.vehiculosCliente.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * .005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              vehiculobloc.cargarVehiculos();
                              Navigator.pushNamed(context, 'ayuda_vehiculo');
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(size.height * 0.02),
                              child: Text(
                                vehiculobloc.palabraClave + ' REGISTRADOS',
                                style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (valor) {
                        vehiculobloc.cambioPlaca(valor);
                      },
                      enabled: !ordenbloc.modificar,
                      controller: vehiculobloc.ctrlPlaca,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: vehiculobloc.identificador,
                        hintText: vehiculobloc.identificador,
                        border: const OutlineInputBorder(),
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
                        ayudaBloc.abrirAyudaVehiculo(
                            context, vehiculobloc.placa);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                child: TextFormField(
                  controller: vehiculobloc.ctrlModelo,
                  readOnly: true,
                  enabled: false,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    hintText: 'Modelo',
                    labelText: 'Modelo',
                    border: OutlineInputBorder(),
                  ),
                ),
                onTap: () {
                  if (ordenbloc.modificar == false) {
                    vehiculobloc.abrirAuydaModelo(context, size, true);
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Características',
          style: TextStyle(
            color: colorPrincipal,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        vehiculobloc.cargando
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 15,
                    ),
                    child: ListView.builder(
                      itemCount: vehiculobloc.lista.length,
                      itemBuilder: (BuildContext context, int index) {
                        Caracteristica mod = vehiculobloc.lista[index];
                        return Row(
                          children: [
                            SizedBox(
                              width: size.width * .90,
                              height: size.height * 0.10,
                              child: TextField(
                                controller: TextEditingController(
                                  text: mod.valor,
                                ),
                                enabled: !ordenbloc.modificar,
                                keyboardType: mod.carTipo == 1
                                    ? TextInputType.number
                                    : TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.characters,
                                onChanged: (valor) {
                                  vehiculobloc.lista[index].valor =
                                      valor.toUpperCase();
                                },
                                decoration: InputDecoration(
                                  hintText: mod.carNombre,
                                  labelText: mod.carNombre,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
