import 'dart:io';

import 'package:app_ordenes/domains/blocs/fotos_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FotoCapturadaWidget extends StatefulWidget {
  final String imagePath;
  final XFile file;
  final int tipo;

  // ignore: use_key_in_widget_constructors
  const FotoCapturadaWidget({
    required this.imagePath,
    required this.file,
    required this.tipo,
  });

  @override
  _FotoCapturadaWidgetState createState() => _FotoCapturadaWidgetState();
}

class _FotoCapturadaWidgetState extends State<FotoCapturadaWidget> {
  bool _cargando = false;

  @override
  Widget build(BuildContext context) {
    String texto = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
          const SizedBox(height: 10.0),
          Padding(
            child: ElevatedButton(
              child: (_cargando)
                  ? const Text('Guardando fotografía...')
                  : const Text('Aceptar'),
              onPressed: () async {
                setState(() {
                  _cargando = true;
                });

                final bloc = Provider.of<FotosBloc>(context, listen: false);
                bloc.anadirFotoSimple(
                  widget.file,
                  texto,
                  widget.tipo,
                );
                /*
                
                CardModel cart = CardModel(
                  id: 12,
                  imagen: widget.imagePath,
                );
                bloc.addCard(cart);
                //Provider.of<DetalleBloc>(context, listen: false).foto =
                //  widget.imagePath;
                */
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            padding: const EdgeInsets.all(12.0),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: OutlinedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
