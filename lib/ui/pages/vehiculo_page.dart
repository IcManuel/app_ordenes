import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
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
    final listaBloc = Provider.of<ListaOrdenBloc>(context, listen: false);
    final ayudaBloc = Provider.of<AyudaBloc>(context);
    bool defecto = Preferencias().usuario!.vehPorDefecto != null &&
            Preferencias().usuario!.vehPorDefecto!.trim().length > 0
        ? true
        : false;
    return Scaffold(
      body: defecto
          ? Center(
              child: Text('Sin información'),
            )
          : Column(
              children: [
                SizedBox(
                  height: vehiculobloc.vehiculosCliente.isNotEmpty
                      ? size.height * 0.30
                      : size.height * 0.23,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        vehiculobloc.vehiculosCliente.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02,
                                    vertical: size.height * .005),
                                child: AyudaVehiculoWidget(
                                  vehiculobloc: vehiculobloc,
                                  size: size,
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        AyudaPlaca(
                          vehiculobloc: vehiculobloc,
                          ordenbloc: ordenbloc,
                          ayudaBloc: ayudaBloc,
                          listaBloc: listaBloc,
                          size: size,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AyudaModelo(
                          vehiculobloc: vehiculobloc,
                          ordenbloc: ordenbloc,
                          size: size,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Características',
                    style: TextStyle(
                      color: colorPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vehiculobloc.lista.length,
                    itemBuilder: (BuildContext context, int index) {
                      Caracteristica mod = vehiculobloc.lista[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: SizedBox(
                          width: size.width * .72,
                          height: size.height * 0.10,
                          child: mod.carSeleccionadble
                              ? InkWell(
                                  child: TextField(
                                    controller: TextEditingController(
                                      text: mod.valor,
                                    ),
                                    readOnly: true,
                                    enabled: false,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    decoration: InputDecoration(
                                      hintText: mod.carNombre,
                                      labelText: mod.carNombre,
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  onTap: () {
                                    if (ordenbloc.modificar == false) {
                                      vehiculobloc.abrirAyudaLista(
                                          index, context, size);
                                    }
                                  },
                                )
                              : TextField(
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
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class AyudaModelo extends StatelessWidget {
  const AyudaModelo({
    Key? key,
    required this.vehiculobloc,
    required this.ordenbloc,
    required this.size,
  }) : super(key: key);

  final VehiculoBloc vehiculobloc;
  final OrdenBloc ordenbloc;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}

class AyudaPlaca extends StatelessWidget {
  const AyudaPlaca({
    Key? key,
    required this.vehiculobloc,
    required this.ordenbloc,
    required this.ayudaBloc,
    required this.listaBloc,
    required this.size,
  }) : super(key: key);

  final VehiculoBloc vehiculobloc;
  final OrdenBloc ordenbloc;
  final AyudaBloc ayudaBloc;
  final ListaOrdenBloc listaBloc;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                if (ordenbloc.modificar == false) {
                  ayudaBloc.abrirAyudaVehiculo(context, vehiculobloc.placa);
                }
              },
            ),
            vehiculobloc.idVehiculo != -1
                ? IconButton(
                    onPressed: () {
                      listaBloc.buscarHistorial(
                          context, size, vehiculobloc.placa);
                      Navigator.pushNamed(context, 'ayuda_historial');
                    },
                    icon: Icon(
                      Icons.history,
                      color: colorPrincipal,
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}

class AyudaVehiculoWidget extends StatelessWidget {
  const AyudaVehiculoWidget({
    Key? key,
    required this.vehiculobloc,
    required this.size,
  }) : super(key: key);

  final VehiculoBloc vehiculobloc;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            padding: EdgeInsets.all(size.height * 0.01),
            child: Text(
              vehiculobloc.palabraClave + ' REGISTRADOS',
              style:
                  TextStyle(fontSize: size.height * 0.015, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
