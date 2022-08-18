import 'package:app_ordenes/domains/blocs/perfil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:provider/provider.dart';

class FirmaUsuarioPage extends StatelessWidget {
  const FirmaUsuarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordenBloc = Provider.of<PerfilBloc>(context);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Text(''),
          title: Text('Firmar'),
          centerTitle: true,
          actions: [],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.blue,
                  onPressed: () async {
                    ordenBloc.guardarFirma(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.undo),
                  color: Colors.blue,
                  onPressed: () {
                    ordenBloc.controller.undo();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.redo),
                  color: Colors.blue,
                  onPressed: () {
                    ordenBloc.controller.redo();
                  },
                ),
                //CLEAR CANVAS
                IconButton(
                  icon: const Icon(Icons.clear),
                  color: Colors.blue,
                  onPressed: () {
                    ordenBloc.limpiarFirma();
                  },
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Signature(
              controller: ordenBloc.controller,
              backgroundColor: Colors.grey[300]!,
              height: 250,
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
