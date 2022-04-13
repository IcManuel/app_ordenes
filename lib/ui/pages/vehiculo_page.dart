import 'package:app_ordenes/domains/blocs/ayudas_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiculoPage extends StatelessWidget {
  const VehiculoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final vehiculobloc = Provider.of<VehiculoBloc>(context);
    final ayudaBloc = Provider.of<AyudaBloc>(context);
    return ListView(
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
                          'VEHÍCULOS REGSITRADOS',
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
                controller: vehiculobloc.ctrlPlaca,
                decoration: const InputDecoration(
                  labelText: 'Placa',
                  hintText: 'Placa',
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
                ayudaBloc.abrirAyudaVehiculo(context, vehiculobloc.placa);
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
            vehiculobloc.abrirAuydaModelo(context, size, true);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: vehiculobloc.ctrlColor,
          textCapitalization: TextCapitalization.characters,
          onChanged: (valor) {
            vehiculobloc.color = valor.toUpperCase();
          },
          decoration: const InputDecoration(
            hintText: 'Color',
            labelText: 'Color',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: vehiculobloc.ctrlAnio,
          textCapitalization: TextCapitalization.characters,
          onChanged: (valor) {
            vehiculobloc.anio = int.parse(valor);
          },
          decoration: const InputDecoration(
            hintText: 'Año',
            labelText: 'Año',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: vehiculobloc.ctrlKilometraje,
          keyboardType: TextInputType.number,
          onChanged: (valor) {
            if (double.tryParse(valor) != null) {
              vehiculobloc.kilometraje = double.parse(valor.toUpperCase());
            }
          },
          decoration: const InputDecoration(
            hintText: 'Kilometraje',
            labelText: 'Kilometraje',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
