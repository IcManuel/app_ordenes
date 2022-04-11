import 'package:app_ordenes/domains/blocs/detalles_bloc.dart';
import 'package:app_ordenes/ui/widgets/detalle_formulario.dart';
import 'package:app_ordenes/ui/widgets/detalle_lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetallesPage extends StatelessWidget {
  const DetallesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detallesBloc = Provider.of<DetallesBloc>(context);
    return !detallesBloc.mostrarFormulario
        ? const DetalleLista()
        : const DetalleFormulario();
  }
}
