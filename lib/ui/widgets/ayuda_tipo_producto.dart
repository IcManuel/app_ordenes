import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/domains/blocs/nuevo_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:app_ordenes/models/tipo_producto_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaTipoProducto extends StatelessWidget {
  const AyudaTipoProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detallesbloc = Provider.of<DetallesBloc>(context);
    final nuevoBloc = Provider.of<NuevoBloc>(context);
    final size = MediaQuery.of(context).size;
    Preferencias pref = Preferencias();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar tipo de producto'),
        actions: [
          pref.usuario!.usuRol == 2
              ? IconButton(
                  onPressed: () {
                    nuevoBloc.abrirCrearTipo(context, size);
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
                      controller: detallesbloc.ctrlFiltroTipoProducto,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          detallesbloc.filtrarTipos(value);
                        } else {
                          detallesbloc.cargarTipos();
                        }
                      },
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      detallesbloc.abrirAyudaTipo(context, size, false);
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
            ),
            Expanded(
              child: detallesbloc.cargandoTipos == false
                  ? ListView.builder(
                      itemCount: detallesbloc.tiposFiltrados.length,
                      itemBuilder: (BuildContext context, int index) {
                        TipoProducto mod = detallesbloc.tiposFiltrados[index];
                        return ListTile(
                          title: Text(mod.tprNombre),
                          //subtitle: Text(mod.marNombre),
                          onTap: () {
                            detallesbloc.ctrlTipoProducto.text = mod.tprNombre;
                            detallesbloc.tipoSelect = mod;
                            //vehiculobloc.abrirAuydaModelo(context, size, false);
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
