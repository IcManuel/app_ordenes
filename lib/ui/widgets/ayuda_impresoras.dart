import 'package:flutter/material.dart';

class AyudaImpresora extends StatelessWidget {
  const AyudaImpresora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final ordenBloc = Provider.of<OrdenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Conectar impresora'),
        actions: [
          IconButton(
            onPressed: () {
              //ordenBloc.emperzar();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      /**
      body: ListView.builder(
        itemCount: ordenBloc.devices.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(ordenBloc.devices[index].name!),
            subtitle: Text(ordenBloc.devices[index].address!),
            onTap: () {
              //ordenBloc.seleccionarImpresora(index, context);
            },
          );
        },
      ),
       */
    );
  }
}
