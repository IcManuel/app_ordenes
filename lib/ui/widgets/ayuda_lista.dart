import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/lista_caracteristica_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaLista extends StatelessWidget {
  const AyudaLista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehiculobloc = Provider.of<VehiculoBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar '),
        actions: [
          Preferencias().usuario!.pymes == true
              ? IconButton(
                  onPressed: () {
                    vehiculobloc.abrirCrearLista(context, size);
                  },
                  icon: const Icon(
                    Icons.add_circle_rounded,
                  ),
                )
              : Container(),
        ],
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
                      controller: vehiculobloc.ctrlFiltroLista,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          vehiculobloc.filtrarLista(value);
                        } else {
                          vehiculobloc.cargarLista();
                        }
                      },
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      vehiculobloc.abrirAyudaMarca(context, size, false);
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
            ),
            Expanded(
              child: vehiculobloc.cargando == false
                  ? ListView.builder(
                      itemCount: vehiculobloc.listadoCFiltrados.length,
                      itemBuilder: (BuildContext context, int index) {
                        ListaCaracteristica mod =
                            vehiculobloc.listadoCFiltrados[index];
                        return ListTile(
                          title: Text(mod.calNombre),
                          //subtitle: Text(mod.marNombre),
                          onTap: () {
                            vehiculobloc.seleccionarAyudaLista(mod);
                            Navigator.pop(context);
                          },
                        );
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
