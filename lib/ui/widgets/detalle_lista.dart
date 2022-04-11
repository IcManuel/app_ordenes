import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/ui/widgets/boton_principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalleLista extends StatelessWidget {
  const DetalleLista({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final detallesBloc = Provider.of<DetallesBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BotonPrincipal(
            onPressed: () {
              print('0');
              detallesBloc.abrirNuevoDetalle();
            },
            label: "AGREGAR PRODUCTO/SERVICIO",
            size: size,
          ),
        ],
      ),
    );
  }
}
