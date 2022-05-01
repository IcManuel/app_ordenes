import 'package:app_ordenes/domains/blocs/nuevo_bloc.dart';
import 'package:app_ordenes/domains/blocs/vehiculo_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/marca_model.dart';
import 'package:app_ordenes/models/modelo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaModelo extends StatelessWidget {
  const AyudaModelo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehiculobloc = Provider.of<VehiculoBloc>(context);
    final size = MediaQuery.of(context).size;
    final nuevoBloc = Provider.of<NuevoBloc>(context);
    Preferencias pref = Preferencias();
    print(pref.usuario!.pymes);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar modelo'),
        actions: [
          pref.usuario!.usuRol == 2 || pref.usuario!.pymes == true
              ? IconButton(
                  onPressed: () {
                    nuevoBloc.abrirCrearModelo(context, size);
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
            const SizedBox(
              height: 10,
            ),
            pref.usuario!.pymes == false
                ? Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: TextFormField(
                            controller: vehiculobloc.ctrlMarcaSelect,
                            readOnly: true,
                            enabled: false,
                            textCapitalization: TextCapitalization.characters,
                            decoration: const InputDecoration(
                              hintText: 'Marca',
                              labelText: 'Marca',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          onTap: () {
                            vehiculobloc.abrirAyudaMarca(context, size, true);
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          vehiculobloc.marcaSelect = Marca(
                              marId: -1,
                              eprId: -1,
                              marCodigo: "",
                              marNombre: "",
                              marActivo: false);
                          vehiculobloc.ctrlMarcaSelect.text = '';
                          vehiculobloc.abrirAuydaModelo(context, size, false);
                        },
                        icon: const Icon(Icons.close_sharp),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
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
                        hintText: 'Buscar por nombre',
                        hintStyle: TextStyle(fontSize: 16),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        fillColor: Colors.transparent,
                      ),
                      controller: vehiculobloc.ctrlFiltroModelo,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          vehiculobloc.filtrarModelos(value);
                        } else {
                          vehiculobloc.cargarModelos();
                        }
                      },
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      vehiculobloc.abrirAuydaModelo(context, size, false);
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
            ),
            Expanded(
              child: vehiculobloc.cargandoModelos == false
                  ? ListView.builder(
                      itemCount: vehiculobloc.modelosFiltrados.length,
                      itemBuilder: (BuildContext context, int index) {
                        Modelo mod = vehiculobloc.modelosFiltrados[index];
                        return ListTile(
                          title: Text(mod.modNombre),
                          subtitle: Text(mod.marNombre),
                          onTap: () {
                            vehiculobloc.modelo =
                                mod.marNombre + " " + mod.modNombre;
                            vehiculobloc.ctrlModelo.text =
                                mod.marNombre + " " + mod.modNombre;
                            vehiculobloc.modeloSelect = mod;
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
