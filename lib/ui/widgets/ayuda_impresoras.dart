import 'package:flutter/material.dart';

class AyudaImpresora extends StatelessWidget {
  const AyudaImpresora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
