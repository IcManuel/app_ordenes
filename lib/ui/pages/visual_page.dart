import 'package:app_ordenes/domains/blocs/visual_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/obs_visual_model.dart';
import 'package:app_ordenes/ui/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisualPage extends StatelessWidget {
  const VisualPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final visualBloc = Provider.of<VisualBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'OBSERVACIONES VISUALES DEL VEHÍCULO',
                style: TextStyle(
                  color: colorPrincipal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () async {
                  print('Entra');
                  await visualBloc
                      .cargarVisuales(Preferencias().usuario!.eprId);
                },
                icon: Icon(
                  Icons.refresh,
                  color: colorPrincipal,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          visualBloc.cargando == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: colorPrincipal.shade500),
                    ),
                    child: ListView.builder(
                      itemCount: visualBloc.lista.length,
                      itemBuilder: (BuildContext context, int index) {
                        ObsVisual mod = visualBloc.lista[index];
                        return Row(
                          children: [
                            SizedBox(
                              width: size.width * .20,
                              child: Checkbox(
                                value: visualBloc.lista[index].check,
                                onChanged: (e) {
                                  visualBloc.cambioCheck(index, e);
                                },
                              ),
                            ),
                            SizedBox(
                              child: InkWell(
                                child: Text(
                                  mod.obsNombre,
                                ),
                                onTap: () {
                                  visualBloc.cambioCheck(
                                      index, !visualBloc.lista[index].check);
                                },
                              ),
                              width: size.width * .50,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: visualBloc.ctrlObs,
            textCapitalization: TextCapitalization.characters,
            maxLines: 4,
            onChanged: (valor) {
              visualBloc.obsVisual = valor.toUpperCase();
            },
            decoration: const InputDecoration(
              hintText: 'Observaciones visuales',
              labelText: 'Observaciones visuales',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
