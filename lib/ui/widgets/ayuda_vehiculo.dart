import 'package:app_ordenes/domains/blocs/lista_ordenes_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/models/vehiculo_model.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaVehiculo extends StatelessWidget {
  const AyudaVehiculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehiculobloc = Provider.of<VehiculoBloc>(context);
    final size = MediaQuery.of(context).size;
    final listaBloc = Provider.of<ListaOrdenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(vehiculobloc.palabraClave + ' ingresados'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0)),
                border: Border.all(),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Buscar',
                        hintStyle: TextStyle(fontSize: 20),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        fillColor: Colors.transparent,
                      ),
                      controller: vehiculobloc.ctrlFiltroMarca,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          vehiculobloc.filtrarVehiculos(value);
                        } else {
                          vehiculobloc.cargarVehiculos();
                        }
                      },
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: vehiculobloc.vehiculosClienteFiltrados.length,
                itemBuilder: (BuildContext context, int index) {
                  Vehiculo mod = vehiculobloc.vehiculosClienteFiltrados[index];
                  return ListTile(
                    title: Text(mod.vehPlaca),
                    leading: IconButton(
                      onPressed: () {
                        listaBloc.buscarHistorial(
                          context,
                          size,
                          mod.vehPlaca,
                        );
                        Navigator.pushNamed(context, 'ayuda_historial');
                      },
                      icon: Icon(
                        Icons.history,
                        color: colorPrincipal,
                      ),
                    ),
                    subtitle: Text(
                      mod.marNombre + " " + mod.modNombre,
                    ),
                    onTap: () {
                      vehiculobloc.seleccionarVehiculo(context, mod);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
