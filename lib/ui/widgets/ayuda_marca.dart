import 'package:app_ordenes/domains/blocs/nuevo_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/marca_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaMarca extends StatelessWidget {
  const AyudaMarca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehiculobloc = Provider.of<VehiculoBloc>(context);
    final nuevoBloc = Provider.of<NuevoBloc>(context);
    final size = MediaQuery.of(context).size;
    Preferencias pref = Preferencias();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar marca'),
        actions: [
          pref.usuario!.usuRol == 2
              ? IconButton(
                  onPressed: () {
                    nuevoBloc.abrirCrearMarca(context, size);
                  },
                  icon: const Icon(
                    Icons.add_circle_rounded,
                  ),
                )
              : Container()
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
                      controller: vehiculobloc.ctrlFiltroMarca,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          vehiculobloc.filtrarMarcas(value);
                        } else {
                          vehiculobloc.cargarMarcas();
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
              child: vehiculobloc.cargandoMarcas == false
                  ? ListView.builder(
                      itemCount: vehiculobloc.marcasFiltradas.length,
                      itemBuilder: (BuildContext context, int index) {
                        Marca mod = vehiculobloc.marcasFiltradas[index];
                        return ListTile(
                          title: Text(mod.marNombre),
                          //subtitle: Text(mod.marNombre),
                          onTap: () {
                            vehiculobloc.ctrlMarcaSelect.text = mod.marNombre;
                            vehiculobloc.marcaSelect = mod;
                            vehiculobloc.abrirAuydaModelo(context, size, false);
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
