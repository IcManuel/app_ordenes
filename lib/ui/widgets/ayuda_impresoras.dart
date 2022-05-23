import 'package:app_ordenes/domains/blocs/orden_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AyudaImpresora extends StatelessWidget {
  const AyudaImpresora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordenBloc = Provider.of<OrdenBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Conectar impresora'), actions: [
        IconButton(
          onPressed: () {
            //ordenBloc.scannear(context, false);
          },
          icon: Icon(Icons.refresh),
        ),
      ]),
    );
  }
}
